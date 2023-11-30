import 'dart:convert';

import 'package:cdc/app/modules/register/controllers/register_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  RxString otpCode = RxString("");
  String fullname = "";
  String email = "";
  String pw = "";
  String phone = "";
  String alamat = "";
  String nik = "";
  String nim = "";
  String prodi = "";
  String angkatan = "";
  String tahunLulus = "";

  RxInt countdown = 30.obs;
  RxBool canResend = false.obs;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    fullname = args['fullname'];
    email = args['email'];
    pw = args['pw'];
    phone = args['phone'];
    alamat = args['alamat'];
    nik = args['nik'];
    nim = args['nim'];
    prodi = args['kode_prodi'];
    tahunLulus = args['tahun_lulus'];
    angkatan = args['angkatan'];
    startCountdown();
  }

  void startCountdown() {
    countdown.value = 30;
    canResend.value = false;

    Future.delayed(const Duration(seconds: 1), () {
      countdown.value--;
      if (countdown.value > 0) {
        startCountdown();
      } else {
        canResend.value = true;
      }
    });
  }

  Future<void> verifikasiOtp(String code) async {
    try {
      EasyLoading.show(status: "Loading...");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: Get.find<RegisterController>().verifyId,
          smsCode: otpCode.value);
      await auth.signInWithCredential(credential);

      await handleRegister(email, nik, fullname, pw, phone, alamat, nim, prodi,
          angkatan, tahunLulus);
    } catch (e) {
      Get.snackbar("Error", 'Kode Otp Salah', margin: const EdgeInsets.all(10));
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> handleRegister(
    String email,
    String nik,
    String fullname,
    String password,
    String telp,
    String alamat,
    String nim,
    String prodi,
    String tahunLulus,
    String angkatan,
  ) async {
    try {
      final response = await register(email, nik, fullname, "0$telp", password,
          alamat, nim, prodi, angkatan, tahunLulus);
      if (response['code'] == 201) {
        Get.offNamed(Routes.LOGIN);
        Get.snackbar("Success", response['message'],
            margin: const EdgeInsets.all(10));
      } else {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>> register(
    String email,
    String nik,
    String fullname,
    String telp,
    String password,
    String alamat,
    String nim,
    String kode,
    String angkatan,
    String tahunLulus,
  ) async {
    final Map<String, dynamic> body = {
      'email': email,
      'nik': nik,
      'fullname': fullname,
      'password': password,
      'no_telp': telp,
      'alamat': alamat,
      'nim': alamat,
      'kode_prodi': kode,
      'angkatan': angkatan,
      'tahun_lulus': tahunLulus,
    };
    final res = await http.post(
        Uri.parse('${ApiServices.baseUrl}/auth/user/register'),
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(res.body);
    return data;
  }

  void sendOtpAgain() async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+62$phone",
        verificationCompleted: (PhoneAuthCredential authCredential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (verificationId, forceResendingToken) {
          Get.find<RegisterController>().verifyId = verificationId;
          startCountdown();
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Terjadi kesalahan saat mengirim ulang kode: $e",
          margin: const EdgeInsets.all(10));
    }
  }
}
