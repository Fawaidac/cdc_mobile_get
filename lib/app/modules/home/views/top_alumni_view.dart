import 'package:cdc/app/modules/home/views/top_follower_view.dart';
import 'package:cdc/app/modules/home/views/top_salary_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/app_dialog.dart';

class TopAlumniView extends GetView {
  const TopAlumniView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
          child: Text(
            "Teratas",
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            margin: const EdgeInsets.only(left: 0, bottom: 10, top: 0),
            padding: const EdgeInsets.all(10),
            height: 125,
            child: ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 0) {
                      Get.to(() => TopFollowerView());
                    } else if (index == 1) {
                      Get.to(() => TopSalaryView());
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 270,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Image.asset(
                                  index == 0
                                      ? "images/personal-growth.png"
                                      : "images/profit-growth.png",
                                  color: white,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (index == 0)
                                      Text(
                                        "Top 20 Alumni",
                                        style: AppFonts.poppins(
                                            fontSize: 14,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    if (index == 1)
                                      Text(
                                        "Top 20 Salary",
                                        style: AppFonts.poppins(
                                            fontSize: 14,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    if (index == 0)
                                      Text(
                                        "Alumni terbaik lulusan Politeknik Negeri Jember",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    if (index == 1)
                                      Text(
                                        "Salary teratas lulusan Politeknik Negeri Jember",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.normal),
                                      )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ],
    );
  }
}
