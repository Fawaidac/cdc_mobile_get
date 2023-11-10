import 'package:flutter/material.dart';

import 'package:get/get.dart';

class StudyMethodSectionView extends GetView {
  const StudyMethodSectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudyMethodSectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudyMethodSectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
