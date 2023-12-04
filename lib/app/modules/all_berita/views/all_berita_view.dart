import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_berita_controller.dart';

class AllBeritaView extends GetView<AllBeritaController> {
  const AllBeritaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllBeritaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AllBeritaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
