import 'dart:convert';

import 'package:cdc/app/modules/quisioner/views/study_method_section_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class KompetensiSectionController extends GetxController {
  String? selectedEtikaLulus;
  String? selectedEtikaNow;
  String? selectedKeahlianLulus;
  String? selectedKeahlianNow;
  String? selectedEnglishLulus;
  String? selectedEnglishNow;
  String? selectedItLulus;
  String? selectedItNow;
  String? selectedKomunikasiLulus;
  String? selectedKomunikasiNow;
  String? selectedTeamWorkLulus;
  String? selectedTeamWorkNow;
  String? selectedSelfDevLulus;
  String? selectedSelfDevNow;
  List<String> tingkatOptions = [
    'Sangat Rendah',
    'Rendah',
    'Netral',
    'Tinggi',
    'Sangat Tinggi',
  ];
  void handleQuisionerKompetensi() async {
    try {
      EasyLoading.show(status: "Loading...");
      final response = await quisionerKompetensi(
          selectedEtikaLulus.toString(),
          selectedEtikaNow.toString(),
          selectedKeahlianLulus.toString(),
          selectedKeahlianNow.toString(),
          selectedEnglishLulus.toString(),
          selectedEnglishNow.toString(),
          selectedItLulus.toString(),
          selectedItNow.toString(),
          selectedKomunikasiLulus.toString(),
          selectedKomunikasiNow.toString(),
          selectedTeamWorkLulus.toString(),
          selectedTeamWorkNow.toString(),
          selectedSelfDevLulus.toString(),
          selectedSelfDevNow.toString());
      if (response['code'] == 201) {
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
        Get.to(() => StudyMethodSectionView());
      } else if (response['message'] == 'Quisioner level not found') {
        Get.snackbar(
            "Error", "Silahkan isi quisioner identitas terlebih dahulu",
            margin: const EdgeInsets.all(10));
      } else if (response['message'] ==
          'gagal mengisi kuisioner Ops , Nampaknya kamu belum mengisi quisioner sebelumnya') {
        Get.snackbar("Error", response['message'],
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

  static Future<Map<String, dynamic>> quisionerKompetensi(
    String etikLulus,
    String etikNow,
    String keahlianLulus,
    String keahlianNow,
    String englishLulus,
    String englishNow,
    String itLulus,
    String itNow,
    String komunikasiLulus,
    String komunikasiNow,
    String teamWorkLulus,
    String teamWorkNow,
    String selfDevLulus,
    String selfDevNow,
  ) async {
    final Map<String, dynamic> requestBody = {
      "etik_lulus": etikLulus,
      "etika_saatini": etikNow,
      "keahlian_lulus": keahlianLulus,
      "keahlian_saatini": keahlianNow,
      "english_lulus": englishLulus,
      "english_saatini": englishNow,
      "teknologi_informasi_lulus": itLulus,
      "teknologi_informasi_saatini": itNow,
      "komunikasi_lulus": komunikasiLulus,
      "komunikasi_saatini": komunikasiNow,
      "kerjasama_lulus": teamWorkLulus,
      "kerjasama_saatini": teamWorkNow,
      "pengembangan_diri_lulus": selfDevLulus,
      "pengembangan_diri_saatini": selfDevNow,
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/quisioner/competence'),
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
