import 'package:cdc/app/modules/quisioner/views/identitas_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/main_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/study_section_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quisioner_controller.dart';

class QuisionerView extends GetView<QuisionerController> {
  QuisionerView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(QuisionerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: primaryColor,
              )),
          centerTitle: true,
          title: Text(
            "Kuisioner",
            style: AppFonts.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() => ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    RxBool checkboxValue = RxBool(false);
                    final item = controller.data[index];
                    if (controller.quisionerData.isNotEmpty &&
                        index < controller.quisionerData.length) {
                      checkboxValue.value =
                          controller.quisionerData[index]['value'];
                    }

                    return GestureDetector(
                      onTap: () {
                        _navigateToSection(index);
                      },
                      child: Container(
                        color: white,
                        height: 48,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            ),
                            Obx(() => Transform.scale(
                                  scale: 1.1,
                                  child: Checkbox(
                                    activeColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    value: controller
                                                .quisionerData.isNotEmpty &&
                                            index <
                                                controller.quisionerData.length
                                        ? controller.quisionerData[index]
                                            ['value']
                                        : false,
                                    onChanged: (value) {
                                      if (controller.quisionerData.isNotEmpty &&
                                          index <
                                              controller.quisionerData.length) {
                                        controller.quisionerData[index]
                                            ['value'] = value!;
                                      }
                                      controller.update();
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                ))));
  }

  void _navigateToSection(int index) {
    switch (index) {
      case 0:
        Get.to(() => IdentitasSectionView());
        break;
      case 1:
        Get.to(() => MainSectionView());
        break;
      case 2:
        Get.to(() => StudySectionView());

        // Get.to(() => StudyMethodSection());
        break;
      case 3:
        // Get.to(() => KompetensiSection());
        break;
      case 4:
        // Get.to(() => StudyMethodSection());
        break;
      case 5:
        // Get.to(() => JobStreetSection());
        break;
      case 6:
        // Get.to(() => FindJobsSection());
        break;
      case 7:
        // Get.to(() => CompanyApply());
        break;
      default:
        // Get.to(() => JobsuitabilitySection());
        break;
    }
  }
}
