import 'dart:convert';

import 'package:cdc/app/data/models/jobs_model.dart';
import 'package:cdc/app/modules/profile/controllers/job_user_controller.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class EditJobUserController extends GetxController {
  var perusahaan = TextEditingController();
  var jabatan = TextEditingController();
  var gaji = TextEditingController();
  var tahunMasuk = TextEditingController();
  var tahunKeluar = TextEditingController();
  // var jenisP = TextEditingController();
  String? selectedJenisPekerjaan;
  RxBool isChecked = false.obs;
  String? idJob;

  List<String> jobsOptions = [
    'Purnawaktu',
    'Paruh Waktu',
    'Wiraswata',
    'Pekerja Lepas',
    'Kontrak',
    'Musiman',
  ];

  JobsModel? job;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    job = Get.arguments as JobsModel;

    if (job != null) {
      idJob = job?.id ?? "";
      perusahaan.text = job?.perusahaan ?? "";
      jabatan.text = job?.jabatan ?? "";
      gaji.text = NumberFormat.decimalPattern('id').format(job?.gaji ?? 0);
      tahunMasuk.text = job?.tahunMasuk.toString() ?? "";
      selectedJenisPekerjaan = job?.jenisPekerjaan.toString() ?? "";
      if (job?.pekerjaanSaatini.toString() == "1") {
        tahunKeluar.text = DateTime.now().year.toString();
        isChecked.value = true;
      } else {
        tahunKeluar.text = job?.tahunKeluar.toString() ?? "";
        isChecked.value = false;
      }
    }
  }

  void toogleCheckbox(String value) {}
  Future<void> updateJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    String id = idJob ?? "";
    String? tahunKeluarValue;
    String? isJobsNow;
    String gajiValue = gaji.text.replaceAll('.', '');
    if (isChecked.value == true) {
      tahunKeluarValue = tahunKeluar.text;
      isJobsNow = "1";
    } else {
      tahunKeluarValue = tahunKeluar.text;
      isJobsNow = "0";
    }
    try {
      EasyLoading.show(status: "Loading...");
      final res = await http.put(Uri.parse('${ApiServices.baseUrl}/user/jobs'),
          body: jsonEncode({
            'perusahaan': perusahaan.text,
            'jabatan': jabatan.text,
            'gaji': gajiValue,
            'jenis_pekerjaan': selectedJenisPekerjaan,
            'tahun_masuk': tahunMasuk.text,
            'tahun_keluar': tahunKeluarValue,
            'is_jobs_now': isJobsNow,
            'jobs_id': id,
          }),
          headers: {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          });
      final Map<String, dynamic> data = jsonDecode(res.body);
      if (data['code'] == 200) {
        Get.back();
        Get.find<JobUserController>().jobList.clear();
        Get.find<JobUserController>().fetchAndAssignJob();
        Get.snackbar("Success", data['message'],
            margin: const EdgeInsets.all(10));
      } else {
        Get.snackbar("Error", data['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
