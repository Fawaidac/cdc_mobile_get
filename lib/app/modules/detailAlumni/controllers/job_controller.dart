import 'dart:convert';

import 'package:cdc/app/data/models/jobs_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobController extends GetxController {
  final RxList<JobsModel> jobs = RxList<JobsModel>();

  void fetchData(String userId) async {
    try {
      final result = await fetchJobs(userId);
      jobs.assignAll(result);
    } catch (e) {
      print('Error fetching education details: $e');
    }
  }

  Future<List<JobsModel>> fetchJobs(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${ApiServices.baseUrl}/user/detail/$userId'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        final userDetail = UserDetail.fromJson(jsonResponse['data']);
        return userDetail.jobs ?? <JobsModel>[];
      } else {
        throw Exception(
            'Failed to fetch user details: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch user details. Status code: ${response.statusCode}');
    }
  }
}
