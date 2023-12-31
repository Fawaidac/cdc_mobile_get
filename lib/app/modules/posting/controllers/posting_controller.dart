import 'dart:convert';
import 'dart:io';

import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_dialog.dart';

class PostingController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  var keterangan = TextEditingController();
  var posisi = TextEditingController();
  var perusahaan = TextEditingController();
  var tautan = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;

  String? selectedType;
  List<String> typeOptions = [
    'Purnawaktu',
    'Paruh Waktu',
    'Wiraswasta',
    'Pekerja Lepas',
    'Kontrak',
    'Musiman',
  ];
  void toggleChangeType(String v) {
    selectedType = v;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future getImageGalery() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);

    image.value = File(imageFile!.path);
  }

  void selectDate(BuildContext _) async {
    final DateTime? pickedDate = await showDatePicker(
      context: _,
      initialDate: selectedDate.value,
      firstDate: DateTime(2018),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  void check() {
    if (image.value == null) {
      Get.snackbar("Error", "Gambar tidak boleh kosong",
          margin: const EdgeInsets.all(10));
    } else {
      submitPost();
    }
  }

  void submitPost() async {
    try {
      EasyLoading.show(status: "Loading...");
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);
      final response = await post(
          image: image.value!,
          linkApply: tautan.text,
          company: perusahaan.text,
          description: keterangan.text,
          expired: formattedDate,
          typeJob: selectedType.toString(),
          position: posisi.text);
      if (response['code'] == 201) {
        Get.offAllNamed(Routes.HOMEPAGE);
        Get.snackbar("Success",
            "Berhasil mengunggah postingan, mohon menunggu verifikasi dari admin",
            margin: const EdgeInsets.all(10));
      } else if (response['message'] ==
          'your token is not valid , please login again') {
        AppDialog.show(
          title: "Error !",
          isTouch: false,
          desc: "Ops , sesi anda telah habis , silahkan login ulang",
          onOk: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.remove('token');
            preferences.remove('tokenExpirationTime');

            Get.offAllNamed(Routes.LOGIN);
            Get.snackbar("Success", "Berhasil keluar dari aplikasi",
                margin: const EdgeInsets.all(10));
          },
          onCancel: () {
            Get.back();
          },
        );
      } else if (response['message'] ==
          "ops , nampaknya akun kamu belum terverifikasi") {
        AppDialog.show(
          title: "Perhatian !",
          isTouch: false,
          desc:
              "Ops , nampaknya akun kamu belum terverifikasi, Silahkan isi quisioner terlebih dahulu",
          onOk: () {
            Get.toNamed(Routes.FASILITAS);
          },
          onCancel: () {
            Get.back();
          },
        );
      } else if (response['message'] ==
          "The image must not be greater than 1048 kilobytes.") {
        Get.snackbar("Error", "Gambar tidak boleh melebihi 1048 Kb",
            margin: const EdgeInsets.all(10));
      } else if (response['message'] == 'The link apply must be a valid URL.') {
        Get.snackbar("Error", "Tautan harus menggunakan url yang valid",
            margin: const EdgeInsets.all(10));
      } else if (response['message'] ==
          'The image must be a file of type: jpeg, png, jpg.') {
        Get.snackbar("Error", "Gambar harus dalam format jpeg, png atau jpg",
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

  static Future<Map<String, dynamic>> post({
    required File image,
    required String linkApply,
    required String company,
    required String description,
    required String expired,
    required String typeJob,
    required String position,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    // Buat request Multipart
    final request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServices.baseUrl}/user/post'));
    request.headers['Authorization'] = 'Bearer $token';

    // Tambahkan data Multipart
    request.fields['link_apply'] = linkApply;
    request.fields['company'] = company;
    request.fields['description'] = description;
    request.fields['expired'] = expired;
    request.fields['type_job'] = typeJob;
    request.fields['position'] = position;

    // Tambahkan gambar sebagai File Multipart
    final imageFileName = path.basename(image.path);
    final imageStream = http.ByteStream(image.openRead());
    final imageLength = await image.length();
    final imageUpload = http.MultipartFile('image', imageStream, imageLength,
        filename: imageFileName);
    request.files.add(imageUpload);

    final response = await request.send();
    final streamedResponse = await http.Response.fromStream(response);
    final data = json.decode(streamedResponse.body);
    return data;
  }
}
