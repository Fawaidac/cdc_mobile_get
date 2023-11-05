import 'package:cdc/app/data/models/salary_model.dart';
import 'package:cdc/app/modules/home/controllers/top_alumni_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TopSalaryView extends GetView<TopAlumniController> {
  TopSalaryView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(TopAlumniController());

  @override
  Widget build(BuildContext context) {
    controller.assignTopSallaryData();
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
            "Top 20 Gaji",
            style: AppFonts.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Obx(() => controller.topSalaryUsers.isEmpty
            ? const SizedBox()
            : controller.isLoadingSal.value == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: controller.topSalaryUsers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserProfile userProfile =
                          controller.topSalaryUsers[index];
                      final alumniNumber = index + 1;

                      return Padding(
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
                                  userProfile.fullname,
                                  style: AppFonts.poppins(
                                      fontSize: 16,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  userProfile.company,
                                  style: AppFonts.poppins(
                                      fontSize: 14,
                                      color: grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 200,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: primaryColor),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Rp. ${userProfile.highestSalary}",
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  )));
  }
}
