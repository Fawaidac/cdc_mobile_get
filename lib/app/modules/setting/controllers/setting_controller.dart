import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  static Future<Map<String, dynamic>> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final res = await http
        .post(Uri.parse('${ApiServices.baseUrl}/user/logout'), headers: {
      "Authorization": "Bearer $token",
    });
    final data = jsonDecode(res.body);
    return data;
  }
}
