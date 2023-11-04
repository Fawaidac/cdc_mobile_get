import 'package:cdc/app/modules/homepage/views/users_item_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: 48,
            child: Obx(() => TextFormField(
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
                    hintText: "Search",
                    isDense: true,
                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                )),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  SizedBox(
                    child: Image.asset(
                      "images/bell.png",
                      height: 20,
                      alignment: Alignment.center,
                      color: primaryColor,
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
            ? controller.screen[controller.currentIndex.value]
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
