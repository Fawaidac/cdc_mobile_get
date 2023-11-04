import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TopSalaryView extends GetView {
  const TopSalaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopSalaryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TopSalaryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
