import 'dart:convert';

import 'package:cdc/app/data/models/quisioner_check_model.dart';
import 'package:cdc/app/services/api_services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_dialog.dart';

class FasilitasController extends GetxController {
  var questionnaireCheck = Rx<QuestionnaireCheck?>(null);
  int totalSections = 9;
  double calculateProgress() {
    int totalSections = 9;
    int completedSections = 0;

    if (questionnaireCheck.value?.identitasSection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.mainSection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.furtheStudySection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.competentLevelSection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.studyMethodSection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.jobsStreetSection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.howFindJobsSection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.companyAppliedSection != null) {
      completedSections++;
    }
    if (questionnaireCheck.value?.jobSuitabilitySection != null) {
      completedSections++;
    }
    double progress = completedSections / totalSections;

    return progress;
  }

  Future<QuestionnaireCheck?> quisionerCheck() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
          Uri.parse('${ApiServices.baseUrl}/user/quisioner/check'),
          headers: {"Authorization": "Bearer $token"});
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      if (responseJson['code'] == 200) {
        QuestionnaireCheck check =
            QuestionnaireCheck.fromJson(responseJson['data']);
        questionnaireCheck.value = check;
        return check;
      } else if (responseJson['message'] ==
          "your token is not valid , please login again") {
        AppDialog.show(
          title: "Error !",
          isTouch: false,
          desc: "Ops , sesi anda telah habis , silahkan login ulang",
          onOk: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.remove('token');
            preferences.remove('tokenExpirationTime');

            Get.offAllNamed(Routes.LOGIN);
            Get.snackbar("Success", "Berhasil keluar dari aplikasi",
                margin: const EdgeInsets.all(10));
          },
          onCancel: () {
            Get.back();
          },
        );
      } else {
        print(responseJson['message']);
        return null;
      }
    } catch (e) {
      print('Error fetching quisioner check: $e');
      throw e;
    }
    return null;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    quisionerCheck();
  }
}
