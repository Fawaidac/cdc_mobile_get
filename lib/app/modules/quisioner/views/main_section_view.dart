import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MainSectionView extends GetView {
  MainSectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MainSectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MainSectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
