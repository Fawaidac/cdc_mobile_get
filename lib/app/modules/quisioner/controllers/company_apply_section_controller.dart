import 'dart:convert';

import 'package:cdc/app/modules/quisioner/views/job_suitability_section_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../services/api_services.dart';

class CompanyApplySectionController extends GetxController {
  String? selectedBefore;
  String? selectedResponse;
  String? selectedInvite;
  String? selectedActive;

  var lainnya = TextEditingController();
  List<String> chooseOptions = [
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
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
  ];
  List<String> chooseOptions2 = [
    'Tidak',
    'Tidak, tapi saya sedang menunggu hasil lamaran kerja',
    'Ya, saya akan mulai bekerja dalam 2 minggu ke depan',
    'Ya, tapi saya belum pasti akan bekerja dalam 2 minggu ke depan',
    'Lainnya',
  ];
  var idQuisioner = "";
  RxBool isUpdate = false.obs;

  void check() {
    if (lainnya.text.isEmpty) {
      Get.snackbar("Error", "Silahkan isi pertanyaan yang diperlukan",
          margin: const EdgeInsets.all(10));
    } else if (isUpdate.value == true) {
      handleQuisionerJumlahUpdate();
    } else {
      handleQuisionerJumlah();
    }
  }

  void handleQuisionerJumlah() async {
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionercompanyApply(
          selectedBefore.toString(),
          selectedResponse.toString(),
          selectedInvite.toString(),
          selectedActive.toString(),
          lainnya.text);
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => JobSuitabilitySectionView());
        idQuisioner = response['data']['quis_terjawab']['id'];
        isUpdate.value = true;
      } else if (response['message'] ==
          'gagal mengisi kuisioner Gagal mengisi kuisioner , kamu belum mengisi quisioner sebelumnya') {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
      } else if (response['message'] == 'Quisioner level not found') {
        Get.snackbar(
            "Error", "Silahkan isi quisioner identitas terlebih dahulu",
            margin: const EdgeInsets.all(10));
      } else {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  void handleQuisionerJumlahUpdate() async {
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionercompanyApplyUpdate(
          idQuisioner,
          selectedBefore.toString(),
          selectedResponse.toString(),
          selectedInvite.toString(),
          selectedActive.toString(),
          lainnya.text);
      if (response['code'] == 200) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => JobSuitabilitySectionView());
      } else if (response['message'] ==
          'gagal mengisi kuisioner Gagal mengisi kuisioner , kamu belum mengisi quisioner sebelumnya') {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
      } else if (response['message'] == 'Quisioner level not found') {
        Get.snackbar(
            "Error", "Silahkan isi quisioner identitas terlebih dahulu",
            margin: const EdgeInsets.all(10));
      } else {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<Map<String, dynamic>> quisionercompanyApply(
    String before,
    String responses,
    String invite,
    String active,
    String other,
  ) async {
    final Map<String, dynamic> requestBody = {
      "job_applications_before_first_job": before,
      "job_applications_responses": responses,
      "interview_invitations": invite,
      "job_search_recently_active": active,
      "job_search_recently_active_other": other,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/companyapplied'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionercompanyApplyUpdate(
    String id,
    String before,
    String responses,
    String invite,
    String active,
    String other,
  ) async {
    final Map<String, dynamic> requestBody = {
      'id': id,
      "job_applications_before_first_job": before,
      "job_applications_responses": responses,
      "interview_invitations": invite,
      "job_search_recently_active": active,
      "job_search_recently_active_other": other,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/companyapplied'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }
}
