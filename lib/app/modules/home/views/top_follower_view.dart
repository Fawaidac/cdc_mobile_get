import 'package:cdc/app/modules/home/controllers/top_alumni_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TopFollowerView extends GetView<TopAlumniController> {
  TopFollowerView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(TopAlumniController());

  @override
  Widget build(BuildContext context) {
    controller.assignTopFollowerData();
    return Scaffold(
        backgroundColor: white.withOpacity(0.98),
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: primaryColor,
              )),
          title: Text(
            "Top 20 Alumni Populer",
            style: AppFonts.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(() => controller.topFollowerList.isEmpty
            ? const SizedBox()
            : controller.isLoadingFoll.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.topFollowerList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final alumni = controller.topFollowerList[index];
                      final alumniNumber = index + 1;

                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '#$alumniNumber',
                                      style: AppFonts.poppins(
                                          fontSize: 14,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    alumni['fullname'],
                                    style: AppFonts.poppins(
                                        fontSize: 14,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: alumni['gender'] == "male"
                                                ? primaryColor
                                                : Colors.pink),
                                        borderRadius: BorderRadius.circular(5),
                                        color: white),
                                    child: Column(
                                      children: [
                                        alumni['gender'] == "male"
                                            ? Icon(
                                                Icons.male,
                                                size: 15,
                                                color: primaryColor,
                                              )
                                            : const Icon(
                                                Icons.female,
                                                size: 15,
                                                color: Colors.pink,
                                              ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 8),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xffFAC301)),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Lihat Profile",
                                            style: AppFonts.poppins(
                                                fontSize: 12,
                                                color: black,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )));
  }
}
