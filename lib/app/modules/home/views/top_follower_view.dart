import 'package:cdc/app/modules/home/controllers/top_alumni_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class TopFollowerView extends GetView<TopAlumniController> {
  TopFollowerView({Key? key}) : super(key: key);

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
          future: controller.assignTopFollowerData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: white,
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
                        "Top 20 Alumni\nPopuler",
                        style: AppFonts.poppins(
                            fontSize: 24,
                            color: white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.builder(
                      itemCount: controller.topFollowerList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final alumni = controller.topFollowerList[index];
                        final alumniNumber = index + 1;

                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes.DETAIL_ALUMNI,
                                arguments: alumni['id']);
                          },
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
                                      image: DecorationImage(
                                          image: NetworkImage(alumni['foto']))),
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
                                        fontSize: 16,
                                        color: white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: alumni['gender'] == "Laki-Laki"
                                              ? white
                                              : white,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: white,
                                      ),
                                      child: Column(
                                        children: [
                                          alumni['gender'] == "Laki-Laki"
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
                                        margin: const EdgeInsets.only(top: 8),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 20,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: const Color(0xffFAC301),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Lihat Profile",
                                              style: AppFonts.poppins(
                                                fontSize: 12,
                                                color: black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
