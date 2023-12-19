import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_dialog.dart';

class InformationController extends GetxController {
  RxList<Map<String, dynamic>> informationList = <Map<String, dynamic>>[].obs;
  Future<void> fetchInformationsData() async {
    final data = await getInformatios();
    informationList.assignAll(data ?? []);
  }

  Future<List<Map<String, dynamic>>?> getInformatios() async {
    final Uri url = Uri.parse('${ApiServices.baseUrl}/informations');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(jsonResponse['data']);

        return data;
      } else if (response.statusCode == 401) {
        AppDialog.show(
          title: "Error !",
          isTouch: false,
          desc: "Ops , sesi anda telah habis , silahkan login ulang",
          onOk: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.remove('token');
            preferences.remove('tokenExpirationTime');

            Get.offAllNamed(Routes.LOGIN);
            Get.snackbar("Success", "Berhasil keluar dari aplikasi",
                margin: const EdgeInsets.all(10));
          },
          onCancel: () {
            Get.back();
          },
        );
      } else {
        print('Failed to fetch news: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching news: $e');
      return null;
    }
    return null;
  }
}
