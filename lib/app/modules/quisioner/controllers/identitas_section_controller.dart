import 'dart:convert';

import 'package:cdc/app/modules/login/views/login_view.dart';
import 'package:cdc/app/modules/quisioner/views/main_section_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class IdentitasSectionController extends GetxController {
  late TextEditingController kdptimsmh;
  late TextEditingController nim;
  late TextEditingController nama;
  late TextEditingController telp;
  late TextEditingController email;
  late TextEditingController tahunLulus;
  late TextEditingController nik;
  late TextEditingController npwp;

  RxList<Map<String, dynamic>> prodiList = RxList([]);  
  RxString selectedProdi = RxString("");
  RxString selectedId = RxString("");

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    kdptimsmh = TextEditingController();
    kdptimsmh.text = "Politeknik Negeri Jember";
    nim = TextEditingController();
    nama = TextEditingController();
    telp = TextEditingController();
    email = TextEditingController();
    tahunLulus = TextEditingController();
    nik = TextEditingController();
    npwp = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    kdptimsmh.dispose();
    nim.dispose();
    nama.dispose();
    telp.dispose();
    email.dispose();
    tahunLulus.dispose();
    nik.dispose();
    npwp.dispose();
  }

  Future<void> fetchData() async {
    try {
      final data = await getProdi();

      prodiList.assignAll(data);
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<List<Map<String, dynamic>>> getProdi() async {
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

  void handleQuisionerIdentitas() async {
    try {
      EasyLoading.show(status: "Loading...");
      int kodeProdi = int.parse(selectedId.value);
      // ignore: unnecessary_null_comparison
      if (selectedProdi.value != null) {
        final response = await quisionerIdentitas(
            kodeProdi,
            nim.text,
            nama.text,
            telp.text,
            email.text,
            int.parse(tahunLulus.text),
            nik.text,
            npwp.text);
        if (response['code'] == 201) {
          Get.snackbar("Success", response['message'],
              margin: const EdgeInsets.all(10));
          Get.to(() => MainSectionView());
        } else if (response['message'] ==
            'your token is not valid , please login again') {
          Get.dialog(AlertDialog(
            title: Text(
              "Error !",
              textAlign: TextAlign.center,
              style: AppFonts.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            content: Text(
              "Ops , sesi anda telah habis , silahkan login ulang",
              textAlign: TextAlign.center,
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.offAll(() => LoginView());
                },
                child: Text(
                  "OK",
                  style: AppFonts.poppins(
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel",
                    style: AppFonts.poppins(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ));
        } else {
          Get.snackbar("Error", response['message'],
              margin: const EdgeInsets.all(10));
        }
      } else {
        Get.snackbar("Error", "Silahkan pilih program studi anda",
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  static Future<Map<String, dynamic>> quisionerIdentitas(
    int kodeProdi,
    String nim,
    String namaLengkap,
    String noTelp,
    String email,
    int tahunLulus,
    String nik,
    String npwp,
  ) async {
    final Map<String, dynamic> requestBody = {
      "kode_prodi": kodeProdi,
      "nim": nim,
      "nama_lengkap": namaLengkap,
      "no_telp": noTelp,
      "email": email,
      "tahun_lulus": tahunLulus,
      "nik": nik,
      "npwp": npwp,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/identity'),
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
