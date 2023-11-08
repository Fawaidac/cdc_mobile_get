import 'dart:convert';

import 'package:cdc/app/data/models/post_model.dart';
import 'package:cdc/app/modules/detail_alumni/controllers/post_controller.dart';
import 'package:cdc/app/modules/home/controllers/post_item_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  ScrollController scrollController = ScrollController();
  final search = TextEditingController();
  // var postList = <PostAllModel>[].obs;
  RxList<PostAllModel> postList = <PostAllModel>[].obs;

  int page = 1;
  int totalPage = 1;
  int lastLoadedPage = 0;


  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (page < totalPage) {
        page = page + 1;

        Get.find<PostItemController>().fetchData();
      }
    }
  }

  void onChangeSearch(String value) {
    searchData(value);
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Future<void> sendComment(String id, String message) async {
    final response = await storeComment(id, message);
    if (response['code'] == 201) {
      postList.clear();
      Get.snackbar("Success", "Berhasil mengomentari postingan",
          margin: const EdgeInsets.all(10));
      postList.refresh();

      Get.find<PostItemController>().fetchData();
      Get.offAllNamed(Routes.HOMEPAGE);
    } else {
      Get.snackbar("Error", response['message'],
          margin: const EdgeInsets.all(10));
    }
  }

  Future<void> handleDeleteComment(String idComment, String idPost) async {
    final response = await deleteComment(idPost, idComment);
    if (response['code'] == 200) {
      postList.clear();
      Get.snackbar("Success", "Berhasil menghapus postingan",
          margin: const EdgeInsets.all(10));
      postList.refresh();
      Get.find<PostItemController>().fetchData();
      Get.offAllNamed(Routes.HOMEPAGE);
    } else {
      Get.snackbar("Error", response['message'],
          margin: const EdgeInsets.all(10));
    }
  }

  static Future<Map<String, dynamic>> storeComment(
      String postId, String comment) async {
    final Map<String, dynamic> requestBody = {
      "comment": comment,
      "post_id": postId
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
        Uri.parse('${ApiServices.baseUrl}/user/post/comment'),
        body: jsonEncode(requestBody),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> deleteComment(
      String postID, String commentID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.delete(
      Uri.parse('${ApiServices.baseUrl}/user/post/comment'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'post_id': postID,
        'comment_id': commentID,
      }),
    );

    final data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> getData(int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/user/post?page=$page'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final Map<String, dynamic> data = jsonResponse['data'];
        return data;
      } else {
        throw Exception("Failed to fetch data ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return {
        "postList": [],
        "totalPage": 0,
        "totalItem": 0,
      };
    }
  }

  static Future<List<PostAllModel>> searchData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final response = await http.post(
        Uri.parse('${ApiServices.baseUrl}/user/post/search'),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'key': key}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          final List<dynamic> data = jsonResponse['data'];

          List<PostAllModel> posts =
              data.map((postJson) => PostAllModel.fromJson(postJson)).toList();

          return posts;
        } else {
          throw Exception("Response does not contain data");
        }
      } else {
        throw Exception("Failed to fetch data ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }
}
