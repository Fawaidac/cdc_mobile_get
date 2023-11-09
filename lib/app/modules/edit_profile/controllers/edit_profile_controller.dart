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

  String? selectedGender;
  List<String> genderOptions = [
    'Laki Laki',
    'Perempuan',
  ];

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    user = Get.arguments;
    if (user != null) {
      fullname.text = user.value.fullname ?? "";
      user.value.gender == 'male' ? selectedGender == 'Laki Laki' : 'Perempuan';
      telp.text = user.value.noTelp ?? "";
      ttl.text = user.value.tempatTanggalLahir ?? "";
      email.text = user.value.email ?? "";
      nik.text = user.value.nik ?? "";
      alamat.text = user.value.alamat ?? "";
      about.text = user.value.about ?? "";
      linkedin.text = user.value.linkedin ?? "";
      ig.text = user.value.instagram ?? "";
      fb.text = user.value.facebook ?? "";
      x.text = user.value.twitter ?? "";
      user.value.noTelp != null && user.value.noTelp != "***"
          ? isCheckedTelp.value = true
          : false;
      user.value.tempatTanggalLahir != null &&
              user.value.tempatTanggalLahir != "***"
          ? isCheckedTtl.value = true
          : false;
      user.value.email != null && user.value.email != "***"
          ? isCheckedEmail.value = true
          : false;
      user.value.alamat != null && user.value.alamat != "***"
          ? isCheckedAlamat.value = true
          : false;
      user.value.nik != null && user.value.nik != "***"
          ? isCheckedNik.value = true
          : false;
    }
  }

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
}
