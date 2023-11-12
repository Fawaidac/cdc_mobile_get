import 'dart:convert';

import 'package:cdc/app/data/models/salary_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TopAlumniController extends GetxController {
  RxList<Map<String, dynamic>> topFollowerList = <Map<String, dynamic>>[].obs;
  RxList<UserProfile> topSalaryUsers = <UserProfile>[].obs;

  var isLoadingFoll = true.obs;
  var isLoadingSal = true.obs;

  Future<void> assignTopFollowerData() async {
    final data = await fetchTopFollower();
    topFollowerList.assignAll(data ?? []);
  }

  Future<void> assignTopSallaryData() async {
    final data = await fetchTopSalary();
    if (data.isNotEmpty) {
      topSalaryUsers.assignAll(data);
    } else {
      print('error');
    }
  }

  Future<List<Map<String, dynamic>>?> fetchTopFollower() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '${ApiServices.baseUrl}/user/ranking/followers';

    try {
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
    }

    return null;
  }

  Future<List<UserProfile>> fetchTopSalary() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '${ApiServices.baseUrl}/user/ranking/salary';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == true) {
          final List<dynamic> dataList = jsonResponse['data'];

          if (dataList.isNotEmpty) {
            List<UserProfile> userProfiles = [];
            for (var userData in dataList) {
              userProfiles.add(
                UserProfile(
                  fullname: userData['fullname'],
                  lastPosition: userData['last_position'],
                  highestSalary: userData['highest_salary'],
                  company: userData['company'],
                ),
              );
            }
            return userProfiles;
          } else {
            print('No data available');
          }
        } else {
          print('Failed to fetch user data');
        }
      } else {
        print('Failed to load data ${response.statusCode}');
      }

      return []; // Return an empty list when no data is available
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list in case of an error
    }
  }
}
