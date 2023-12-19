import 'dart:convert';

import 'package:cdc/app/data/models/quisioner_check_model.dart';
import 'package:cdc/app/modules/quisioner/controllers/quisioner_controller.dart';
import 'package:cdc/app/services/api_services.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
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

  Future<Map<String, dynamic>> updateLocationUser(
      double lat, double long) async {
    final Map<String, dynamic> requestBody = {
      "latitude": lat,
      "longtitude": long,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('${ApiServices.baseUrl}/user/position'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    if (status.isDenied) {
      await Permission.location.request();
    }

    if (status.isGranted) {
      Map<String, double> locationData = await getCurrentLocation();
      double latitude = locationData["latitude"] ?? 0.0;
      double longitude = locationData["longitude"] ?? 0.0;

      final res = await updateLocationUser(latitude, longitude);
      if (res['code'] == 200) {
        print("oke");
      } else {
        print(res['message'] + "asjalks");
      }
    }
  }

  static Future<Map<String, double>> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      Map<String, double> locationData = {
        "latitude": latitude,
        "longitude": longitude,
      };

      return locationData;
    } catch (e) {
      print("Error getting location: $e");
      return Future.error("Error getting location: $e");
    }
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
    super.onInit();
    quisionerCheck();
    requestLocationPermission();
  }
}
