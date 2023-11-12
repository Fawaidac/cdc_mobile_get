import 'package:flutter/material.dart';

import 'package:get/get.dart';

class JobSuitabilitySectionView extends GetView {
  const JobSuitabilitySectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobSuitabilitySectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JobSuitabilitySectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
