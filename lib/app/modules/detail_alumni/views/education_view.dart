import 'package:cdc/app/modules/detail_alumni/controllers/education_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationView extends GetView<EducationController> {
  final String idUser;

  EducationView({required this.idUser, Key? key}) : super(key: key);

  @override
  final controller = Get.put(EducationController());

  @override
  Widget build(BuildContext context) {
    controller.fetchData(idUser);

    return Obx(() {
      final educations = controller.educations;

      return ListView.builder(
        itemCount: educations.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final education = educations[index];

          return Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xff242760).withOpacity(0.03),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${education.perguruan}",
                        style: AppFonts.poppins(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${education.strata}, ${education.jurusan}",
                        style: AppFonts.poppins(
                          fontSize: 14,
                          color: black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${education.prodi}, ${education.tahunMasuk}-${education.tahunLulus}",
                        style: AppFonts.poppins(
                          fontSize: 12,
                          color: first,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "No. Ijazah: ${education.noIjasah != null ? education.noIjasah! : '-'}",
                        style: AppFonts.poppins(
                          fontSize: 12,
                          color: grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
