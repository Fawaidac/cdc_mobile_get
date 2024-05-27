import 'dart:convert';

import 'package:cdc/app/data/models/jurusan_model.dart';
import 'package:cdc/app/data/models/kode_quesioner_model.dart';
import 'package:cdc/app/data/models/paket_quesioner_model.dart';
import 'package:cdc/app/data/models/prodi_model.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PaketQuesionerController extends GetxController {
  PaketQuesionerModel? model;
  ProdiModel? prodiM;
  JurusanModel? jurusanM;
  KodeQuesionerModel? kodeQuesionerM;

  var isLoading = false.obs;
  var isLoadingProdi = false.obs;
  var isLoadingJurusan = false.obs;
  var isLoadingKode = false.obs;

  var isEmptyData = true.obs;
  var page = 1.obs;
  var idPaket = "".obs;
  var titlePaket = "".obs;
  List answerQuesioner = [].obs;

  Map<String, dynamic> requestBody = {};
  Map<String, dynamic> nullValues = {};
  List<String> keysKodeQuesioner = [];

  Future<void> getPaket(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url =
        '${ApiServices.baseUrl}/kuesioner/detail/$id?page=${page.value}';

    try {
      isLoading(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        model = PaketQuesionerModel.fromJson(json);
      } else {
        debugPrint(response.statusCode.toString());
      }
      // List<String> tes = jsonDecode(model!.data[0].options ?? '');
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> getProdi() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final kodeProdi = prefs.getInt('kode_prodi');

    print("KODE : " + kodeProdi.toString());

    String url = '${ApiServices.baseUrl}/prodi/$kodeProdi';

    try {
      isLoadingProdi(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prodiM = ProdiModel.fromJson(json);
        print(json);
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingProdi(false);
    }
  }

  Future<void> getJurusan() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '${ApiServices.baseUrl}/jurusan';

    try {
      isLoadingJurusan(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        jurusanM = JurusanModel.fromJson(json);
      } else {
        debugPrint(response.statusCode.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingJurusan(false);
    }
  }

  Future<void> getKodeQuesioner(id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final idUser = prefs.getString('id_user');

    String url = '${ApiServices.baseUrl}/get-kode-kuesioner/$id';

    requestBody = {
      "user_id": idUser,
      "id_paket_kuesioner": idPaket.value,
    };
    try {
      isLoadingKode(true);

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        kodeQuesionerM = KodeQuesionerModel.fromJson(json);
      } else {
        debugPrint(response.statusCode.toString());
      }
      kodeQuesionerM!.data.forEach((element) {
        requestBody[element.kodePertanyaan] = null;
      });

      String jsonRequestBody = jsonEncode(requestBody);

      Map<String, dynamic> data = jsonDecode(jsonRequestBody);

      data.forEach((key, value) {
        if (value == null || value == '') {
          nullValues[key] = null;
        }
      });

      keysKodeQuesioner = nullValues.keys.toList();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingKode(false);
    }
  }

  Future<void> postQuesioner() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    String url = '${ApiServices.baseUrl}/kuesioner';

    try {
      isLoadingJurusan(true);

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );
      final json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Berhasil isi quesioner");
        Get.toNamed(Routes.HOMEPAGE);
      } else {
        debugPrint(response.statusCode.toString());
        AppDialog.show(
          title: "Perhatian !",
          isTouch: false,
          desc: json['data'][0].toString(),
          onOk: () async {
            Get.back();
          },
        );
      }
      // print(json);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoadingJurusan(false);
    }
  }
}
