import 'package:cdc/app/modules/profile/controllers/education_user_controller.dart';
import 'package:cdc/app/modules/profile/views/edit_education_user_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/app_dialog.dart';

class EducationUserView extends StatefulWidget {
  const EducationUserView({Key? key}) : super(key: key);

  @override
  _EducationUserViewState createState() => _EducationUserViewState();
}

class _EducationUserViewState extends State<EducationUserView> {
  final EducationUserController controller = Get.put(EducationUserController());
  final RxList<bool> isVisible = <bool>[].obs;

  @override
  void initState() {
    super.initState();
    controller.fetchAndAssignEducation();
  }

  @override
  Widget build(BuildContext context) {
    controller.update();

    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        itemCount: controller.educationList.length,
        itemBuilder: (context, index) {
          final educations = controller.educationList[index];
          if (isVisible.isEmpty) {
            for (int i = 0; i < controller.educationList.length; i++) {
              isVisible.add(false);
            }
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                isVisible[index] = !isVisible[index];
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              height: isVisible[index] ? 175 : 125,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${educations.perguruan}",
                    style: AppFonts.poppins(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 20,
                    color: black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${educations.strata}, ${educations.jurusan}",
                            style: AppFonts.poppins(
                                fontSize: 12,
                                color: black,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${educations.prodi}, ${educations.tahunMasuk}-${educations.tahunLulus}",
                            style: AppFonts.poppins(
                                fontSize: 12,
                                color: primaryColor,
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
                      )),
                      Icon(
                        isVisible[index]
                            ? Icons.keyboard_arrow_down_rounded
                            : Icons.keyboard_arrow_right_rounded,
                        color: black,
                      )
                    ],
                  ),
                  Spacer(),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.fastOutSlowIn,
                    child: Visibility(
                      visible: isVisible[index],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => EditEducationUserView(),
                                    arguments: educations);
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                primary: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                textStyle: AppFonts.poppins(
                                    fontSize: 12,
                                    color: white,
                                    fontWeight: FontWeight.w500),
                              ),
                              child: Text("Edit"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                AppDialog.show(
                                  title: "Perhatian !",
                                  isTouch: true,
                                  desc:
                                      "Apakah anda yakin untuk menghapus data ?",
                                  onOk: () async {
                                    controller.handleDeleteEducation(
                                        "${educations.id}");
                                    Get.back();
                                  },
                                  onCancel: () {
                                    Get.back();
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                textStyle: AppFonts.poppins(
                                    fontSize: 12,
                                    color: white,
                                    fontWeight: FontWeight.w500),
                              ),
                              child: Text("Hapus"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
