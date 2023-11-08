import 'dart:convert';

import 'package:cdc/app/data/models/jobs_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobUserController extends GetxController {
  RxList<JobsModel> jobList = <JobsModel>[].obs;

  Future<void> fetchAndAssignJob() async {
    try {
      final jobData = await fetchJobs();
      jobList.assignAll(jobData);
    } catch (e) {
      print('Error loading job data: $e');
    }
  }

  static Future<List<JobsModel>> fetchJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/user/jobs'),
        headers: {"Authorization": "Bearer $token"});
    final data = jsonDecode(response.body);
    if (data['code'] == 200) {
      List jsonResponse = data['data'];
      return jsonResponse.map((e) => JobsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  void handleDeleteJobs(String jobsId) async {
    try {
      final response = await deleteJobs(jobsId);
      if (response['code'] == 200) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        jobList.clear();
        fetchAndAssignJob();
      } else {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>> deleteJobs(String jobsId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response =
        await http.delete(Uri.parse('${ApiServices.baseUrl}/user/jobs'), body: {
      "jobs_id": jobsId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
    return data;
  }
}
