import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/profile/controllers/profile_controller.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
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
              color: first,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: AppFonts.poppins(
                fontSize: 16, color: first, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.getImageGalery();
                        },
                        child: Obx(
                          () => Stack(
                            children: [
                              controller.image.value == null
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(controller
                                                  .user.value.foto ==
                                              null
                                          ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                          : controller.user.value.foto ?? ""),
                                    )
                                  : CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          FileImage(controller.image.value!),
                                    ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: first),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 15,
                                        color: white,
                                      )))
                            ],
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
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
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
