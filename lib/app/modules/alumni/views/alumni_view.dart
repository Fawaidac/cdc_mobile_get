import 'package:cdc/app/modules/alumni/views/alumni_all_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/alumni_controller.dart';

class AlumniView extends StatefulWidget {
  const AlumniView({Key? key}) : super(key: key);

  @override
  State<AlumniView> createState() => _AlumniViewState();
}

class _AlumniViewState extends State<AlumniView> {
  final controller = Get.put(AlumniController());

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('call');
      if (controller.currentPage < controller.totalPage) {
        controller.currentPage = controller.currentPage + 1;
        controller.fetchDataAlumni();
      }
    } else {
      print('dont call');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> refreshData() async {
      controller.alumniList.clear();
      controller.alumniList.refresh();
      await controller.fetchDataAlumni();
    }

    return RefreshIndicator(
      onRefresh: refreshData,
      child: ListView(
        shrinkWrap: true,
        controller: controller.scrollController,
        children: [AlumniAllView()],
      ),
    );
  }
}
