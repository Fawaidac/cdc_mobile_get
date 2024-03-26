import 'dart:convert';

import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/modules/setting/views/add_education_user_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class KartuAlumniController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUser();
    print("object");
  }

  var fullname = "".obs;
  var isLoading = false.obs;

  Future<void> launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      Get.snackbar("Error", "Tidak bisa mengunjungi situs",
          margin: const EdgeInsets.all(10));
    }
  }

  Future<void> getUser() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception("Token not found");
      }

      final response =
          await http.get(Uri.parse('${ApiServices.baseUrl}/user'), headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['data']['user'];
        fullname.value = jsonData['fullname'];
      } else {
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }
}
