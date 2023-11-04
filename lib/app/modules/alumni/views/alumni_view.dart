import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/alumni_controller.dart';

class AlumniView extends GetView<AlumniController> {
  const AlumniView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AlumniView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AlumniView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
