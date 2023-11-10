import 'dart:convert';

import 'package:cdc/app/modules/register/views/register_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  String verifyId = "";
  var showPassword = true.obs;
  var showConfirmPassword = true.obs;
  var loading = false.obs;

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void toggleShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  RxString selectedProdi = RxString("");
  RxString selectedId = RxString("");

  RxList<Map<String, dynamic>> prodiList = RxList([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var args = Get.arguments;
    fullname.text = args['fullname'];
    email.text = args['email'];
    nim.text = args['nim'];
    alamat.text = args['alamat'];
    prodi.text = args['prodi'];
    countryCode.text = "+62";
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
        EasyLoading.show(status: "Loading...");
        final response = await checkEmail(email.text);
        if (response['code'] == 200) {
          registerWithNumber();
        } else {
          Get.snackbar("Error", response['message']);
        }
      } catch (e) {
        print(e);
      } finally {
        EasyLoading.dismiss();
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
    String kodeProdi = selectedId.value;

    try {
      EasyLoading.show(status: "Loading...");
      await auth.verifyPhoneNumber(
          phoneNumber: countryCode.text + phone,
          verificationCompleted: (PhoneAuthCredential authCredential) async {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar(
                "Verification Error", "Verification failed: ${e.message}",
                margin: const EdgeInsets.all(10));
          },
          codeSent: (verificationId, forceResendingToken) {
            verifyId = verificationId;
            print('verifyId register : $verifyId');
            Get.toNamed(Routes.OTP, arguments: {
              'fullname': fullname.text,
              'email': email.text,
              'pw': password.text,
              'phone': phone.toString(),
              'alamat': alamat.text,
              'nik': nik.text,
              'nim': nim.text,
              'kode_prodi': kodeProdi,
            });
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
