import 'package:cdc/app/data/models/comment_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
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

// ignore: must_be_immutable
class DetailPostItemView extends GetView<DetailPostController> {
  final String image;
  final String id;
  final String description;
  final String position;
  final String company;
  final String linkApply;
  final String typeJobs;
  final String expired;
  final String verified;
  final String name;
  final String profile;
  final String postAt;
  final int can;
  final bool isUser;
  List<CommentModel> commentModel;

  DetailPostItemView({
    super.key,
    required this.image,
    required this.description,
    required this.id,
    required this.position,
    required this.company,
    required this.typeJobs,
    required this.expired,
    required this.isUser,
    required this.linkApply,
    required this.verified,
    required this.name,
    required this.profile,
    required this.postAt,
    required this.can,
    required this.commentModel,
  }) : super() {
    controller.initializeComments(commentModel);
  }

  @override
  final controller = Get.put(DetailPostController());

  final homeC = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    String dateTime = postAt;
    final date = DateTime.parse(dateTime);
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final timeFormat = DateFormat('HH:mm');
    final formattedDate = dateFormat.format(date);
    final formattedTime = timeFormat.format(date);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        title: Text(
          "Postingan",
          style: AppFonts.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(profile ==
                                  ApiServices.baseUrlImage
                              ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                              : profile),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: AppFonts.poppins(
                                  fontSize: 12,
                                  color: black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$formattedDate, $formattedTime WIB',
                              style:
                                  AppFonts.poppins(fontSize: 11, color: black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: verified != 'verified',
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(color: primaryColor),
                      child: Column(
                        children: [
                          Visibility(
                            visible: verified != 'verified',
                            child: Text(
                              "! Postingan ini belum terverifikasi ${verified}",
                              style:
                                  AppFonts.poppins(fontSize: 12, color: white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 500,
                    margin: const EdgeInsets.only(top: 20, bottom: 0),
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
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
                          position,
                          style: AppFonts.poppins(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          company,
                          style: AppFonts.poppins(fontSize: 12, color: black),
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
                                typeJobs,
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffF2F2F2)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        expired,
                                        style: AppFonts.poppins(
                                            fontSize: 12, color: black),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.send,
                                  color: black,
                                  size: 20,
                                ),
                                Text(
                                  "Kunjungi",
                                  style: AppFonts.poppins(
                                      fontSize: 12, color: black),
                                )
                              ],
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
                          description,
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
                          style: AppFonts.poppins(fontSize: 12, color: black),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isUser == false,
                    child: CustomTextField(
                        controller: controller.comment,
                        label: "Tulis Komentar...",
                        keyboardType: TextInputType.text,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter,
                        isLength: 255,
                        isEnable: true,
                        isWhite: true,
                        onTap: () =>
                            homeC.sendComment(id, controller.comment.text),
                        icon: Icons.send),
                  ),
                  SizedBox(
                      child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.comments.length,
                      itemBuilder: (context, index) {
                        final comment = controller.comments[index];

                        final User data = comment.user;
                        String dateTime = comment.createdAt.toString();
                        final date = DateTime.parse(dateTime);
                        initializeDateFormatting('id_ID', null);
                        final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
                        final timeFormat = DateFormat('HH:mm');
                        final formattedDate = dateFormat.format(date);
                        final formattedTime = timeFormat.format(date);

                        // Tambahkan pemeriksaan apakah user ada atau tidak

                        return Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(data.foto ==
                                        ApiServices.baseUrlImage
                                    ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                    : ApiServices.baseUrlImage +
                                        (data.foto ?? "")),
                              ),
                              title: Text(
                                data.fullname ?? "",
                                style: AppFonts.poppins(
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                comment.comment,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                              onTap: () {
                                showModalSheet(comment.id);
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
                  )),
                ],
              ),
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
                leading: Icon(Icons.delete, color: Colors.black),
                title: Text(
                  "Hapus Komentar",
                  style: AppFonts.poppins(fontSize: 12, color: Colors.black),
                ),
                onTap: () => homeC.handleDeleteComment(idComment, id),
              )
            ],
          ),
        ),
      ),
    );
  }
}
