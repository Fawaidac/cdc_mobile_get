import 'dart:convert';

import 'package:cdc/app/modules/setting/views/add_education_user_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class KartuAlumniController extends GetxController {
  Future<void> launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      Get.snackbar("Error", "Tidak bisa mengunjungi situs",
          margin: const EdgeInsets.all(10));
    }
  }
}
