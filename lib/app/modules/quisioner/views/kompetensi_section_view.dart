import 'package:flutter/material.dart';

import 'package:get/get.dart';

class KompetensiSectionView extends GetView {
  const KompetensiSectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KompetensiSectionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KompetensiSectionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
