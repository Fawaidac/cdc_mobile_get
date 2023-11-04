import 'package:cdc/app/data/models/post_model.dart';
import 'package:cdc/app/modules/home/controllers/home_controller.dart';
import 'package:cdc/app/modules/home/views/detail_post_item_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class PostItemView extends GetView {
  PostItemView({super.key});

  @override
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.postList.length,
          itemBuilder: (context, index) {
            if (controller.postList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final post = controller.postList[index];
            if (index < controller.postList.length) {
              String dateTime = controller.postList[index].postAt;
              final date = DateTime.parse(dateTime);
              initializeDateFormatting('id_ID', null);
              final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
              final timeFormat = DateFormat('HH:mm');
              final formattedDate = dateFormat.format(date);
              final formattedTime = timeFormat.format(date);
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailPostItemView(
                        description: post.description,
                        id: post.id,
                        position: post.position,
                        company: post.company,
                        typeJobs: post.typeJobs,
                        expired: post.expired,
                        isUser: false,
                        linkApply: post.linkApply,
                        verified: post.verified,
                        name: post.uploader.fullname ?? "",
                        profile: post.uploader.foto ?? "",
                        can: post.canComment,
                        postAt: post.postAt,
                        commentModel: post.comments,
                        image: post.image,
                      ));
                },
                child: Container(
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
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(post
                                          .uploader.foto ==
                                      ApiServices.baseUrlImage
                                  ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                  : post.uploader.foto ?? ""),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.uploader.fullname ?? "",
                                  style: AppFonts.poppins(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$formattedDate, $formattedTime',
                                  style: AppFonts.poppins(
                                      fontSize: 11, color: black),
                                )
                              ],
                            )),
                            InkWell(
                              onTap: () {
                                show(post.position, post.company, post.typeJobs,
                                    post.description, post.expired);
                              },
                              child: Icon(
                                Icons.info_outline,
                                color: black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        height: 500,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(post.image),
                                fit: BoxFit.cover)),
                        width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            "images/comment.png",
                            height: 30,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
                          child: ReadMoreText(
                            post.description,
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
                          ))
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void show(String position, String company, String typeJobs,
      String description, String expired) {
    Get.dialog(AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            position,
            style: AppFonts.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          Text(
            company,
            style: AppFonts.poppins(
                fontSize: 12, color: black, fontWeight: FontWeight.normal),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jenis Pekerjaan",
                        style: AppFonts.poppins(fontSize: 12, color: black),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white),
                        child: Text(
                          typeJobs,
                          style: AppFonts.poppins(fontSize: 12, color: black),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.send_rounded,
                      color: black,
                    ),
                    Text(
                      "Kunjungi",
                      style: AppFonts.poppins(fontSize: 12, color: black),
                    )
                  ],
                )
              ],
            ),
            Text(
              "Deskripsi",
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: white),
              child: Text(
                description,
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
            Text(
              "Ditutup",
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: white),
              child: Text(
                expired,
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