import 'dart:convert';

import 'package:cdc/app/data/models/post_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getUser();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // await prefs.remove('id_user');

    String url = '${ApiServices.baseUrl}/user';

    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prefs.setString('id_user', json['data']['user']['id']);
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
      print("IDDD : " + prefs.getString('id_user').toString());
    }
  }

  final search = TextEditingController();

  void onChangeSearch(String value) {
    searchData(value);
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
