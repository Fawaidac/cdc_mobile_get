import 'package:cdc/app/modules/alumni/views/alumni_view.dart';
import 'package:cdc/app/modules/home/views/home_view.dart';
import 'package:cdc/app/modules/homepage/views/users_item_view.dart';
import 'package:cdc/app/modules/ikapj/views/ikapj_view.dart';
import 'package:cdc/app/modules/posting/views/posting_view.dart';
import 'package:cdc/app/modules/profile/views/profile_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  HomepageView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(HomepageController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Obx(() => TextFormField(
                onTap: () {
                  controller.setActive(false);
                },
                textInputAction: TextInputAction.done,
                controller: controller.searchController,
                onChanged: (value) {
                  controller.searchUser(value);
                },
                style: AppFonts.poppins(fontSize: 12, color: black),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: InkWell(
                    onTap: () {
                      controller.setActive(true);
                    },
                    child: Icon(
                      controller.active.value ? Icons.search : Icons.close,
                      color: primaryColor,
                    ),
                  ),
                  hintText: "Search...",
                  isDense: true,
                  hintStyle: GoogleFonts.poppins(fontSize: 12, color: grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                ),
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.NOTIFICATIONS);
                    },
                    child: SizedBox(
                      child: Image.asset(
                        "images/bell.png",
                        height: 20,
                        alignment: Alignment.center,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.FASILITAS);
                    },
                    child: Icon(
                      Icons.dashboard_customize_rounded,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            )
          ],
        ),
        body: Obx(() => controller.active.value
            ? IndexedStack(
                index: controller.currentIndex.value,
                children: [
                  HomeView(),
                  AlumniView(),
                  const PostingView(),
                  const IkapjView(),
                  const ProfileView(),
                ],
              )
            : ListView.builder(
                itemCount: controller.searchResult.length,
                itemBuilder: (context, index) {
                  final user = controller.searchResult[index];

                  return UsersItemView(user);
                },
              )),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            showSelectedLabels: false,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            selectedItemColor: primaryColor,
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            elevation: 0,
            backgroundColor: Colors.white,
            items: List.generate(5, (index) {
              var navBtn = controller.navButtons[index];
              return BottomNavigationBarItem(
                  icon: navBtn["non_active"],
                  activeIcon: navBtn["active"],
                  label: navBtn["label"]);
            }),
          ),
        ));
  }
}
