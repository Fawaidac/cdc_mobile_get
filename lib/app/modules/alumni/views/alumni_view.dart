import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/modules/alumni/views/alumni_all_view.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/alumni_controller.dart';

class AlumniView extends GetView<AlumniController> {
  AlumniView({Key? key}) : super(key: key);

  Future<void> _refreshData() async {
    controller.alumniList.clear();
    controller.alumniList.refresh();
    await controller.fetchDataAlumni();
  }

  @override
  final controller = Get.put(AlumniController());

  @override
  Widget build(BuildContext context) {
    controller.fetchDataAlumni();
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView(
        shrinkWrap: true,
        controller: controller.scrollController,
        children: [AlumniAllView()],
      ),
    );
  }
}
