import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/profile/views/education_user_view.dart';
import 'package:cdc/app/modules/profile/views/job_user_view.dart';
import 'package:cdc/app/modules/profile/views/post_user_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    controller.getUser();
    controller.fetchPostCount();
    controller.fetchFollowerCount();
    controller.fetchFollowedCount();
    return Scaffold(
      backgroundColor: white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            Obx(
              () => SliverAppBar(
                expandedHeight: 360,
                pinned: true,
                backgroundColor: white,
                automaticallyImplyLeading: false,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                  color: white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(controller
                                        .user.value.foto ==
                                    ApiServices.baseUrlImage
                                ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                : controller.user.value.foto ?? ""),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Visibility(
                                    // ignore: unnecessary_null_comparison
                                    visible: controller.user != null,
                                    replacement: CardLoading(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      controller.user.value.fullname.toString(),
                                      style: AppFonts.poppins(
                                        fontSize: 16,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                Visibility(
                                    // ignore: unnecessary_null_comparison
                                    visible: controller.user != null,
                                    replacement: CardLoading(
                                      height: 15,
                                      margin: const EdgeInsets.only(top: 10),
                                      width: MediaQuery.of(context).size.width,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      controller.user.value.alamat.toString(),
                                      style: AppFonts.poppins(
                                        fontSize: 12,
                                        color: black,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.SETTING);
                              },
                              icon: Icon(
                                Icons.settings_outlined,
                                color: primaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Visibility(
                            // ignore: unnecessary_null_comparison
                            visible: controller.user != null,
                            replacement: CardLoading(
                              height: 15,
                              width: MediaQuery.of(context).size.width,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              controller.user.value.about.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppFonts.poppins(
                                fontSize: 12,
                                color: black,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${controller.postCount}",
                                      style: AppFonts.poppins(
                                          fontSize: 20,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Post",
                                      style: AppFonts.poppins(
                                          fontSize: 12,
                                          color: black,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: 1,
                                height: MediaQuery.of(context).size.height,
                                color: black.withOpacity(0.2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.TAB_FOLLOWERS_USER,
                                      arguments: controller.user.value.fullname
                                          .toString());
                                },
                                child: SizedBox(
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${controller.followedCount}",
                                        style: AppFonts.poppins(
                                            fontSize: 20,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Mengikuti",
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 1,
                                height: MediaQuery.of(context).size.height,
                                color: black.withOpacity(0.2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.TAB_FOLLOWERS_USER,
                                      arguments: controller.user.value.fullname
                                          .toString());
                                },
                                child: Container(
                                  color: white,
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${controller.followerCount}",
                                        style: AppFonts.poppins(
                                            fontSize: 20,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Pengikut",
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () async {
                              Get.toNamed(Routes.EDIT_PROFILE,
                                  arguments: controller.user);
                            },
                            child: Text('Edit Profil',
                                style: AppFonts.poppins(
                                  fontSize: 14,
                                  color: white,
                                )),
                          )),
                    ],
                  ),
                )),
                bottom: TabBar(
                    unselectedLabelColor: grey,
                    labelColor: primaryColor,
                    controller: controller.tabController,
                    labelStyle: AppFonts.poppins(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle: AppFonts.poppins(
                        fontSize: 14, color: grey, fontWeight: FontWeight.w500),
                    isScrollable: false,
                    indicatorColor: primaryColor,
                    tabs: const [
                      Tab(text: "Post"),
                      Tab(text: "Pendidikan"),
                      Tab(text: "Pekerjaan"),
                    ]),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: TabBarView(
            controller: controller.tabController,
            children: [
              PostUserView(
                name: controller.user.value.fullname.toString(),
                image: controller.user.value.foto.toString(),
              ),
              EducationUserView(),
              JobUserView(),
            ],
          ),
        ),
      ),
    );
  }
}
