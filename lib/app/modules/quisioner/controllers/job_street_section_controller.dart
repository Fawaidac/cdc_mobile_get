import 'dart:convert';

import 'package:cdc/app/modules/quisioner/views/find_job_section_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobStreetSectionController extends GetxController {
  String? selectedJobs;
  String? selectedMonth;
  String? selectedWisuda;

  List<String> jobsOptions = [
    'Saya mencari kerja sebelum lulus',
    'Saya mencari kerja sesudah wisuda',
    'Saya tidak mencari kerja',
  ];
  List<String> monthOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

  static Future<Map<String, dynamic>> quisionerJobsStreet(
    String jobStart,
    String before,
    String after,
  ) async {
    final Map<String, dynamic> requestBody = {
      "job_search_start": jobStart,
      "before_graduation": before,
      "after_graduation": after,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/jobstreet'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  void handleQuisionerJobs() async {
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionerJobsStreet(selectedJobs.toString(),
          selectedMonth.toString(), selectedWisuda.toString());
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => FindJobSectionView());
      } else if (response['message'] ==
          'gagal mengisi kuisioner Gagal mengisi kuisioner , kamu belum mengisi quisioner sebelumnya') {
        Get.snackbar(
            "Error", "Silahkan isi quisioner sebelumnya terlebih dahulu",
            margin: const EdgeInsets.all(10));
      } else if (response['message'] == 'Quisioner level not found') {
        Get.snackbar(
            "Success", "Silahkan isi quisioner identitas terlebih dahulu",
            margin: const EdgeInsets.all(10));
      } else {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
