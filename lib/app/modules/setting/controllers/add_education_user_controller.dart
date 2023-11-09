import 'package:cdc/app/modules/profile/controllers/education_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddEducationUserController extends GetxController {
  var perguruantinggi = TextEditingController();
  var strata = TextEditingController();
  var jurusan = TextEditingController();
  var prodi = TextEditingController();
  var tahunMasuk = TextEditingController();
  var tahunLulus = TextEditingController();
  var noIjazah = TextEditingController();
  String? selectedStrata;
  RxString selectedPerguruan = RxString("Politeknik Negeri Jember");
  RxString selectedProdi = RxString("");

  List<String> strataOptions = ['D3', 'D4', 'S1', 'S2', 'S3'];
  RxList<String> perguruanOptions =
      RxList(['Politeknik Negeri Jember', 'Lainnya']);
  RxList<Map<String, dynamic>> prodiList = RxList([]);

  Future<void> fetchData() async {
    try {
      final data = await getProdi();

      prodiList.assignAll(data);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getProdi() async {
    final response = await http.get(Uri.parse('${ApiServices.baseUrl}/prodi'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<Map<String, dynamic>> prodiList =
          List<Map<String, dynamic>>.from(jsonResponse['data']);
      return prodiList;
    } else {
      throw Exception('Failed to fetch prodi');
    }
  }

  Future<void> addEducation() async {
    String selectedPerguruanValue = selectedPerguruan.value == 'Lainnya'
        ? perguruantinggi.text
        : "Politeknik Negeri Jember";

    String selectedProdiValue = selectedPerguruan.value == 'Lainnya'
        ? prodi.text
        : selectedProdi.toString();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      EasyLoading.show(status: "Loading...");
      final res = await http
          .post(Uri.parse('${ApiServices.baseUrl}/user/education/add'), body: {
        'perguruan': selectedPerguruanValue,
        'jurusan': jurusan.text,
        'prodi': selectedProdiValue,
        'tahun_masuk': tahunMasuk.text,
        'tahun_lulus': tahunLulus.text,
        'no_ijasah': noIjazah.text,
        'strata': selectedStrata,
      }, headers: {
        "Authorization": "Bearer $token"
      });
      final Map<String, dynamic> data = jsonDecode(res.body);

      if (data['code'] == 201) {
        Get.back();
        Get.find<EducationUserController>().educationList.clear();
        Get.find<EducationUserController>().fetchAndAssignEducation();
        Get.snackbar("Success", "Berhasil menambah pendidikan",
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
