import 'dart:convert';

import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../login/views/login_view.dart';

class UpdatePostController extends GetxController {
  var posisi = TextEditingController();
  var perusahaan = TextEditingController();
  var tautan = TextEditingController();
  var desc = TextEditingController();

  String? selectedType;
  String idPost = "";

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  List<String> typeOptions = [
    'Purnawaktu',
    'Paruh Waktu',
    'Wiraswasta',
    'Pekerja Lepas',
    'Kontrak',
    'Musiman',
  ];

  void selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.value!,
      firstDate: DateTime(2018),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Set only the date part without the time
      selectedDate.value =
          DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var arg = Get.arguments;
    desc.text = arg['description'];
    tautan.text = arg['link_apply'];
    perusahaan.text = arg['company'];
    selectedDate = Rx<DateTime?>(DateTime.tryParse(arg['expired']));
    selectedType = arg['type_jobs'];
    posisi.text = arg['position'];
    idPost = arg['id'];
  }

  void submitPost() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
    String formattedDateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final response = await updatePostUser(
        tautan.text,
        perusahaan.text,
        desc.text,
        formattedDate,
        selectedType.toString(),
        posisi.text,
        formattedDateNow,
        idPost);
    if (response['code'] == 200) {
      // ignore: use_build_context_synchronously
      Get.offAllNamed(Routes.HOMEPAGE);

      Get.snackbar("Success", "Berhasil memperbarui postingan",
          margin: const EdgeInsets.all(10));
    } else if (response['message'] ==
        'your token is not valid , please login again') {
      Get.dialog(AlertDialog(
        title: Text(
          "Error !",
          textAlign: TextAlign.center,
          style: AppFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.bold),
        ),
        contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        content: Text(
          "Ops , sesi anda telah habis , silahkan login ulang",
          textAlign: TextAlign.center,
          style: AppFonts.poppins(fontSize: 12, color: black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAll(() => LoginView());
            },
            child: Text(
              "OK",
              style: AppFonts.poppins(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel",
                style: AppFonts.poppins(
                    fontSize: 16,
                    color: Colors.red,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ));
    } else if (response['message'] ==
        "ops , nampaknya akun kamu belum terverifikasi") {
      Get.dialog(
        AlertDialog(
          title: Text(
            "Error !",
            textAlign: TextAlign.center,
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          content: Text(
            "Ops , nampaknya akun kamu belum terverifikasi, Silahkan isi quisioner terlebih dahulu",
            textAlign: TextAlign.center,
            style: AppFonts.poppins(fontSize: 12, color: black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed(Routes.FASILITAS);
              },
              child: Text(
                "OK",
                style: AppFonts.poppins(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancel",
                  style: AppFonts.poppins(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );
    } else if (response['message'] == "The link must be a valid URL.") {
      Get.snackbar("Error", "Tautan harus menggunakan url yang valid",
          margin: const EdgeInsets.all(10));
    } else {
      Get.snackbar("Error", response['message'],
          margin: const EdgeInsets.all(10));
    }
  }

  static Future<Map<String, dynamic>> updatePostUser(
    String linkApply,
    String company,
    String description,
    String expired,
    String typeJob,
    String position,
    String postAt,
    String idPost,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final Map<String, dynamic> requestBody = {
      "description": description,
      "link": linkApply,
      "type_jobs": typeJob,
      "company": company,
      "position": position,
      "post_at": postAt,
      "expired": expired,
    };

    final response = await http.put(
        Uri.parse('${ApiServices.baseUrl}/user/post/update/$idPost'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody));

    final data = jsonDecode(response.body);
    return data;
  }
}
