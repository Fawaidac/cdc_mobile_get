import 'dart:convert';

import 'package:cdc/app/data/models/post_model.dart';
import 'package:cdc/app/modules/home/controllers/home_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostItemController extends GetxController {
  Future<void> fetchData() async {
    try {
      final data = await Get.find<HomeController>()
          .getData(Get.find<HomeController>().page);
      print('object');
      // ignore: unnecessary_type_check
      if (data is Map<String, dynamic>) {
        if (data.containsKey('total_page')) {
          Get.find<HomeController>().totalPage = data['total_page'];
        }
        final List<PostAllModel> newPosts =
            data.keys.where((key) => int.tryParse(key) != null).map((key) {
          return PostAllModel.fromJson(data[key]);
        }).toList();

        Get.find<HomeController>().postList.addAll(newPosts);
      } else {
        print("Response data is not in the expected format.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  static Future<Map<String, dynamic>> getData(int page) async {
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
}
