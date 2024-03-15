import 'dart:convert';

import 'package:cdc/app/data/models/tracer_study_model.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TracerStudyContoller extends GetxController {
  TracerStudyModel? model;
  var isLoading = false.obs;
  var isLoadingCheck = false.obs;
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
        isEmptyData(false);
      } else {
        debugPrint(response.statusCode.toString());
        isEmptyData(true);
      }
      print(json);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> checkQuesioner(idPaket) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final idUser = prefs.getString('id_user');

    String url =
        '${ApiServices.baseUrl}/kuesioner/cek-status-user/$idUser/$idPaket';

    try {
      isLoadingCheck(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (json['status'] == 0) {
          AppDialog.show(
            title: "Perhatian !",
            isTouch: false,
            desc: "Anda Sudah mengisi Quesioner ini.",
            onOk: () async {
              Get.back();
            },
          );
        } else {
          AppDialog.show(
            title: "Perhatian !",
            isTouch: false,
            desc:
                "Mohon perhatikan dengan baik, setelah Anda masuk ke dalam kuesioner, tidak ada kemungkinan untuk kembali. Pastikan Anda melengkapi semua pertanyaan disetiap sesi",
            onOk: () async {
              Get.toNamed(Routes.PAKET_QUISIONER, arguments: idPaket);
            },
            onCancel: () {
              Get.back();
            },
          );
        }
      } else {
        debugPrint(response.statusCode.toString());
      }
      print(json);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingCheck(false);
    }
  }
}
