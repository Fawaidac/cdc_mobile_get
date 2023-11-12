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
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        shadowColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: controller.assignTopSallaryData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: white,
                ),
              );
            } else if (controller.topSalaryUsers.isEmpty) {
              return Center(
                child: Text(
                  'Belum ada data',
                  style: AppFonts.poppins(fontSize: 12, color: white),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Top 20 Gaji",
                        style: AppFonts.poppins(
                            fontSize: 24,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
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
                                        fontSize: 16,
                                        color: black,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    userProfile.company,
                                    style: AppFonts.poppins(
                                      fontSize: 14,
                                      color: grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    width: 200,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xff74BCFF),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Rp. ${userProfile.highestSalary}",
                                          style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
