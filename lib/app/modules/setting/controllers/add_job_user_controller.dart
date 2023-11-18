import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../profile/controllers/job_user_controller.dart';

class AddJobUserController extends GetxController {
  var perusahaan = TextEditingController();
  var jabatan = TextEditingController();
  var gaji = TextEditingController();
  var tahunMasuk = TextEditingController();
  var tahunKeluar = TextEditingController();
  String? selectedJenisPekerjaan;
  RxBool isChecked = false.obs;

  List<String> jobsOptions = [
    'Purnawaktu',
    'Paruh Waktu',
    'Wiraswata',
    'Pekerja Lepas',
    'Kontrak',
    'Musiman'
  ];
  void toogleCheck(bool val) {
    isChecked.value = val;
    if (isChecked.value) {
      tahunKeluar.text = "";
    }
    update();
  }


  String formatCurrency(String amount) {
    final currencyFormat = NumberFormat.currency(locale: 'id', symbol: 'Rp');
    return currencyFormat.format(double.parse(amount));
  }

  void handleAddJob() async {
    String? tahunKeluarValue;
    String? isJobsNow;
    String gajiValue = gaji.text.replaceAll('.', '');
    if (isChecked(false)) {
      tahunKeluarValue = tahunKeluar.text;
      isJobsNow = "0";
    } else {
      tahunKeluarValue = tahunKeluar.text;
      isJobsNow = "1";
    }
    try {
      EasyLoading.show(status: "Loading...");
      final response = await addJobs(
        perusahaan.text,
        jabatan.text,
        gajiValue,
        selectedJenisPekerjaan.toString(),
        tahunMasuk.text,
        tahunKeluarValue.toString(),
        isJobsNow,
      );
      if (response['code'] == 201) {
        Get.back();
        Get.find<JobUserController>().jobList.clear();
        Get.find<JobUserController>().fetchAndAssignJob();
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
      } else {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
        print(response['message']);
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<Map<String, dynamic>> addJobs(
    var perusahaan,
    var jabatan,
    var gaji,
    var jenisPekerjaan,
    var tahunMasuk,
    var tahunKeluar,
    var isJobs,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http.post(Uri.parse('${ApiServices.baseUrl}/user/jobs'),
        body: jsonEncode({
          "perusahaan": perusahaan,
          "jabatan": jabatan,
          "gaji": gaji,
          "jenis_pekerjaan": jenisPekerjaan,
          "tahun_masuk": tahunMasuk,
          "tahun_keluar": tahunKeluar,
          "is_jobs_now": isJobs,
        }),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json'
        });
    final data = jsonDecode(res.body);
    return data;
  }
}
