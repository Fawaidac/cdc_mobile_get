import 'package:cdc/app/modules/profile/controllers/education_user_controller.dart';
import 'package:cdc/app/modules/profile/views/edit_education_user_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/app_dialog.dart';

class EducationUserView extends GetView<EducationUserController> {
  EducationUserView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(EducationUserController());

  @override
  Widget build(BuildContext context) {
    controller.fetchAndAssignEducation();
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          itemCount: controller.educationList.length,
          itemBuilder: (context, index) {
            final educations = controller.educationList[index];
            return Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xff242760).withOpacity(0.03)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${educations.perguruan}",
                          style: AppFonts.poppins(
                              fontSize: 16,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${educations.strata}, ${educations.jurusan}",
                          style: AppFonts.poppins(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "${educations.prodi}, ${educations.tahunMasuk}-${educations.tahunLulus}",
                          style: AppFonts.poppins(
                              fontSize: 12,
                              color: first,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "No. Ijazah: ${educations.noIjasah != null ? educations.noIjasah! : '-'}",
                          style: AppFonts.poppins(
                            fontSize: 12,
                            color: grey,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => EditEducationUserView(),
                              arguments: educations);
                        },
                        child: Icon(
                          Icons.edit,
                          color: primaryColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          AppDialog.show(
                            title: "Perhatian !",
                            isTouch: true,
                            desc: "Apakah anda yakin untuk menghapus data ?",
                            onOk: () async {
                              controller
                                  .handleDeleteEducation("${educations.id}");
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: primaryColor,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
