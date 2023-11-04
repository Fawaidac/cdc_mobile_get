import 'dart:convert';

import 'package:cdc/app/modules/register/views/register_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  var fullname = TextEditingController();
  var nik = TextEditingController();
  var email = TextEditingController();
  var nim = TextEditingController();
  var alamat = TextEditingController();
  var prodi = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  var countryCode = TextEditingController();
  var phone = "";

  var showPassword = true.obs;
  var showConfirmPassword = true.obs;
  var loading = false.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void initializeValues({
    required String nama,
    required String email,
    required String nim,
    required String alamat,
    required String prodi,
  }) {
    fullname.text = nama;
    nik.text = nim;
    this.email.text = email;
    this.nim.text = nim;
    this.alamat.text = alamat;
    this.prodi.text = prodi;
    countryCode.text = "+62";
  }

  Future<void> checkRegister() async {
    if (fullname.text.isEmpty) {
      Get.snackbar("Error", "Email harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (nik.text.isEmpty) {
      Get.snackbar("Error", "NIK harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (nik.text.length < 16) {
      Get.snackbar("Error", "NIK harus terdiri dari 16 karakter",
          margin: const EdgeInsets.all(10));
    } else if (email.text.isEmpty) {
      Get.snackbar("Error", "Email harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (!GetUtils.isEmail(email.text)) {
      Get.snackbar("Error", "Format email tidak valid",
          margin: const EdgeInsets.all(10));
    } else if (nim.text.isEmpty) {
      Get.snackbar("Error", "NIM harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (alamat.text.isEmpty) {
      Get.snackbar("Error", "Alamat harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (prodi.text.isEmpty) {
      Get.snackbar("Error", "Program Studi harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (password.text.isEmpty) {
      Get.snackbar("Error", "Password harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (confirmPassword.text.isEmpty) {
      Get.snackbar("Error", "Konfirmasi Password harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (password.text.length < 8) {
      Get.snackbar("Error", "Password tidak boleh kurang dari 8 karakter",
          margin: const EdgeInsets.all(10));
    } else if (confirmPassword.text.length < 8) {
      Get.snackbar(
          "Error", "Konfirmasi Password tidak boleh kurang dari 8 karakter",
          margin: const EdgeInsets.all(10));
    } else if (password.text != confirmPassword.text) {
      Get.snackbar("Error", "Password dan konfirmasi password harus sama",
          margin: const EdgeInsets.all(10));
    } else {
      try {
        loading(true);
        final response = await checkEmail(email.text);
        if (response['code'] == 200) {
        } else {
          Get.snackbar("Error", response['message']);
        }
      } catch (e) {
        print(e);
      } finally {
        loading(false);
      }
    }
  }

  static Future<Map<String, dynamic>> checkEmail(String email) async {
    final res = await http.post(
        Uri.parse('${ApiServices.baseUrl}/auth/verifikasi/email'),
        body: {'email': email});
    final data = jsonDecode(res.body);
    return data;
  }

  Future<void> registerWithNumber() async {
    try {
      await auth.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential authCredential) async {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (verificationId, forceResendingToken) {
            RegisterView.verify = verificationId;
            Get.toNamed(Routes.OTP, arguments: {
              'fullname': fullname,
              'email': email,
              'pw': password,
              'phone': phone,
              'alamat': alamat,
              'nik': nik,
              'nim': nim,
              'prodi': prodi,
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } catch (e) {
      print(e);
    }
  }
}
