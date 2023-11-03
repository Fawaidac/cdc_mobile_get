import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView(
      {String? nama,
      String? email,
      String? nim,
      String? alamat,
      String? prodi,
      Key? key})
      : super(key: key) {
    controller.initializeValues(
        nama: nama!, email: email!, nim: nim!, alamat: alamat!, prodi: prodi!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegisterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
