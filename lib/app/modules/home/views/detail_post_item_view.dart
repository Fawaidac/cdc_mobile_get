import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/home/controllers/detail_post_controller.dart';
import 'package:cdc/app/modules/home/controllers/home_controller.dart';
import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../routes/app_pages.dart';

class DetailPostItemView extends StatefulWidget {
  String id;
  bool isUser;
  DetailPostItemView({required this.id, required this.isUser, super.key});

  @override
  State<DetailPostItemView> createState() => _DetailPostItemViewState();
}

class _DetailPostItemViewState extends State<DetailPostItemView> {
  final DetailPostController detailPostController = DetailPostController();

  Future<void> handleUpdateComment(bool option) async {
    final response =
        await detailPostController.nonActiveComment(widget.id, option);
    if (response['code'] == 200) {
      Get.snackbar("Success", "Berhasil memperbarui setelan komentar postingan",
          margin: const EdgeInsets.all(10));
      setState(() {});
    } else {
      Get.snackbar("Error", response['message'],
          margin: const EdgeInsets.all(10));
    }
  }

  final homeC = Get.find<HomeController>();

  Future<void> sendComment(String id, String message) async {
    final response = await detailPostController.storeComment(id, message);
    if (response['code'] == 201) {
      Get.snackbar("Success", "Berhasil mengomentari postingan",
          margin: const EdgeInsets.all(10));
      setState(() {});
    } else {
      Get.snackbar("Error", response['message'],
          margin: const EdgeInsets.all(10));
    }
  }

