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
  RxList<String> provinsiList = RxList<String>();
  RxString selectedProvinsi = RxString("");

  RxList<String> regencyList = RxList<String>();
  RxString selectedRegency = RxString("");

  RxList<Map<String, dynamic>> dataProvinceList = <Map<String, dynamic>>[].obs;
  RxString namaProvinsi = "".obs;
  RxString idProvinsi = "".obs;

  RxList<Map<String, dynamic>> dataRegencyList = <Map<String, dynamic>>[].obs;
  RxString namaRegency = "".obs;
  RxString idRegency = "".obs;

  late TextEditingController jenis;
  late TextEditingController namaPerusahaan;
  late TextEditingController pendapatan;

  var idQuisioner = "";
  RxBool isUpdate = false.obs;

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

  Future<void> fetchDataProv() async {
    final response = await http.get(
      Uri.parse('${ApiServices.baseUrl}/province'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        dataProvinceList.assignAll(List.from(responseData['data']));
      } else {
        print('Error: ${responseData['message']}');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> fetchDataReg() async {
    final response = await http.get(
      Uri.parse('${ApiServices.baseUrl}/regency'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == true) {
        dataRegencyList.assignAll(List.from(responseData['data']));
      } else {
        print('Error: ${responseData['message']}');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> loadProvinsiData() async {
    try {
      final String data =
          await rootBundle.loadString('assets/models/provinsi.json');
      final List<dynamic> jsonData = json.decode(data);

      provinsiList.assignAll(jsonData
          .map((dynamic provinsi) => provinsi['province_name'].toString())
          .cast<String>()
          .toList());

      if (provinsiList.isNotEmpty) {
        selectedProvinsi.value = provinsiList[0];
      } else {
        selectedProvinsi.value = "";
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

      regencyList.assignAll(jsonData
          .map((dynamic regency) => regency['kabupaten_kota'].toString())
          .cast<String>()
          .toList());

      if (regencyList.isNotEmpty) {
        selectedRegency.value = regencyList[0];
      } else {
        selectedRegency.value = "";
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
    String gajiValue = pendapatan.text.replaceAll('.', '');
    try {
      EasyLoading.show(status: "Loading...");

      final response = await quisionerMain(
          statusValue,
          less6Value,
          selectedMonth.toString(),
          gajiValue,
          selectedAfter.toString(),
          idProvinsi.toString(),
          idRegency.toString(),
          selectedJenisValue,
          namaPerusahaan.text,
          selectedJabatan.toString(),
          selectedTingkatan.toString());
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => StudySectionView());
        idQuisioner = response['data']['quis_terjawab']['id'];
        isUpdate.value = true;
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

  void handleQuisionerMainUpdate() async {
    bool less6Value = selectedJobs == "Ya" ? true : false;
    String selectedJenisValue = selectedJenisInstansi == 'Lainnya'
        ? jenis.text
        : selectedJenisInstansi.toString();
    String gajiValue = pendapatan.text.replaceAll('.', '');
    String statusValue = selectedStatus.toString();
    try {
      EasyLoading.show(status: "Loading...");

      final response = await quisionerMainUpdate(
          idQuisioner,
          statusValue,
          less6Value,
          selectedMonth.toString(),
          gajiValue,
          selectedAfter.toString(),
          idProvinsi.toString(),
          idRegency.toString(),
          selectedJenisValue,
          namaPerusahaan.text,
          selectedJabatan.toString(),
          selectedTingkatan.toString());
      if (response['code'] == 200) {
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

  static Future<Map<String, dynamic>> quisionerMainUpdate(
    String id,
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
      'id': id,
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

    final response = await http.put(
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
