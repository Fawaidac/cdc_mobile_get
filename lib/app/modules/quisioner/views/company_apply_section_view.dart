import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CompanyApplySectionView extends GetView {
  const CompanyApplySectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CompanyApplySectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CompanyApplySectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
