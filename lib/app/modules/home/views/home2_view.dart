import 'package:cdc/app/modules/all_berita/views/all_berita_view.dart';
import 'package:cdc/app/modules/home/controllers/home_controller.dart';
import 'package:cdc/app/modules/home/controllers/post_item_controller.dart';
import 'package:cdc/app/modules/home/views/information_view.dart';
import 'package:cdc/app/modules/home/views/news_view.dart';
import 'package:cdc/app/modules/home/views/post_item_view.dart';
import 'package:cdc/app/modules/home/views/top_alumni_view.dart';
import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2> {
  final controller = Get.put(HomeController());
  final controllerP = Get.put(PostItemController());
  ScrollController scrollController = ScrollController();
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 0,
              pinned: true,
              backgroundColor: white,
              automaticallyImplyLeading: false,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: const EdgeInsets.only(top: 10),
                  color: white,
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TabBar(
                    controller: controller.tabController,
                    unselectedLabelColor: black,
                    labelColor: primaryColor,
                    labelStyle: AppFonts.poppins(
                      fontSize: 12,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: AppFonts.poppins(
                      fontSize: 12,
                      color: black,
                      fontWeight: FontWeight.w500,
                    ),
                    // isScrollable: true,
                    // padding: const EdgeInsets.symmetric(horizontal: 15),
                    // indicator: BoxDecoration(
                    //   color: white,
                    //   border: Border.all(width: 1, color: primaryColor),
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    tabs: const [
                      Tab(text: "Semua"),
                      Tab(text: "Informasi"),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: controller.tabController,
          children: [
            ListView(
              shrinkWrap: false,
              controller: scrollController,
              children: [
                const SizedBox(
                  height: 10,
                ),
                NewsView(),
                const TopAlumniView(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                const PostItemView(),
              ],
            ),
            InformationView()
          ],
        ),
      ),
    );
  }
}
