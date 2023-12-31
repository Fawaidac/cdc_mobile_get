import 'package:cdc/app/modules/tab_followers/controllers/followed_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// ignore: must_be_immutable
class FollowedView extends GetView<FollowedController> {
  var idUser;

  FollowedView({this.idUser, Key? key}) : super(key: key);

  @override
  final controller = Get.put(FollowedController());
  @override
  Widget build(BuildContext context) {
    // controller.fetchDataFollowed(idUser);

    return Obx(() => ListView.builder(
          itemCount: controller.followersList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final follower = controller.followersList[index];
            return ListTile(
              onTap: () {
                Get.toNamed(Routes.DETAIL_ALUMNI, arguments: follower.id);
              },
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: primaryColor,
                backgroundImage: NetworkImage(follower.foto ==
                        ApiServices.baseUrlImage
                    ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                    : follower.foto ?? ""),
              ),
              title: Text(
                follower.fullname ?? "",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            );
          },
        ));
  }
}
