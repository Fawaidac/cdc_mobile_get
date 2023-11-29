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

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  final controller = Get.put(HomepageController());

  int i = 0;

  List navButtons = [
    {
      "active": Image.asset(
        "images/active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Home"
    },
    {
      "active": Image.asset(
        "images/active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Alumni"
    },
    {
      "active": Image.asset(
        "images/active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Posting"
    },
    {
      "active": Image.asset(
        "images/fill.png",
        height: 25,
        width: 25,
      ),
      "non_active": Image.asset(
        "images/non.png",
        height: 25,
        width: 25,
        color: primaryColor,
      ),
      "label": "Ikapj"
    },
    {
      "active": Image.asset(
        "images/active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "non_active": Image.asset(
        "images/non_active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "label": "Profil"
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.requestPermissions();
    controller.storeFcmToken();
  }

  void onTap(v) {
    setState(() {
      i = v;
    });
  }

  List<Widget> screen = <Widget>[
    const HomeView(),
    const AlumniView(),
    PostingView(),
    IkapjView(),
    ProfileView(),
  ];

  bool active = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: TextFormField(
              onTap: () {
                setState(() {
                  active = true;
                });
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
                    setState(() {
                      active = true;
                    });
                  },
                  child: Icon(
                    active ? Icons.search : Icons.close,
                    color: primaryColor,
                  ),
                ),
                hintText: "Search...",
                isDense: true,
                hintStyle: GoogleFonts.poppins(fontSize: 12, color: grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Color(0xffC4C4C4).withOpacity(0.2),
              ),
            ),
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
          body: active
              ? screen[i]
              : ListView.builder(
                  itemCount: controller.searchResult.length,
                  itemBuilder: (context, index) {
                    final user = controller.searchResult[index];

                    return UsersItemView(user);
                  },
                ),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            selectedLabelStyle:
                AppFonts.poppins(fontSize: 12, color: primaryColor),
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            selectedItemColor: primaryColor,
            currentIndex: i,
            onTap: onTap,
            elevation: 0,
            backgroundColor: Colors.white,
            items: List.generate(5, (i) {
              var navBtn = navButtons[i];
              return BottomNavigationBarItem(
                  icon: navBtn["non_active"],
                  activeIcon: navBtn["active"],
                  label: navBtn["label"]);
            }),
          ),
        );
      },
    );
  }
}
