import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/posting_controller.dart';

class PostingView extends GetView<PostingController> {
  const PostingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PostingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
