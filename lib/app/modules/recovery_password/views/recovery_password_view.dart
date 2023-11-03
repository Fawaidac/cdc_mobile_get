import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/recovery_password_controller.dart';

class RecoveryPasswordView extends GetView<RecoveryPasswordController> {
  const RecoveryPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecoveryPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecoveryPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
