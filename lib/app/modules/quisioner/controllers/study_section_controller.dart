import 'dart:convert';

import 'package:cdc/app/modules/quisioner/views/kompetensi_section_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StudySectionController extends GetxController {
  String? selectedBiaya;
  String? selectedHubungan;
  String? selectedTingkat;

  Rx<String?> selectedSumberdana = Rx<String?>(null);

  var namaPerguruan = TextEditingController();
  var namaProdi = TextEditingController();
  var sumberDana = TextEditingController();
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  List<String> biayaOptions = [
    'Biaya Sendiri',
    'Bea Siswa',
  ];

  RxList<String> sumberDanaOptions = RxList([
    'Biaya Sendiri/Keluarga',
    'Beasiswa ADIK',
    'Beasiswa BIDIKMISI',
    'Beasiswa PPA',
    'Beasiswa AFIRMASI',
    'Beasiswa Perusahaan/Swasta',
    'Lainnya',
  ]);
  List<String> hubunganOptions = [
    'Sangat Erat',
    'Erat',
    'Cukup Erat',
    'Kurang Erat',
    'Tidak sama sekali',
  ];
  List<String> tingkatOptions = [
    'Setingkat lebih tinggi',
    'Tingkat yang sama',
    'Setingkat lebih rendah',
    'Tidak perlu pendidikan tinggi',
  ];

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Set only the date part without the time
      selectedDate.value =
          DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
    }
  }

  void handleQuisionerStudy() async {
    String sumberDanaValue = selectedSumberdana.value == 'Lainnya'
        ? sumberDana.text
        : selectedSumberdana.toString();

    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionerStudy(
          selectedBiaya.toString(),
          namaPerguruan.text,
          namaProdi.text,
          selectedDate.value ?? DateTime.now(),
          sumberDanaValue,
          sumberDana.text,
          selectedHubungan.toString(),
          selectedTingkat.toString());
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => KompetensiSectionView());
      } else if (response['message'] ==
          'gagal mengisi kuisioner Harap isi quisioner sebelumnya terlebih dahulu') {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
      } else if (response['message'] == 'Quisioner level not found') {
        Get.snackbar("Error", "Silahkan isi quisioner identitas terlebih dahulu",
            margin: const EdgeInsets.all(10));
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

  static Future<Map<String, dynamic>> quisionerStudy(
      String studyFunding,
      String univName,
      String prodi,
      DateTime studyStart,
      String educationFunding,
      String finansial,
      String studyJob,
      String jobLevel) async {
    final Map<String, dynamic> requestBody = {
      "study_funding_source": studyFunding,
      "univercity_name": univName,
      "study_program": prodi,
      "study_start_date": studyStart.toLocal().toIso8601String().split('T')[0],
      "education_funding_source": educationFunding,
      "financial_source": finansial,
      "study_job_relationship": studyJob,
      "job_education_level": jobLevel,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/furthestudy'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    final data = jsonDecode(response.body);
    return data;
  }
}
