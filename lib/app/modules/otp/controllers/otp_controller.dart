import 'dart:convert';

import 'package:cdc/app/modules/register/views/register_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var code = "";
  var fullname = "";
  var email = "";
  var pw = "";
  var phone = "";
  var alamat = "";
  var nik = "";
  var nim = "";
  var prodi = "";

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

    startCountdown();
  }

  void startCountdown() {
    countdown.value = 30;
    canResend.value = false;

    Future.delayed(Duration(seconds: 1), () {
      countdown.value--;
      if (countdown.value > 0) {
        startCountdown();
      } else {
        canResend.value = true;
      }
    });
  }

  Future<void> verifikasiOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: RegisterView.verify, smsCode: code);
      await auth.signInWithCredential(credential);

      await handleRegister(email, nik, fullname, pw, phone, alamat, nim, prodi);
    } catch (e) {
      Get.snackbar("Error", 'Kode Otp Salah', margin: const EdgeInsets.all(10));
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
  ) async {
    try {
      final response = await register(
          email, nik, fullname, "0$telp", password, alamat, nim, prodi);
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
      String kode) async {
    final Map<String, dynamic> body = {
      'email': email,
      'nik': nik,
      'fullname': fullname,
      'password': password,
      'no_telp': telp,
      'alamat': alamat,
      'nim': alamat,
      'prodi': kode,
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
        verificationCompleted: (PhoneAuthCredential authCredential) async {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (verificationId, forceResendingToken) {
          RegisterView.verify = verificationId;
          startCountdown();
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      print(e);
    }
  }
}
