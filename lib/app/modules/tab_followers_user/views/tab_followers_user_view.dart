import 'package:cdc/app/modules/tab_followers_user/controllers/followed_user_controller.dart';
import 'package:cdc/app/modules/tab_followers_user/controllers/followers_user_controller.dart';
import 'package:cdc/app/modules/tab_followers_user/views/followed_user_view.dart';
import 'package:cdc/app/modules/tab_followers_user/views/followers_user_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tab_followers_user_controller.dart';

class TabFollowersUserView extends GetView<TabFollowersUserController> {
  const TabFollowersUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<FollowersUserController>().fetchDataFollowers();
    Get.find<FollowedUserController>().fetchDataFollowed();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: primaryColor,
              )),
          // centerTitle: true,
          title: Obx(() => Text(
                controller.name.value,
                style: AppFonts.poppins(fontSize: 14, color: primaryColor),
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                color: white,
                margin: const EdgeInsets.all(0),
                child: TabBar(
                    unselectedLabelColor: grey,
                    labelColor: primaryColor,
                    labelStyle: AppFonts.poppins(
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle: AppFonts.poppins(
                        fontSize: 12, color: grey, fontWeight: FontWeight.w500),
                    isScrollable: false,
                    indicatorColor: primaryColor,
                    tabs: const [
                      Tab(text: "Pengikut"),
                      Tab(text: "Diikuti"),
                    ]),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBarView(children: [
                  SizedBox(
                      child: Column(
                    children: [
                      FollowersUserView(),
                    ],
                  )),
                  SizedBox(
                    child: Column(
                      children: [
                        FollowedUserView(),
                      ],
                    ),
                  ),
                ]),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
