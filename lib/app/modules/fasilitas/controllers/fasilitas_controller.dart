import 'dart:convert';

import 'package:cdc/app/data/models/quisioner_check_model.dart';
import 'package:cdc/app/modules/login/views/login_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
        Get.dialog(AlertDialog(
          title: Text(
            "Error !",
            textAlign: TextAlign.center,
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          content: Text(
            "Ops , sesi anda telah habis , silahkan login ulang",
            textAlign: TextAlign.center,
            style: AppFonts.poppins(fontSize: 12, color: black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.offAll(() => LoginView());
              },
              child: Text(
                "OK",
                style: AppFonts.poppins(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel",
                  style: AppFonts.poppins(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ));
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
