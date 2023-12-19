import 'dart:convert';

import 'package:cdc/app/modules/quisioner/views/company_apply_section_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FindJobSectionController extends GetxController {
  String? selectedPlatform;
  String? selectedVacancies;
  String? selectedExcanges;
  String? selectedInternet;
  String? selectedCompany;
  String? selectedKemenakertrans;
  String? selectedAgen;
  String? selectedInformasi;
  String? selectedKantor;
  String? selectedNetwork;
  String? selectedRelasi;
  String? selectedBisnis;
  String? selectedPenempatan;
  String? selectedCollage;
  String? selectedLainnya;

  var lainnya = TextEditingController();
  List<String> chooseOptions = [
    'Ya',
    'Tidak',
  ];
  var idQuisioner = "";
  RxBool isUpdate = false.obs;
  void check() {
    if (selectedPlatform == null &&
        selectedVacancies == null &&
        selectedExcanges == null &&
        selectedInternet == null &&
        selectedCompany == null &&
        selectedKemenakertrans == null &&
        selectedAgen == null &&
        selectedInformasi == null &&
        selectedKantor == null &&
        selectedNetwork == null &&
        selectedRelasi == null &&
        selectedBisnis == null &&
        selectedPenempatan == null &&
        selectedCollage == null &&
        selectedLainnya == null) {
      Get.snackbar("Error", "Silakan isi pertanyaan yang diperlukan",
          margin: const EdgeInsets.all(10));
    } else {
      if (isUpdate.value == true) {
        handleQuisionerFindJobsUpdate();
      } else {
        handleQuisionerFindJobs();
      }
    }
  }

  void handleQuisionerFindJobs() async {
    bool platformValue = selectedPlatform == 'Ya' ? true : false;
    bool vacanciesValue = selectedVacancies == 'Ya' ? true : false;
    bool exchangeValue = selectedExcanges == 'Ya' ? true : false;
    bool internetValue = selectedInternet == 'Ya' ? true : false;
    bool companyValue = selectedCompany == 'Ya' ? true : false;
    bool kemenakertransValue = selectedKemenakertrans == 'Ya' ? true : false;
    bool comercialValue = selectedAgen == 'Ya' ? true : false;
    bool cdcValue = selectedInformasi == 'Ya' ? true : false;
    bool alumniValue = selectedKantor == 'Ya' ? true : false;
    bool networkValue = selectedNetwork == 'Ya' ? true : false;
    bool relationValue = selectedRelasi == 'Ya' ? true : false;
    bool selfValue = selectedBisnis == 'Ya' ? true : false;
    bool internValue = selectedPenempatan == 'Ya' ? true : false;
    bool collageValue = selectedCollage == 'Ya' ? true : false;
    bool otherValue = selectedLainnya == 'Ya' ? true : false;
    String? otherJobs = lainnya.text == "" ? null : lainnya.text;
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionerFindJobs(
          platformValue,
          vacanciesValue,
          exchangeValue,
          internetValue,
          companyValue,
          kemenakertransValue,
          comercialValue,
          cdcValue,
          alumniValue,
          networkValue,
          relationValue,
          selfValue,
          internValue,
          collageValue,
          otherValue,
          otherJobs ?? "");

      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => CompanyApplySectionView());
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

  void handleQuisionerFindJobsUpdate() async {
    bool platformValue = selectedPlatform == 'Ya' ? true : false;
    bool vacanciesValue = selectedVacancies == 'Ya' ? true : false;
    bool exchangeValue = selectedExcanges == 'Ya' ? true : false;
    bool internetValue = selectedInternet == 'Ya' ? true : false;
    bool companyValue = selectedCompany == 'Ya' ? true : false;
    bool kemenakertransValue = selectedKemenakertrans == 'Ya' ? true : false;
    bool comercialValue = selectedAgen == 'Ya' ? true : false;
    bool cdcValue = selectedInformasi == 'Ya' ? true : false;
    bool alumniValue = selectedKantor == 'Ya' ? true : false;
    bool networkValue = selectedNetwork == 'Ya' ? true : false;
    bool relationValue = selectedRelasi == 'Ya' ? true : false;
    bool selfValue = selectedBisnis == 'Ya' ? true : false;
    bool internValue = selectedPenempatan == 'Ya' ? true : false;
    bool collageValue = selectedCollage == 'Ya' ? true : false;
    bool otherValue = selectedLainnya == 'Ya' ? true : false;
    String? otherJobs = lainnya.text == "" ? null : lainnya.text;
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionerFindJobsUpdate(
          idQuisioner,
          platformValue,
          vacanciesValue,
          exchangeValue,
          internetValue,
          companyValue,
          kemenakertransValue,
          comercialValue,
          cdcValue,
          alumniValue,
          networkValue,
          relationValue,
          selfValue,
          internValue,
          collageValue,
          otherValue,
          otherJobs ?? "");

      if (response['code'] == 200) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => CompanyApplySectionView());
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

  static Future<Map<String, dynamic>> quisionerFindJobs(
    bool platform,
    bool vacancies,
    bool exchange,
    bool internet,
    bool company,
    bool kemenakertrans,
    bool comercial,
    bool cdc,
    bool alumni,
    bool network,
    bool relation,
    bool self,
    bool intern,
    bool collage,
    bool other,
    String otherJobs,
  ) async {
    final Map<String, dynamic> requestBody = {
      "news_paper": platform,
      "unknown_vacancies": vacancies,
      "exchange": exchange,
      "contacted_company": company,
      "Kemenakertrans": kemenakertrans,
      "commercial_swasta": comercial,
      "cdc": cdc,
      "alumni": alumni,
      "network_college": network,
      "relation": relation,
      "self_employed": self,
      "intern": intern,
      "workplace_during_college": collage,
      "other": other,
      "other_job_source": otherJobs,
      "internet": internet,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/howtofindjobs'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  static Future<Map<String, dynamic>> quisionerFindJobsUpdate(
    String id,
    bool platform,
    bool vacancies,
    bool exchange,
    bool internet,
    bool company,
    bool kemenakertrans,
    bool comercial,
    bool cdc,
    bool alumni,
    bool network,
    bool relation,
    bool self,
    bool intern,
    bool collage,
    bool other,
    String otherJobs,
  ) async {
    final Map<String, dynamic> requestBody = {
      'id': id,
      "news_paper": platform,
      "unknown_vacancies": vacancies,
      "exchange": exchange,
      "contacted_company": company,
      "Kemenakertrans": kemenakertrans,
      "commercial_swasta": comercial,
      "cdc": cdc,
      "alumni": alumni,
      "network_college": network,
      "relation": relation,
      "self_employed": self,
      "intern": intern,
      "workplace_during_college": collage,
      "other": other,
      "other_job_source": otherJobs,
      "internet": internet,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/howtofindjobs'),
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
