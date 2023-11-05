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
  Future<void> fetchQuisionerCheck() async {
    try {
      final fetchedData = await quisionerCheck();

      if (fetchedData['code'] == 200) {
        QuestionnaireCheck check =
            QuestionnaireCheck.fromJson(fetchedData['data']);
        questionnaireCheck.value = check;
        update();
        questionnaireCheck.refresh();
      } else if (fetchedData['message'] ==
          "your token is not valid , please login again") {
        Get.dialog(
          AlertDialog(
            title: Text(
              "Error",
              style: AppFonts.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 10),
            content: Text(
              "Sesi anda telah habis , silahkan login ulang",
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
          ),
        );
      }
    } catch (e) {
      print('Error fetching quisioner check: $e');
    }
  }

  int calculateCompletedSections() {
    if (questionnaireCheck.value == null) {
      return 0;
    }
    return questionnaireCheck.value!.identitasSection +
        questionnaireCheck.value!.mainSection +
        questionnaireCheck.value!.furtheStudySection +
        questionnaireCheck.value!.competentLevelSection +
        questionnaireCheck.value!.studyMethodSection +
        questionnaireCheck.value!.jobsStreetSection +
        questionnaireCheck.value!.howFindJobsSection +
        questionnaireCheck.value!.companyAppliedSection +
        questionnaireCheck.value!.jobSuitabilitySection;
  }

  static Future<Map<String, dynamic>> quisionerCheck() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
          Uri.parse('${ApiServices.baseUrl}/user/quisioner/check'),
          headers: {"Authorization": "Bearer $token"});
      final responseJson = jsonDecode(response.body);
      return responseJson;
    } catch (e) {
      print('Error fetching quisioner check: $e');
      throw e;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchQuisionerCheck();
  }
}
