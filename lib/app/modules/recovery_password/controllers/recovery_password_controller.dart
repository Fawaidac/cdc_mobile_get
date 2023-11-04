import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecoveryPasswordController extends GetxController {
  final loading = false.obs;
  var email = TextEditingController();

  Future<void> checkRecovery() async {
    if (email.text.isEmpty) {
      Get.snackbar("Error", "Email harus diisi",
          margin: const EdgeInsets.all(10));
    } else {
      try {
        loading(true);
        final response = await recovery(email.text);
        if (response['code'] == 200) {
          Get.snackbar("Success", response['message'],
              margin: const EdgeInsets.all(10));
        } else {
          Get.snackbar("Error", response['message']);
        }
      } catch (e) {
        print("Error: $e");
        Get.snackbar("Error", "Terjadi kesalahan saat recovery password");
      } finally {
        loading(false);
      }
    }
  }

  static Future<Map<String, dynamic>> recovery(String email) async {
    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/auth/recovery'),
      body: {
        'email': email,
      },
    );
    final data = jsonDecode(response.body);
    return data;
  }
}
