import 'dart:convert';
import 'dart:io';

import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/modules/profile/controllers/profile_controller.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class EditProfileController extends GetxController {
  final conP = Get.find<ProfileController>();
  Rx<User> user = User().obs;

  var fullname = TextEditingController();
  var ttl = TextEditingController();
  var telp = TextEditingController();
  var jk = TextEditingController();
  var alamat = TextEditingController();
  var nik = TextEditingController();
  var email = TextEditingController();
  var about = TextEditingController();
  var linkedin = TextEditingController();
  var ig = TextEditingController();
  var fb = TextEditingController();
  var x = TextEditingController();
  var newEmail = TextEditingController();

  RxString selectedGender = RxString('Laki-Laki');
  RxList<String> genderOptions = RxList<String>([
    'Laki-Laki',
    'Perempuan',
  ]);

  RxBool isCheckedTelp = false.obs;
  RxBool isCheckedTtl = false.obs;
  RxBool isCheckedAlamat = false.obs;
  RxBool isCheckedNik = false.obs;
  RxBool isCheckedEmail = false.obs;

  Rx<File?> image = Rx<File?>(null);

  Future getImageGalery() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);

    image.value = File(imageFile!.path);
    if (image.value != null) {
      await updateImageProfile(image.value!);
      Get.back();
      Get.snackbar("Success", "Berhasil memperbarui foto profil",
          margin: const EdgeInsets.all(10));
      conP.getUser();
    }
  }

  Future<void> getUser() async {
    final auth = await conP.userInfo();
    if (auth != null) {
      user.value = auth;
      print("userprofile");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // user = Get.arguments;
    getUser();
    // if (user != null) {
    fullname.text = conP.user.value.fullname ?? "";
    selectedGender.value = conP.user.value.gender ?? "";
    telp.text = conP.user.value.noTelp ?? "";
    ttl.text = conP.user.value.tempatTanggalLahir ?? "";
    email.text = conP.user.value.email ?? "";
    nik.text = conP.user.value.nik ?? "";
    alamat.text = conP.user.value.alamat ?? "";
    about.text = conP.user.value.about ?? "";
    linkedin.text = conP.user.value.linkedin ?? "";
    ig.text = conP.user.value.instagram ?? "";
    fb.text = conP.user.value.facebook ?? "";
    x.text = conP.user.value.twitter ?? "";
    conP.user.value.noTelp != null && conP.user.value.noTelp != "***"
        ? isCheckedTelp.value = true
        : false;
    conP.user.value.tempatTanggalLahir != null &&
            conP.user.value.tempatTanggalLahir != "***"
        ? isCheckedTtl.value = true
        : false;
    conP.user.value.email != null && conP.user.value.email != "***"
        ? isCheckedEmail.value = true
        : false;
    conP.user.value.alamat != null && conP.user.value.alamat != "***"
        ? isCheckedAlamat.value = true
        : false;
    conP.user.value.nik != null && conP.user.value.nik != "***"
        ? isCheckedNik.value = true
        : false;
    // }
  }

  RxBool visibilityUpdated = false.obs;
  static Future<String?> updateImageProfile(File imagePath) async {
    try {
      EasyLoading.show(status: "Loading...");
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiServices.baseUrl}/user/profile/image'),
      );
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath.path,
        ),
      );

      final response = await request.send();

      if (response.statusCode == 200) {
        if (response.headers['content-type']!.contains('application/json')) {
          final jsonResponse = await response.stream.bytesToString();
          final data = json.decode(jsonResponse);

          if (data['status'] == true) {
            return data['data'];
          } else {
            throw Exception(
                'Failed to update profile image: ${data['message']}');
          }
        } else {
          throw Exception('Invalid content type in the response');
        }
      } else {
        throw Exception(
            'Failed to update profile image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating profile image: $e');
      throw e;
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> updateVisibility(String key, bool value) async {
    try {
      EasyLoading.show(status: "Loading...");
      await conP.updateVisibility(key, value);
      await conP.getUser();
      telp.text = conP.user.value.noTelp ?? "";
      ttl.text = conP.user.value.tempatTanggalLahir ?? "";
      email.text = conP.user.value.email ?? "";
      nik.text = conP.user.value.nik ?? "";
      alamat.text = conP.user.value.alamat ?? "";
    } catch (e) {
      print('Error updating visibility: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  void handleUpdateProfile() async {
    String? genderValue;
    selectedGender.value == "Laki-Laki"
        ? genderValue = 'male'
        : genderValue = 'female';

    try {
      EasyLoading.show(status: "Loading...");
      final response = await updateUsers(
          fullname.text,
          ttl.text,
          about.text,
          linkedin.text,
          ig.text,
          x.text,
          fb.text,
          telp.text,
          genderValue,
          alamat.text,
          nik.text);
      if (response['code'] == 200) {
        Get.back();
        await conP.getUser();
        Get.snackbar("Success", response['message'],
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

  static Future<Map<String, dynamic>> updateUsers(
    String fullname,
    String ttl,
    String about,
    String linkedIn,
    String instagram,
    String x,
    String facebook,
    String no_telp,
    String gender,
    String alamat,
    String nik,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res =
        await http.put(Uri.parse('${ApiServices.baseUrl}/user/profile'), body: {
      "fullname": fullname,
      "ttl": ttl,
      "about": about,
      "linkedin": linkedIn, // link
      "instagram": instagram, // link
      "x": x, // link
      "facebook": facebook, // link
      "no_telp": no_telp,
      "gender": gender,
      "alamat": alamat,
      "nik": nik,
    }, headers: {
      "Authorization": "Bearer $token"
    });
    final data = jsonDecode(res.body);
    return data;
  }

  Future<void> updateEmailUser(String email) async {
    try {
      EasyLoading.show(status: "Loading...");
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await http.put(
        Uri.parse('${ApiServices.baseUrl}/user/profile/email'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );
      final jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        if (jsonResponse['status'] == true) {
          print(jsonResponse['message']);
          Get.snackbar("Success", jsonResponse['message'],
              margin: const EdgeInsets.all(10));
          Get.offAllNamed(Routes.LOGIN);
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.remove('token');
          preferences.remove('tokenExpirationTime');
        } else {
          Get.snackbar("Success", jsonResponse['message'],
              margin: const EdgeInsets.all(10));
        }
      } else {
        Get.snackbar("Success", jsonResponse['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print('Error updating email: $e');
      throw e;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
