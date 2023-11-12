import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FindJobSectionView extends GetView {
  const FindJobSectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FindJobSectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FindJobSectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
