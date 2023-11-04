import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends GetxController {
  RxList<Map<String, dynamic>> newsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNewsData();
  }

  Future<void> fetchNewsData() async {
    final data = await getNews();
    newsList.assignAll(data ?? []);
  }

  static Future<List<Map<String, dynamic>>?> getNews() async {
    final Uri url = Uri.parse('${ApiServices.baseUrl}/user/news');
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
      } else {
        print('Failed to fetch news: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching news: $e');
      return null;
    }
  }
}
