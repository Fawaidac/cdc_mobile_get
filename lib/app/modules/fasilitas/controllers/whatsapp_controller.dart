import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WhatsappController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> grupWhatsAppList = <Map<String, dynamic>>[].obs;

  Future<void> fetchGrupWhatsAppData() async {
    try {
      final data = await fetchDataGrupWhatsApp();
      isLoading.value = false;
      grupWhatsAppList.clear();
      grupWhatsAppList.refresh();
      if (data['data'] != null && data['data'] is List) {
        grupWhatsAppList
            .assignAll(List<Map<String, dynamic>>.from(data['data']));
      }
      update();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  static Future<Map<String, dynamic>> fetchDataGrupWhatsApp() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http
        .get(Uri.parse('${ApiServices.baseUrl}/user/whatsapp'), headers: {
      "Authorization": "Bearer $token",
    });
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchGrupWhatsAppData();
  }
}
