import 'dart:convert';

import 'package:cdc/app/data/models/followers_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailAlumniController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var idUser = "";

  late TabController tabController;
  Rx<UserDetail> userDetail = UserDetail().obs;
  RxInt followerCount = 0.obs;
  RxInt followedCount = 0.obs;
  RxInt postCount = 0.obs;

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

  void handleUser(String id) {
    fetchDetailUser(id).then((user) {
      userDetail.value = user;
    }).catchError((error) {
      print('Failed to fetch user followers: $error');
    });
  }

  void handleFollownUnfollow(String idUser) async {
    if (userDetail.value.user!.isFollow == true) {
      handleUnfollow(idUser);
    } else {
      handleFollow(idUser);
    }
  }

  void handleFollow(String idUser) async {
    try {
      final response = await followUser(idUser);
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        handleUser(idUser);
        update();
      } else {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    }
  }

  void handleUnfollow(String idUser) async {
    try {
      final response = await unfollowUser(idUser);
      if (response['code'] == 200) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));

        handleUser(idUser);
        update();
      } else {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchFollowerCount(String id) async {
    try {
      final apiResponse = await fetchUserFollowers(id);
      final apiResponse2 = await fetchUserFollowed(id);
      final apiResponse3 = await fetchDataPostById(id);

      followerCount.value = apiResponse.totalFollowers;
      followedCount.value = apiResponse2.totalFollowers;
      postCount.value = apiResponse3.totalItem;
    } catch (e) {
      print('Error fetching follower count: $e');
    }
  }

  static Future<Map<String, dynamic>> followUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http
        .post(Uri.parse('${ApiServices.baseUrl}/user/followers'), body: {
      "user_id": userId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<UserDetail> fetchDetailUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${ApiServices.baseUrl}/user/detail/$userId'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        return UserDetail.fromJson(jsonResponse['data']);
      } else {
        throw Exception(
            'Failed to fetch user details: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch user details. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> unfollowUser(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http
        .delete(Uri.parse('${ApiServices.baseUrl}/user/followers'), body: {
      "user_id": userId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<UserFollowersInfo> fetchUserFollowers(String userId) async {
    final String url = '${ApiServices.baseUrl}/user/followers/$userId';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final int totalFollowers = data['data']['total_followers'];
      final User user = User.fromJson(data['data']['user']);
      List<Follower> followers = [];
      if (data['data']['user']['followers'] != null) {
        data['data']['user']['followers'].forEach((followerData) {
          followers.add(Follower.fromJson(followerData));
        });
      }

      return UserFollowersInfo(
          totalFollowers: totalFollowers, user: user, followers: followers);
    } else {
      throw Exception('Failed to fetch followers');
    }
  }

  static Future<UserFollowedInfo> fetchUserFollowed(String userId) async {
    final String url = '${ApiServices.baseUrl}/user/followed/$userId';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final int totalFollowers = data['data']['total_followers'];
      final User user = User.fromJson(data['data']['user']);
      List<Follower> followed = [];
      if (data['data']['user']['followed'] != null) {
        data['data']['user']['followed'].forEach((followerData) {
          followed.add(Follower.fromJson(followerData));
        });
      }

      return UserFollowedInfo(
          totalFollowers: totalFollowers, user: user, followed: followed);
    } else {
      throw Exception('Failed to fetch followers');
    }
  }

  static Future<PostDetail> fetchDataPostById(String userId,
      {int? page}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }
    String url = '${ApiServices.baseUrl}/user/post/detail/$userId';
    if (page != null) {
      url += '&page=$page';
    }
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      return PostDetail.fromJson(data['data']);
    } else {
      throw Exception('Failed to load data : ${data['message']}');
    }
  }

  Future<void> launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      Get.snackbar("Error", "Tidak bisa mengunjungi situs",
          margin: const EdgeInsets.all(10));
    }
  }
}
