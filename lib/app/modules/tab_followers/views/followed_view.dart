import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FollowedView extends GetView {
  const FollowedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FollowedView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FollowedView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
