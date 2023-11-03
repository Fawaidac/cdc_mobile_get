import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var fullname = TextEditingController();
  var nik = TextEditingController();
  var email = TextEditingController();
  var nim = TextEditingController();
  var alamat = TextEditingController();
  var prodi = TextEditingController();

  void initializeValues({
    required String nama,
    required String email,
    required String nim,
    required String alamat,
    required String prodi,
  }) {
    fullname.text = nama;
    nik.text = nim;
    this.email.text = email;
    this.nim.text = nim;
    this.alamat.text = alamat;
    this.prodi.text = prodi;
  }
}
