import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IdentitasSectionController extends GetxController {
  late TextEditingController kdptimsmh;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    kdptimsmh = TextEditingController();
    kdptimsmh.text = "Politeknik Negeri Jember";
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    kdptimsmh.dispose();
  }
}
