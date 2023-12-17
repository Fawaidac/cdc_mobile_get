import 'dart:convert';

import 'package:cdc/app/modules/quisioner/controllers/company_apply_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/find_job_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/identitas_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/job_street_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/kompetensi_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/main_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/quisioner_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/study_method_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/study_section_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobSuitabilitySectionController extends GetxController {
  String? notReleated;
  String? notReleated2;
  String? notReason;
  String? notReason2;
  String? otherReason;
  String? otherReason2;
  String? otherReason3;
  String? otherReason4;
  String? otherReason5;
  String? otherReason6;
  String? otherReason7;
  String? otherReason8;
  String? otherReason9;
  RxBool checkboxValue1 = false.obs;
  RxBool checkboxValue2 = false.obs;
  var otherReason10 = TextEditingController();

  List<String> chooseOptions = [
    'Tidak sesuai',
    'Pekerjaan saya sekarang sudah sesuai dengan pendidikan saya'
  ];
  List<String> chooseOptions1 = [
    'Pekerjaan saya sudah sesuai',
    'Di pekerjaan ini saya memeroleh prospek karir yang baik'
  ];
  List<String> chooseOptions2 = [
    'Pekerjaan saya sudah sesuai',
    'Saya lebih suka bekerja di area pekerjaan yang tidak ada hubungannya dengan pendidikan saya'
  ];
  List<String> chooseOptions3 = [
    'Pekerjaan saya sudah sesuai',
    'Saya dipromosikan ke posisi yang kurang berhubungan dengan pendidikan saya dibanding posisi sebelumnya'
  ];
  List<String> chooseOptions4 = [
    'Pekerjaan saya sudah sesuai',
    'Saya dapat memeroleh pendapatan yang lebih tinggi di pekerjaan ini'
  ];
  List<String> chooseOptions5 = [
    'Pekerjaan saya sudah sesuai',
    'Pekerjaan saya saat ini lebih aman/terjamin/secure'
  ];
  List<String> chooseOptions6 = [
    'Pekerjaan saya sudah sesuai',
    'Pekerjaan saya saat ini lebih menarik'
  ];
  List<String> chooseOptions7 = [
    'Pekerjaan saya sudah sesuai',
    'Pekerjaan saya saat ini lebih memungkinkan saya mengambil pekerjaan tambahan/jadwal yang fleksibel dll'
  ];
  List<String> chooseOptions8 = [
    'Pekerjaan saya sudah sesuai',
    'Pekerjaan saya saat ini lokasinya lebih dekat dari rumah saya'
  ];
  List<String> chooseOptions9 = [
    'Pekerjaan saya sudah sesuai',
    'Pekerjaan saya saat ini dapat lebih menjamin kebutuhan keluarga saya'
  ];
  List<String> chooseOptions10 = [
    'Pekerjaan saya sudah sesuai',
    'Pada awal meniti karir ini saya harus menerima pekerjaan yang tidak berhubungan dengan pendidikan saya'
  ];
  List<String> chooseOptions11 = ['Pekerjaan saya sudah sesuai', 'Lainnya'];

  void check() {
    if (otherReason10.text.isEmpty) {
      Get.snackbar("Error", "Silahkan isi pertanyaan yang diperlukan",
          margin: const EdgeInsets.all(10));
    } else {
      Get.find<IdentitasSectionController>().isUpdate.value = false;
      Get.find<MainSectionController>().isUpdate.value = false;
      Get.find<StudySectionController>().isUpdate.value = false;
      Get.find<KompetensiSectionController>().isUpdate.value = false;
      Get.find<StudyMethodSectionController>().isUpdate.value = false;
      Get.find<JobStreetSectionController>().isUpdate.value = false;
      Get.find<FindJobSectionController>().isUpdate.value = false;
      Get.find<CompanyApplySectionController>().isUpdate.value = false;
      handlequisionerJobsUitability();
    }
  }

  void handlequisionerJobsUitability() async {
    String releated2Value = '';
    if (checkboxValue1.value == true) {
      releated2Value = "Pekerjaan saya sudah sesuai";
    } else if (checkboxValue2.value == true) {
      releated2Value = "Saya belum mendapatkan pekerjaan yang lebih sesuai";
    } else if (checkboxValue1.value == true && checkboxValue2.value == true) {
      releated2Value =
          "Pekerjaan saya sudah sesuai-Saya belum mendapatkan pekerjaan yang lebih sesuai";
    } else {
      Get.snackbar("Error", "Silahkan isi pertanyaan yang diperlukan",
          margin: const EdgeInsets.all(10));
    }
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionerJobsuitability(
          notReleated.toString(),
          releated2Value,
          notReason.toString(),
          notReason2.toString(),
          otherReason.toString(),
          otherReason2.toString(),
          otherReason3.toString(),
          otherReason4.toString(),
          otherReason5.toString(),
          otherReason6.toString(),
          otherReason7.toString(),
          otherReason8.toString(),
          otherReason9.toString(),
          otherReason10.text);
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.find<QuisionerController>().quisionerData.clear();
        Get.offAllNamed(Routes.HOMEPAGE);
      } else if (response['message'] ==
          'gagal mengisi kuisioner Gagal mengisi kuisioner , kamu belum mengisi quisioner sebelumnya') {
        Get.snackbar("Error", response['message'],
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

  static Future<Map<String, dynamic>> quisionerJobsuitability(
    String notReleated,
    String notReleated2,
    String notReason,
    String notReason2,
    String otherReason,
    String otherReason2,
    String otherReason3,
    String otherReason4,
    String otherReason5,
    String otherReason6,
    String otherReason7,
    String otherReason8,
    String otherReason9,
    String otherReason10,
  ) async {
    final Map<String, dynamic> requestBody = {
      "job_suitability_not_related": notReleated,
      "job_suitability_not_related_2": notReleated2,
      "job_suitability_reason": notReason,
      "job_suitability_reason_2": notReason2,
      "other_reason": otherReason,
      "other_reason_2": otherReason2,
      "other_reason_3": otherReason3,
      "other_reason_4": otherReason4,
      "other_reason_5": otherReason5,
      "other_reason_6": otherReason6,
      "other_reason_7": otherReason7,
      "other_reason_8": otherReason8,
      "other_reason_9": otherReason9,
      "other_reason_10": otherReason10,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/jobsuitability'),
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
