import 'dart:convert';

import 'package:cdc/app/modules/quisioner/views/job_street_section_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudyMethodSectionController extends GetxController {
  String? selectedPerkuliahan;
  String? selectedDemontrasi;
  String? selectedPartisipasi;
  String? selectedMagang;
  String? selectedPraktikum;
  String? selectedKerjaLapang;
  String? selectedDiskusi;

  List<String> tingkatOptions = [
    'Sangat Besar',
    'Besar',
    'Cukup Besar',
    'Kurang',
    'Tidak Sama Sekali',
  ];

  static Future<Map<String, dynamic>> quisionerMethodStudy(
    String perkuliahan,
    String demonstrasi,
    String partisipasi,
    String magang,
    String praktikum,
    String kerjaLapang,
    String diskusi,
  ) async {
    final Map<String, dynamic> requestBody = {
      "academicStudy": perkuliahan,
      "demonstrasi": demonstrasi,
      "research_participation": partisipasi,
      "intern": magang,
      "practice": praktikum,
      "field_work": kerjaLapang,
      "discucion": diskusi,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/studymethod'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  void handleQuisionerStudyMethod() async {
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionerMethodStudy(
          selectedPerkuliahan.toString(),
          selectedDemontrasi.toString(),
          selectedPartisipasi.toString(),
          selectedMagang.toString(),
          selectedPraktikum.toString(),
          selectedKerjaLapang.toString(),
          selectedDiskusi.toString());
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));

        Get.to(() => JobStreetSectionView());
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
