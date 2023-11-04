import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TopAlumniController extends GetxController {
  RxList<Map<String, dynamic>> topFollowerList = <Map<String, dynamic>>[].obs;
  var isLoadingFoll = true.obs;

  Future<void> assignTopFollowerData() async {
    final data = await fetchTopFollower();
    topFollowerList.assignAll(data ?? []);
    update();
  }

  Future<List<Map<String, dynamic>>?> fetchTopFollower() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '${ApiServices.baseUrl}/user/ranking/followers';

    try {
      isLoadingFoll(true);
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          final List<Map<String, dynamic>> dataList =
              List<Map<String, dynamic>>.from(jsonResponse['data']);

          List<Map<String, dynamic>> userList = [];

          for (var data in dataList) {
            final Map<String, dynamic> userResponse = data;
            List<Map<String, dynamic>> followers =
                data['followers'].cast<Map<String, dynamic>>();
            userResponse['followers'] = followers;
            userList.add(userResponse);
          }

          return userList;
        } else {
          print('Failed to fetch users');
        }
      } else {
        print('Failed to load data ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoadingFoll(false);
    }

    return null;
  }

  @override
  void onInit() {
    super.onInit();

    assignTopFollowerData();
  }
}
