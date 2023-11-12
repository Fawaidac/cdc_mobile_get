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

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (controller.page < controller.totalPage) {
        controller.page = controller.page + 1;

        Get.find<PostItemController>().fetchData();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Get.find<NewsController>().newsList.clear();
        await Get.find<NewsController>().fetchNewsData();
      },
      child: ListView(
        shrinkWrap: false,
        controller: scrollController,
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
