import 'dart:convert';

import 'package:cdc/app/data/models/comment_model.dart';
import 'package:cdc/app/data/models/post_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PostUserController extends GetxController {
  int currentPage = 1;
  int totalPage = 1;
  int lastLoadedPage = 0;
  RxList<PostUser> postList = <PostUser>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('call');
      if (currentPage < totalPage) {
        currentPage = currentPage + 1;
        fetchData();
      }
    } else {
      print('dont call');
    }
  }

  Future<void> fetchData() async {
    try {
      // postList.clear();
      final data = await fetchDataPostUser(currentPage);
      print('datauser : $data');

      if (data != null) {
        totalPage = data['pagination']['total_page'];
        final List<PostUser> postUserList = (data['posts'] as List)
            .map((post) => PostUser.fromJson(post))
            .toList();

        if (currentPage > lastLoadedPage) {
          postList.addAll(postUserList); // Append new data to existing data
          lastLoadedPage = currentPage; // Update the last loaded page
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<Map<String, dynamic>> fetchDataPostUser(int page) async {
    try {
      String url = '${ApiServices.baseUrl}/user/post/login?page=$page';
      print(url);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }
      final response = await http.get(
        Uri.parse(url),
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
      print(e.toString());
      return {
        "postList": [],
        "totalPage": 0,
        "totalItem": 0,
      };
    }
  }
}
