import 'dart:convert';

import 'package:cdc/app/data/models/educations_model.dart';
import 'package:cdc/app/modules/profile/controllers/education_user_controller.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditEducationUserController extends GetxController {
  var perguruantinggi = TextEditingController();
  var strata = TextEditingController();
  var jurusan = TextEditingController();
  var prodi = TextEditingController();
  var tahunMasuk = TextEditingController();
  var tahunLulus = TextEditingController();
  var noIjazah = TextEditingController();
  String? selectedStrata;
  String? idEducations;
  String? selectedPerguruan;
  List<String> perguruanOptions = ['Politeknik Negeri Jember', 'Lainnya'];
  EducationsModel? education;
  List<String> strataOptions = ['D3', 'D4', 'S1', 'S2', 'S3'];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    education = Get.arguments as EducationsModel;

    if (education != null) {
      idEducations = education?.id ?? "";
      perguruantinggi.text = education?.perguruan ?? "";
      strata.text = education?.strata ?? "";
      jurusan.text = education?.jurusan ?? "";
      prodi.text = education?.prodi ?? "";
      tahunMasuk.text = education?.tahunMasuk.toString() ?? "";
      tahunLulus.text = education?.tahunLulus.toString() ?? "";
      noIjazah.text = education?.noIjasah ?? "";
      selectedStrata = education?.strata?.substring(0, 2);
    }
  }

  Future<void> updateEducation() async {
    String id = idEducations ?? "";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      EasyLoading.show(status: "Loading...");
      final res =
          await http.put(Uri.parse('${ApiServices.baseUrl}/user/education/$id'),
              body: jsonEncode({
                'perguruan': perguruantinggi.text,
                'jurusan': jurusan.text,
                'prodi': prodi.text,
                'tahun_masuk': tahunMasuk.text,
                'tahun_lulus': tahunLulus.text,
                'no_ijasah': noIjazah.text,
                'strata': selectedStrata,
              }),
              headers: {
            "Authorization": "Bearer $token",
            'Content-Type': 'application/json',
          });
      final Map<String, dynamic> data = jsonDecode(res.body);
      if (data['code'] == 200) {
        Get.back();
        Get.find<EducationUserController>().educationList.clear();
        Get.find<EducationUserController>().fetchAndAssignEducation();
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
