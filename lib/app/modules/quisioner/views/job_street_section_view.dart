import 'package:flutter/material.dart';

import 'package:get/get.dart';

class JobStreetSectionView extends GetView {
  const JobStreetSectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobStreetSectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JobStreetSectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
