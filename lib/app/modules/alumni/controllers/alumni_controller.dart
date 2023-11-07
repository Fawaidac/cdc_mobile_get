import 'dart:convert';

import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/modules/login/views/login_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AlumniController extends GetxController {
  ScrollController scrollController = ScrollController();

  RxList alumniList = <Alumni>[].obs;

  RxList<Map<String, dynamic>> prodiList = <Map<String, dynamic>>[].obs;

  var currentPage = 1;
  var totalPage = 1;

  RxInt? angkatan;
  RxString? selectedProdi;

  RxBool isLoading = false.obs;
  // RxBool hasMore = true.obs;
  RxBool isAscending = true.obs;
  RxBool showCloseIcon = false.obs;
  RxBool showCloseIconAngkatan = false.obs;

  late TextEditingController search;
  late TextEditingController tahun;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener(_scrollListener);
    search = TextEditingController();
    tahun = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
    search.dispose();
    tahun.dispose();
  }

  Future<void> fetchDataProdi() async {
    final result = await getProdi();
    prodiList.addAll(result);
  }

  void toggleSortOrder() {
    isAscending.value = !isAscending.value;

    if (isAscending.value) {
      alumniList.sort((a, b) => a.user.fullname!.compareTo(b.user.fullname!));
    } else {
      alumniList.sort((a, b) => b.user.fullname!.compareTo(a.user.fullname!));
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage < totalPage) {
        currentPage = currentPage + 1;
        fetchDataAlumni();
        print(currentPage);
      }
    } else {
      print('dont call');
    }
  }

  Future<void> fetchDataAlumni() async {
    try {
      isLoading(true);
      alumniList.clear();
      // Tambahkan pernyataan ini
      final data = await fetchAlumniAll(
        currentPage,
      );

      // ignore: unnecessary_type_check
      if (data is Map<String, dynamic>) {
        if (data.containsKey('total_page')) {
          totalPage = data['total_page'];
          print("Total Page: $totalPage");
          print("Page : $currentPage");
        }
        final List<Alumni> alumni =
            data.keys.where((key) => int.tryParse(key) != null).map((key) {
          return Alumni.fromJson(data[key]);
        }).toList();

        alumniList.addAll(alumni);
      } else {
        print("Response data is not in the expected format.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<List<Map<String, dynamic>>> getProdi() async {
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

  Future<Map<String, dynamic>> fetchAlumniAll(int page,
      {int? angkatan, String? prodi}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    String url = '${ApiServices.baseUrl}/users?page=$page';
    if (angkatan != null) {
      url += '&angkatan=$angkatan';
    }
    if (prodi != null && prodi.isNotEmpty) {
      url += '&prodi=$prodi';
    }

    final response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonResponse['data'];
      return data;
    } else if (jsonResponse['message'] ==
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
      print('Account is not verified');
    } else if (jsonResponse['message'] ==
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
    } else {
      print(
          'Failed to load data ${response.statusCode}'); // Menampilkan pesan kesalahan ke konsol
    }
    // ignore: null_argument_to_non_null_type
    return Future.value();
  }
}
