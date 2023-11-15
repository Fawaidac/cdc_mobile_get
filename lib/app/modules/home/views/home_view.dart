import 'package:cdc/app/modules/home/controllers/news_controller.dart';
import 'package:cdc/app/modules/home/controllers/post_item_controller.dart';
import 'package:cdc/app/modules/home/views/news_view.dart';
import 'package:cdc/app/modules/home/views/post_item_view.dart';
import 'package:cdc/app/modules/home/views/top_alumni_view.dart';
import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:cdc/app/routes/app_pages.dart';
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
  final controllerP = Get.put(PostItemController());
  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (controllerP.page < controllerP.totalPage) {
        controllerP.page = controllerP.page + 1;

        controllerP.fetchData();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void update() async {
    await controllerP.fetchData();
    Get.toNamed(Routes.HOMEPAGE);
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
        controllerP.postList.refresh();
        controllerP.update();

        setState(() {});
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
                controller: controllerP.searchController,
                label: "Cari postingan berdasarkan posisi...",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                isLength: 255,
                isEnable: true,
                isWhite: true,
                onTap: () {},
                onChange: (value) {
                  controllerP.filterPosts(value);
                },
                icon: Icons.search),
          ),
          PostItemView(),
        ],
      ),
    );
  }
}
