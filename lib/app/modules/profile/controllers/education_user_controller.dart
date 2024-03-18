import 'dart:convert';

import 'package:cdc/app/data/models/educations_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EducationUserController extends GetxController {
  RxList<EducationsModel> educationList = <EducationsModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchAndAssignEducation() async {
    try {
      isLoading(true);
      final educationData = await fetchEducation();
      educationList.assignAll(educationData);
    } catch (e) {
      print('Error loading education data: $e');
    } finally {
      isLoading(false);
    }
  }

  static Future<List<EducationsModel>> fetchEducation() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
        Uri.parse('${ApiServices.baseUrl}/user/education'),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((e) => EducationsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load education');
    }
  }

  void handleDeleteEducation(String educationId) async {
    try {
      EasyLoading.show(status: "Loading...");
      final response = await deleteEducations(educationId);
      if (response['code'] == 200) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        educationList.clear();
        fetchAndAssignEducation();
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

  static Future<Map<String, dynamic>> deleteEducations(
      String educationsId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http
        .delete(Uri.parse('${ApiServices.baseUrl}/user/education'), body: {
      "id_education": educationsId,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(response.body);
    return data;
  }
}
