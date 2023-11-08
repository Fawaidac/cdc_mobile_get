import 'package:cdc/app/modules/home/controllers/news_controller.dart';
import 'package:cdc/app/modules/home/controllers/post_item_controller.dart';
import 'package:cdc/app/modules/home/views/news_view.dart';
import 'package:cdc/app/modules/home/views/post_item_view.dart';
import 'package:cdc/app/modules/home/views/top_alumni_view.dart';
import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Get.find<NewsController>().newsList.clear();
        await Get.find<NewsController>().fetchNewsData();
      },
      child: ListView(
        shrinkWrap: false,
        controller: controller.scrollController,
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          NewsView(),
          const TopAlumniView(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomTextField(
                controller: controller.search,
                label: "Cari postingan berdasarkan posisi...",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                isLength: 255,
                isEnable: true,
                isWhite: true,
                onTap: () {},
                onChange: (value) {
                  controller.onChangeSearch(value);
                },
                icon: Icons.search),
          ),
          PostItemView(),
        ],
      ),
    );
  }
}