  Future<void> handleDeleteComment(String idComment) async {
    final response =
        await detailPostController.deleteComment(widget.id, idComment);
    if (response['code'] == 200) {
      Get.snackbar("Success", "Berhasil menghapus postingan",
          margin: const EdgeInsets.all(10));
      setState(() {});
    } else {
      Get.snackbar("Error", response['message'],
          margin: const EdgeInsets.all(10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: black,
            )),
        title: Text(
          "Postingan",
          style: AppFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: detailPostController.fetchDetailPost(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadPost(context);
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData) {
                  return const Text("No data available");
                } else {
                  final post = snapshot.data!;
                  List<Map<String, dynamic>> comments = [];
                  final user = post['uploader'];
                  if (post['comments'] != null) {
                    comments = (post['comments'] as List<dynamic>)
                        .map((comment) => comment as Map<String, dynamic>)
                        .toList();
                  }
                  String dateTime = post['post_at'];
                  final date = DateTime.parse(dateTime);
                  initializeDateFormatting('id_ID', null);
                  final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
                  final timeFormat = DateFormat('HH:mm');
                  final formattedDate = dateFormat.format(date);
                  final formattedTime = timeFormat.format(date);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(user[
                                                'foto'] ==
                                            ApiServices.baseUrlImage
                                        ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                        : user['foto']),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user['fullname'],
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '$formattedDate, $formattedTime WIB',
                                        style: AppFonts.poppins(
                                            fontSize: 11, color: black),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (widget.isUser == true)
                              IconButton(
                                onPressed: () {
                                  showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          MediaQuery.of(context).size.width -
                                              20,
                                          20,
                                          0,
                                          0),
                                      items: [
                                        PopupMenuItem<int>(
                                            value: 0,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: primaryColor,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: AppFonts.poppins(
                                                      fontSize: 12,
                                                      color: black),
                                                ),
                                              ],
                                            )),
                                        PopupMenuItem<int>(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete,
                                                  color: primaryColor,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Hapus",
                                                  style: AppFonts.poppins(
                                                      fontSize: 12,
                                                      color: black),
                                                ),
                                              ],
                                            )),
                                        PopupMenuItem<int>(
                                            value: 2,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  post['can_comment'] == 1
                                                      ? Icons
                                                          .not_interested_sharp
                                                      : Icons.chat_outlined,
                                                  color: primaryColor,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  post['can_comment'] == 1
                                                      ? "Nonaktifkan Komentar"
                                                      : "Aktifkan Komentar",
                                                  style: AppFonts.poppins(
                                                      fontSize: 12,
                                                      color: black),
                                                ),
                                              ],
                                            )),
                                      ]).then((value) {
                                    if (value != null) {
                                      if (value == 1) {
                                        detailPostController
                                            .deletePostingan(widget.id);
                                      } else if (value == 2) {
                                        bool option = post['can_comment'] == 1
                                            ? false
                                            : true;
                                        handleUpdateComment(option);
                                      } else if (value == 0) {
                                        Get.toNamed(Routes.UPDATE_POST,
                                            arguments: {
                                              'id': widget.id,
                                              'link_apply': post['link_apply'],
                                              'description':
                                                  post['description'],
                                              'company': post['company'],
                                              'position': post['position'],
                                              'expired': post['expired'],
                                              'type_jobs': post['type_jobs']
                                            });
                                      }
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.more_vert,
                                  color: black,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: post['verified'] != 'verified',
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: double.infinity,
                          decoration: BoxDecoration(color: primaryColor),
                          child: Column(
                            children: [
                              Text(
                                (post['verified'] == 'waiting')
                                    ? "! Postingan ini belum terverifikasi"
                                    : (post['verified'] == 'rejected')
                                        ? "! Postingan ini ditolak oleh admin"
                                        : "",
                                style: AppFonts.poppins(
                                    fontSize: 12, color: white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 500,
                        margin: const EdgeInsets.only(top: 20, bottom: 0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(post['image']),
                                fit: BoxFit.cover)),
                        width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              post['position'],
                              style: AppFonts.poppins(
                                  fontSize: 14,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              post['company'],
                              style:
                                  AppFonts.poppins(fontSize: 12, color: black),
                            ),
                            const Divider(
                              height: 50,
                            ),
                            Text(
                              "Jenis Pekerjaan",
                              style: AppFonts.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5, bottom: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffF2F2F2)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    post['type_jobs'],
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: black),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ditutup",
                                      style: AppFonts.poppins(
                                          fontSize: 12,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffF2F2F2)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            post['expired'],
                                            style: AppFonts.poppins(
                                                fontSize: 12, color: black),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    if (post['link_apply'].isNotEmpty) {
                                      detailPostController
                                          .launchURL(post['link_apply']);
                                    } else {
                                      print(null);
                                    }
                                  },
                                  child: Container(
                                    color: white,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'images/link.png',
                                          height: 15,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Kunjungi",
                                          style: AppFonts.poppins(
                                              fontSize: 12, color: black),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Deskripsi",
                              style: AppFonts.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ReadMoreText(
                              post['description'],
                              trimLines: 2,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: "Baca Selengkapnya",
                              trimExpandedText: "...Lebih Sedikit",
                              lessStyle: AppFonts.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                              moreStyle: AppFonts.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                              style:
                                  AppFonts.poppins(fontSize: 12, color: black),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Visibility(
                          visible: widget.isUser == false,
                          child: CustomTextField(
                              controller: detailPostController.comment,
                              label: "Tulis Komentar...",
                              keyboardType: TextInputType.text,
                              inputFormatters: FilteringTextInputFormatter
                                  .singleLineFormatter,
                              isLength: 255,
                              isEnable: true,
                              isWhite: false,
                              onTap: () => sendComment(
                                  widget.id, detailPostController.comment.text),
                              icon: Icons.send),
                        ),
                      ),
                      SizedBox(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            final comment = comments[index];

                            // final User data = comment['user'];
                            String dateTime = comment['created_at'];
                            final date = DateTime.parse(dateTime);
                            initializeDateFormatting('id_ID', null);
                            final dateFormat =
                                DateFormat('dd MMMM yyyy', 'id_ID');
                            final timeFormat = DateFormat('HH:mm');
                            final formattedDate = dateFormat.format(date);
                            final formattedTime = timeFormat.format(date);
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: primaryColor,
                                    // backgroundImage: NetworkImage(data.foto ==
                                    //         ApiServices.baseUrlImage
                                    //     ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                    //     : ApiServices.baseUrlImage +
                                    //         (data.foto ?? "")),
                                  ),
                                  title: Text(
                                    "Someone",
                                    style: AppFonts.poppins(
                                        fontSize: 12,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    comment['comment'],
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: black),
                                  ),
                                  onTap: () {
                                    showModalSheet(comment['id']);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        '$formattedDate, $formattedTime',
                                        style: AppFonts.poppins(
                                            fontSize: 10, color: grey),
                                      )),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void showModalSheet(String idComment) {
    Get.bottomSheet(
      Container(
        color: white,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 10,
            left: 15,
            right: 15,
            bottom: Get.mediaQuery.viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.delete, color: Colors.black),
                  title: Text(
                    "Hapus Komentar",
                    style: AppFonts.poppins(fontSize: 12, color: Colors.black),
                  ),
                  onTap: () {
                    handleDeleteComment(idComment);
                    Get.back();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget loadPost(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                CardLoading(
                  height: 50,
                  width: 50,
                  borderRadius: BorderRadius.circular(100),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardLoading(
                      height: 8,
                      width: 100,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CardLoading(
                      height: 8,
                      width: 150,
                    ),
                  ],
                )),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: CardLoading(
              height: 500,
              width: double.infinity,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                CardLoading(
                  height: 8,
                  width: 100,
                ),
                SizedBox(
                  height: 5,
                ),
                CardLoading(
                  height: 8,
                  width: 150,
                ),
                Divider(
                  height: 50,
                ),
                CardLoading(
                  height: 8,
                  width: 70,
                ),
                CardLoading(
                  height: 10,
                  width: 70,
                ),
                SizedBox(
                  height: 5,
                ),
                CardLoading(
                  height: 8,
                  width: 70,
                ),
                CardLoading(
                  height: 10,
                  width: 70,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
