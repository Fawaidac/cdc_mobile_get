import 'dart:convert';

import 'package:cdc/app/data/models/tracer_study_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TracerStudyContoller extends GetxController {
  TracerStudyModel? model;
  var isLoading = false.obs;
  var isEmptyData = true.obs;

  Future<void> getTracerStudy() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '${ApiServices.baseUrl}/kuesioner/tracer-study';

    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        model = TracerStudyModel.fromJson(json);
      } else {
        debugPrint(response.statusCode.toString());
      }
      print(json);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
