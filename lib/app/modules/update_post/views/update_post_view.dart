import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_post_controller.dart';

class UpdatePostView extends GetView<UpdatePostController> {
  const UpdatePostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdatePostView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UpdatePostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
