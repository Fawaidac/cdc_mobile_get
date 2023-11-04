import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ikapj_controller.dart';

class IkapjView extends GetView<IkapjController> {
  const IkapjView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IkapjView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IkapjView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
