import 'dart:convert';

import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var showPassword = true.obs;
  var loading = false.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<void> checkLogin(String nik, String password) async {
    if (nik.isEmpty) {
      Get.snackbar("Error", "Email atau NIK harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (password.isEmpty) {
      Get.snackbar("Error", "Password harus diisi",
          margin: const EdgeInsets.all(10));
    } else {
      try {
        loading(true);
        final response = await login(nik, password);
        if (response['code'] == 200) {
          print(response);
          Get.snackbar("Success", "Login berhasil",
              margin: const EdgeInsets.all(10));
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', response['data']['token']);

          DateTime expirationTime = DateTime.now().add(const Duration(days: 7));
          prefs.setInt(
              'tokenExpirationTime', expirationTime.millisecondsSinceEpoch);
          Get.offAllNamed(Routes.HOMEPAGE);
        } else {
          Get.snackbar("Error", response['message']);
        }
      } catch (e) {
        print("Error: $e");
        Get.snackbar("Error", "Terjadi kesalahan saat login");
      } finally {
        loading(false);
      }
    }
  }

  static Future<Map<String, dynamic>> login(
      String emailOrNik, String password) async {
    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/auth/login'),
      // Uri.parse('http://cdc.polije.ac.id/api/auth/login'),
      body: {
        'emailOrNik': emailOrNik,
        'password': password,
      },
    );
    final data = jsonDecode(response.body);
    return data;
  }
}
