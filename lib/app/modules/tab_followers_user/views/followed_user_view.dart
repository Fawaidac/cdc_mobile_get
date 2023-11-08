import 'package:cdc/app/modules/tab_followers_user/controllers/followed_user_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/app_fonts.dart';

class FollowedUserView extends GetView<FollowedUserController> {
  FollowedUserView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(FollowedUserController());
  @override
  Widget build(BuildContext context) {
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
