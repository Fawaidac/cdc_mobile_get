import 'package:flutter/material.dart';

import 'package:get/get.dart';

class StudySectionView extends GetView {
  const StudySectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StudySectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StudySectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
