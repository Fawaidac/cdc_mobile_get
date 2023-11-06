import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/detailAlumni/views/education_view.dart';
import 'package:cdc/app/modules/detailAlumni/views/job_view.dart';
import 'package:cdc/app/modules/detailAlumni/views/post_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detail_alumni_controller.dart';

class DetailAlumniView extends GetView<DetailAlumniController> {
  DetailAlumniView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(DetailAlumniController());

  @override
  Widget build(BuildContext context) {
    String idUser = Get.arguments;
    controller.handleUser(idUser);
    controller.fetchFollowerCount(idUser);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        shadowColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Profile",
          style: AppFonts.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            Obx(
              () => SliverAppBar(
                expandedHeight: 380,
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
                          GestureDetector(
                            onTap: () async {},
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.VH39b0tEUhcx63P0laPnKgHaFu?w=230&h=180&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
                              radius: 40,
                            ),
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
                                    visible: controller.userDetail != null,
                                    replacement: CardLoading(
                                      height: 20,
                                      width: MediaQuery.of(context).size.width,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ' ${controller.userDetail?.user.fullname ?? " "}',
                                      style: AppFonts.poppins(
                                        fontSize: 16,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                Visibility(
                                    visible: controller.userDetail != null,
                                    replacement: CardLoading(
                                      height: 15,
                                      margin: const EdgeInsets.only(top: 10),
                                      width: MediaQuery.of(context).size.width,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      ' ${controller.userDetail?.user.alamat ?? " "}',
                                      style: AppFonts.poppins(
                                        fontSize: 12,
                                        color: black,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                showDetailUser(
                                    '${controller.userDetail?.user.fullname}',
                                    '${controller.userDetail?.user.tempatTanggalLahir}',
                                    '${controller.userDetail?.user.email}',
                                    '${controller.userDetail?.user.nik}',
                                    '${controller.userDetail?.user.noTelp}');
                              },
                              icon: Icon(
                                Icons.info_outline,
                                color: primaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                      visible: controller.userDetail != null,
                                      replacement: CardLoading(
                                        height: 15,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        controller.userDetail?.user.about ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFonts.poppins(
                                          fontSize: 12,
                                          color: black,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.handleFollownUnfollow(idUser);
                              },
                              child: Container(
                                width: 100,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      controller.userDetail?.user.isFollow ==
                                              true
                                          ? Border.all(
                                              width: 1, color: primaryColor)
                                          : null,
                                  color: controller.userDetail?.user.isFollow ==
                                          true
                                      ? white
                                      : primaryColor,
                                ),
                                child: Text(
                                  controller.userDetail?.user.isFollow == true
                                      ? "Dikuti"
                                      : "Ikuti",
                                  textAlign: TextAlign.center,
                                  style: AppFonts.poppins(
                                      fontSize: 12,
                                      color: controller
                                                  .userDetail?.user.isFollow ==
                                              true
                                          ? primaryColor
                                          : white),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 1,
                                height: MediaQuery.of(context).size.height,
                                color: black.withOpacity(0.2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => FollowersUser(
                                  //         id: userDetail?.user.id ?? "",
                                  //       ),
                                  //     ));
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: 1,
                                height: MediaQuery.of(context).size.height,
                                color: black.withOpacity(0.2),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => FollowersUser(
                                  //         id: userDetail?.user.id ?? "",
                                  //       ),
                                  //     ));
                                },
                                child: SizedBox(
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
                      Text(
                        "Kontak",
                        style: AppFonts.poppins(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              String linkedin =
                                  controller.userDetail?.user.linkedin ?? "";
                              if (linkedin != null && linkedin.isNotEmpty) {
                                String url =
                                    "http://www.linkedin.com/in/$linkedin";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              }
                            },
                            child: Image.asset(
                              "images/linkedin.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              String ig =
                                  controller.userDetail?.user.instagram ?? "";
                              if (ig != null && ig.isNotEmpty) {
                                String url = "https://www.instagram.com/$ig/";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              }
                            },
                            child: Image.asset(
                              "images/instagram.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              String linkedin =
                                  controller.userDetail?.user.twitter ?? "";
                              if (linkedin != null && linkedin.isNotEmpty) {
                                String url = "https://twitter.com/$linkedin";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              }
                            },
                            child: Image.asset(
                              "images/x.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              String linkedin =
                                  controller.userDetail?.user.facebook ?? "";
                              if (linkedin != null && linkedin.isNotEmpty) {
                                String url =
                                    "https://www.facebook.com/$linkedin";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              }
                            },
                            child: Image.asset(
                              "images/facebook.png",
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
                bottom: TabBar(
                    unselectedLabelColor: grey,
                    labelColor: first,
                    controller: controller.tabController,
                    labelStyle: AppFonts.poppins(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle: AppFonts.poppins(
                        fontSize: 14, color: grey, fontWeight: FontWeight.w500),
                    isScrollable: false,
                    indicatorColor: first,
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
              PostView(
                idUser: idUser,
              ),
              EducationView(
                idUser: idUser,
              ),
              JobView(
                idUser: idUser,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDetailUser(
      String nama, String ttl, String email, String nik, String telp) {
    Get.dialog(AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Profil",
            style: AppFonts.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          Divider(),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama",
              style: AppFonts.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                nama,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
            Divider(),
            Text(
              "Tempat, Tanggal Lahir",
              style: AppFonts.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                ttl,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
            Divider(),
            Text(
              "Email",
              style: AppFonts.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                email,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
            Divider(),
            Text(
              "NIK",
              style: AppFonts.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                nik,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
            Divider(),
            Text(
              "Telepon",
              style: AppFonts.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                telp,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            10.0), // Sesuaikan dengan radius yang Anda inginkan
      ),
    ));
  }
}
