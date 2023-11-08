import 'dart:convert';

import 'package:cdc/app/modules/quisioner/views/study_section_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainSectionController extends GetxController {
  RxList<Map<String, dynamic>> provinsiList = RxList<Map<String, dynamic>>();
  RxMap<String, dynamic>? selectedProvinsi;

  RxList<Map<String, dynamic>> regencyList = RxList<Map<String, dynamic>>();
  RxMap<String, dynamic>? selectedRegency;

  late TextEditingController jenis;
  late TextEditingController namaPerusahaan;
  late TextEditingController pendapatan;

  String? selectedStatus;
  String? selectedJobs;
  String? selectedMonth;

  String? selectedAfter;
  String? selectedJenisInstansi;
  String? selectedJabatan;
  String? selectedTingkatan;
  List<String> statusOptions = [
    'Bekerja (full time/part time)',
    'Belum memungkinkan bekerja',
    'Wiraswasta',
    'Melanjutkan Pendidikan',
    'Tidak kerja tetapi sedang mencari kerja'
  ];
  List<String> jobsOptions = [
    'Ya',
    'Tidak',
  ];
  List<String> monthOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  List<String> afterOptions = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  List<String> jenisInstansiOptions = [
    'Instansi pemerintah',
    'Organisasi non-profit/Lembaga Swadaya Masyarakat',
    'Perusahaan swasta',
    'Wiraswasta/perusahaan sendiri',
    'BUMN/BUMD',
    'Institusi/Organisasi Multilateral',
    'Lainnya',
  ];
  List<String> jabatanOptions = [
    'Founder',
    'Co-Founder',
    'Staff',
    'Freelance/Kerja Lepas',
  ];
  List<String> tingkatanOptions = [
    'Lokal/wilayah/wiraswasta tidak berbadan hukum',
    'Nasional/wiraswasta berbadan hukum',
    'Multinasional/Internasional',
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    jenis = TextEditingController();
    namaPerusahaan = TextEditingController();
    pendapatan = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    jenis.dispose();
    namaPerusahaan.dispose();
    pendapatan.dispose();
  }

  Future<void> loadProvinsiData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/models/provinsi.json');
      final List<dynamic> jsonData = json.decode(data);

      provinsiList.assignAll(jsonData.cast<Map<String, dynamic>>());
      if (provinsiList.isNotEmpty) {
        selectedProvinsi = RxMap<String, dynamic>.from(provinsiList[0]);
      } else {
        selectedProvinsi = null;
      }
    } catch (e) {
      print('Error loading provinsi data: $e');
    }
  }

  Future<void> loadRegencyData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/models/regency.json');
      final List<dynamic> jsonData = json.decode(data);

      regencyList.assignAll(jsonData.cast<Map<String, dynamic>>());

      if (regencyList.isNotEmpty) {
        selectedRegency = RxMap<String, dynamic>.from(regencyList[0]);
      } else {
        selectedRegency = null;
      }
    } catch (e) {
      print('Error loading regency data: $e');
    }
  }

  void handleQuisionerMain() async {
    bool less6Value = selectedJobs == "Ya" ? true : false;
    String selectedJenisValue = selectedJenisInstansi == 'Lainnya'
        ? jenis.text
        : selectedJenisInstansi.toString();
    String statusValue = selectedStatus.toString();
    try {
      EasyLoading.show(status: "Loading...");

      final response = await quisionerMain(
          statusValue,
          less6Value,
          selectedMonth.toString(),
          pendapatan.text,
          selectedAfter.toString(),
          selectedProvinsi.toString(),
          selectedRegency.toString(),
          selectedJenisValue,
          namaPerusahaan.text,
          selectedJabatan.toString(),
          selectedTingkatan.toString());
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => StudySectionView());
      } else if (response['message'] == 'Quisioner level not found') {
        Get.snackbar(
            "Error", "Silahkan isi quisioner sebelumnya terlebih dahulu",
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

  static Future<Map<String, dynamic>> quisionerMain(
    String statusValue,
    bool is_less_6_months,
    String pre_grad_employment_months,
    String monthly_income,
    String post_grad_months,
    String code_province,
    String code_regency,
    String agency_type,
    String company_name,
    String job_title,
    String work_level,
  ) async {
    final Map<String, dynamic> requestBody = {
      "status": statusValue,
      "is_less_6_months": is_less_6_months,
      "pre_grad_employment_months": pre_grad_employment_months,
      "monthly_income": monthly_income,
      "post_grad_months": post_grad_months,
      "code_province": code_province,
      "code_regency": code_regency,
      "agency_type": agency_type,
      "company_name": company_name,
      "job_title": job_title,
      "work_level": work_level,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/main'),
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
