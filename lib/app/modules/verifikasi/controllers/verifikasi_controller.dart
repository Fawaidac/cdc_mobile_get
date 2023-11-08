import 'dart:convert';

import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerifikasiController extends GetxController {
  var nimOrEmail = TextEditingController();
  var loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    updateUser();
  }

  Future<void> checkVerifikasi() async {
    if (nimOrEmail.text.isEmpty) {
      Get.snackbar("Error", "Email atau NIM harus diisi",
          margin: const EdgeInsets.all(10));
    } else {
      try {
        loading(true);
        final response = await verifikasi(nimOrEmail.text);
        if (response['code'] == 200) {
          final data = response['data'];

          final String nama = data['nama_lengkap'];
          final String email = data['email'];
          final String nim = data['nim'];
          final String alamat = data['alamat_domisili'];
          final String prodi = data['program_studi'];

          Get.offNamed(Routes.REGISTER, arguments: {
            "fullname": nama,
            "email": email,
            "nim": nim,
            "alamat": alamat,
            "prodi": prodi
          });
        } else if (response['message'] ==
            'ops , data nim atau email kamu tidak ditemukan silahkan ajukan pengajuan data alumni') {
          Get.snackbar("Error",
              "Nim atau Email anda tidak ditemukan, Silahkan ajukan pengajuan data alumni",
              margin: const EdgeInsets.all(10));
        } else {
          Get.snackbar("Error", response['message'],
              margin: const EdgeInsets.all(10));
        }
      } catch (e) {
        print(e);
      } finally {
        loading(false);
      }
    }
  }

  static Future<Map<String, dynamic>> updateUser() async {
    final res = await http.get(
      Uri.parse('${ApiServices.baseUrl}/alumni/update'),
    );
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<Map<String, dynamic>> verifikasi(String key) async {
    final Map<String, dynamic> body = {
      'key': key,
    };
    final res = await http.post(
        Uri.parse('${ApiServices.baseUrl}/verifikasi/alumni'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(res.body);
    return data;
  }
}
