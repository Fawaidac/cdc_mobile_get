import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsController extends GetxController {
  RxList notifications = <dynamic>[].obs;

  Future<void> fetchNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/user/notifications'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        notifications.value = jsonResponse['notifications'];
      } else {
        notifications.value = [];
        print(
            'Gagal mengambil data notifikasi. Kode status: ${response.statusCode}');
      }
    } catch (e) {
      notifications.value = [];
      print('Terjadi kesalahan: $e');
    }
  }
}
