import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  RxInt currentPage = 1.obs;
  RxInt totalPage = 1.obs;
  int lastLoadedPage = 0;

  RxList postList = <dynamic>[].obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }

  Future<void> scrollListener(String id) async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('call');
      if (currentPage.value < totalPage.value) {
        currentPage.value = currentPage.value + 1;
        fetchData(id);
      }
    } else {
      print('dont call');
    }
  }

  Future<void> fetchData(String user) async {
    String url =
        '${ApiServices.baseUrl}/user/post/detail/$user?page=${currentPage.value}';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final dataPost = data['data']['posts'] as List;
      final datatotalPage = data['data']['pagination']['total_page'];

      if (currentPage.value > lastLoadedPage) {
        postList.addAll(dataPost);
        lastLoadedPage = currentPage.value;
      }
      totalPage.value = datatotalPage;
    } else {
      print('error');
    }
  }
}
