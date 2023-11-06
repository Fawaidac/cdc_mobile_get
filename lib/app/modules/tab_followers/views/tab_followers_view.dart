import 'package:cdc/app/modules/tab_followers/views/followed_view.dart';
import 'package:cdc/app/modules/tab_followers/views/followers_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tab_followers_controller.dart';

class TabFollowersView extends GetView<TabFollowersController> {
  TabFollowersView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(TabFollowersController());

  @override
  Widget build(BuildContext context) {
    String userId = Get.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: primaryColor,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
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
                      FollowersView(
                        idUser: userId,
                      ),
                    ],
                  )),
                  SizedBox(
                    child: Column(
                      children: [
                        FollowedView(
                          idUser: userId,
                        ),
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
