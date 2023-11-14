import 'dart:convert';

import 'package:cdc/app/data/models/post_model.dart';
import 'package:cdc/app/modules/home/controllers/home_controller.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PostItemController extends GetxController {
  RxList<PostAllModel> postList = <PostAllModel>[].obs;

  int page = 1;
  int totalPage = 1;
  int lastLoadedPage = 0;
  bool hasMore = false;
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

  Future<void> fetchData() async {
    try {
      hasMore = true;
      final data = await getData(page);
      // ignore: unnecessary_type_check
      if (data is Map<String, dynamic>) {
        if (data.containsKey('total_page')) {
          totalPage = data['total_page'];
        }
        final List<PostAllModel> newPosts =
            data.keys.where((key) => int.tryParse(key) != null).map((key) {
          return PostAllModel.fromJson(data[key]);
        }).toList();
        if (totalPage == page) {
          hasMore = false;
          print('hasmore false');
        }
        if (page > lastLoadedPage) {
          postList.addAll(newPosts);
          lastLoadedPage = page;
        }
      } else {
        print("Response data is not in the expected format.");
      }
    } catch (e) {
      print("Error fetching data: $e");
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
