import 'dart:convert';

import 'package:cdc/app/data/models/prodi_model.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  var tahunMasuk = TextEditingController();
  var tahunLulus = TextEditingController();
  var nohp = TextEditingController();

  var phone = "";

  String verifyId = "";
  var showPassword = true.obs;
  var showConfirmPassword = true.obs;
  var loading = false.obs;
  var isLoadingProdi = false.obs;
  ProdiModel? prodiModel;

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
      getProdi2();
      final data = await getProdi();
      prodiList.assignAll(data);
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> getProdi2() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '${ApiServices.baseUrl}/prodi-without-token';

    try {
      isLoadingProdi(true);

      final response = await http.get(
        Uri.parse(url),
        // headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prodiModel = ProdiModel.fromJson(json);
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingProdi(false);
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
    String kodeProdi = selectedId.value;

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
    } else if (nohp.text.isEmpty) {
      Get.snackbar("Error", "No.Telepon harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (prodi.text.isEmpty) {
      Get.snackbar("Error", "Program Studi harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (tahunMasuk.text.isEmpty) {
      Get.snackbar("Error", "Tahun masuk harus diisi",
          margin: const EdgeInsets.all(10));
    } else if (tahunLulus.text.isEmpty) {
      Get.snackbar("Error", "Tahun lulus harus diisi",
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
          handleRegister(
              email.text,
              nik.text,
              fullname.text,
              password.text,
              nohp.text,
              alamat.text,
              nim.text,
              kodeProdi,
              tahunLulus.text,
              tahunMasuk.text);
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
            if (e.code == 'invalid-phone-number') {
              Get.snackbar(
                  "Verification Error", "Verification failed: ${e.message}",
                  margin: const EdgeInsets.all(10));
            } else {
              Get.snackbar(
                  "Verification Error", "Verification failed: ${e.message}",
                  margin: const EdgeInsets.all(10));
            }
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
              'angkatan': tahunMasuk.text,
              'tahun_lulus': tahunLulus.text,
            });
            fullname.clear();
            email.clear();
            password.clear();
            phone = "";
            alamat.clear();
            nik.clear();
            nim.clear();
            kodeProdi = "";
            tahunLulus.clear();
            tahunMasuk.clear();
          },
          codeAutoRetrievalTimeout: (verificationId) {
            verifyId = verificationId;
          });
    } catch (e) {
      print(e);
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
      final response = await register(email, nik, fullname, telp, password,
          alamat, nim, prodi, angkatan, tahunLulus);
      if (response['code'] == 201) {
        Get.offAllNamed(Routes.LOGIN);
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
      'nim': nim.toUpperCase(),
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
}
