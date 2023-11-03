import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/verifikasi_controller.dart';

class VerifikasiView extends GetView<VerifikasiController> {
  const VerifikasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VerifikasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'VerifikasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
