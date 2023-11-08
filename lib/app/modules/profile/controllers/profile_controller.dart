import 'dart:convert';

import 'package:cdc/app/data/models/comment_model.dart';
import 'package:cdc/app/data/models/followers_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  Rx<User> user = User().obs;
  RxInt followerCount = 0.obs;
  RxInt followedCount = 0.obs;
  RxInt postCount = 0.obs;

  Future<void> getUser() async {
    final auth = await userInfo();
    if (auth != null) {
      user.value = auth;
      print("ok");
    }
  }

  Future<void> fetchPostCount() async {
    try {
      final apiResponse = await getPostUserLogin();
      final data = apiResponse;

      postCount.value = data['total_item'];
    } catch (e) {
      print('Error fetching post count: $e');
      // Handle errors if needed
    }
  }

  Future<void> fetchFollowerCount() async {
    try {
      final apiResponse = await getFollowers();

      followerCount.value = apiResponse.totalFollowers;
    } catch (e) {
      print('Error fetching follower count: $e');
      // Handle errors if needed
    }
  }

  Future<void> fetchFollowedCount() async {
    try {
      final apiResponse = await getFollowed();

      followedCount.value = apiResponse.totalFollowers;
    } catch (e) {
      print('Error fetching follower count: $e');
      // Handle errors if needed
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tabController.dispose();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   tabController.dispose();
  // }

  static Future<User?> userInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final response =
          await http.get(Uri.parse('${ApiServices.baseUrl}/user/'), headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data']['user'];
        final user = User.fromJson(jsonData);
        prefs.setString('data', json.encode(jsonData));

        return user;
      } else {
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  static Future<Map<String, dynamic>> getPostUserLogin({int? page}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }
      String url = '${ApiServices.baseUrl}/user/post/login';
      if (page != null) {
        url += '&page=$page';
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonResponse['data'];
        final int totalItems = data['pagination']['total_item'];
        final int totalPage = data['pagination']['total_page'];
        final List<Map<String, dynamic>> postList =
            (data['posts'] as List).map((postData) {
          final Map<String, dynamic> postMap = postData as Map<String, dynamic>;
          final List<Map<String, dynamic>> commentsData =
              postMap['comments'].cast<Map<String, dynamic>>();
          List<CommentModel> comments = commentsData
              .map((commentData) => CommentModel.fromJson(commentData))
              .toList();
          postMap['comments'] = comments;
          return postMap;
        }).toList();

        return {
          'data': postList,
          'total_page': totalPage,
          'total_item': totalItems
        };
      } else {
        throw Exception("Failed to fetch data ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return Future.value({'data': [], 'total_page': 0, 'total_item': 0});
    }
  }

  static Future<FollowersModel> getFollowers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
          Uri.parse('${ApiServices.baseUrl}/user/followers'),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final int totalFollowers = data['data']['total_followers'];
        List<Follower> followers = [];
        if (data['data']['followers'] != null) {
          data['data']['followers'].forEach((followerData) {
            followers.add(Follower.fromJson(followerData));
          });
        }
        return FollowersModel(
            totalFollowers: totalFollowers, followers: followers);
      } else {
        throw Exception('Failed to fetch followers data');
      }
    } catch (e) {
      print('Error fetching followers: $e');
      throw e;
    }
  }

  static Future<FollowedModel> getFollowed() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
          Uri.parse('${ApiServices.baseUrl}/user/followed'),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final int totalFollowers = data['data']['total_followers'];
        List<Follower> followers = [];
        if (data['data']['user']['followed'] != null) {
          data['data']['user']['followed'].forEach((followerData) {
            followers.add(Follower.fromJson(followerData));
          });
        }
        return FollowedModel(
            totalFollowers: totalFollowers, followed: followers);
      } else {
        throw Exception('Failed to fetch followed data');
      }
    } catch (e) {
      print('Error fetching followed data: $e');
      throw e;
    }
  }
}
