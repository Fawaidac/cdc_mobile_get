import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/aktifasi_controller.dart';

class AktifasiView extends GetView<AktifasiController> {
  const AktifasiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AktifasiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AktifasiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
