import 'package:cdc/app/modules/quisioner/views/company_apply_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/find_job_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/identitas_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/job_street_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/job_suitability_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/kompetensi_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/main_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/study_method_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/study_section_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controllers/quisioner_controller.dart';

class QuisionerView extends StatefulWidget {
  const QuisionerView({super.key});

  @override
  State<QuisionerView> createState() => _QuisionerViewState();
}

class _QuisionerViewState extends State<QuisionerView> {
  final controller = Get.put(QuisionerController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchQuisionerData();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    if (status.isDenied) {
      await Permission.location.request();
    }

    if (status.isGranted) {
      Map<String, double> locationData = await getCurrentLocation();
      double latitude = locationData["latitude"] ?? 0.0;
      double longitude = locationData["longitude"] ?? 0.0;

      final res = await controller.updateLocationUser(latitude, longitude);
      if (res['code'] == 200) {
        print("oke");
      } else {
        print(res['message']);
      }
    }
  }

  static Future<Map<String, double>> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      Map<String, double> locationData = {
        "latitude": latitude,
        "longitude": longitude,
      };

      return locationData;
    } catch (e) {
      print("Error getting location: $e");
      return Future.error("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
              )),
          title: Text(
            "Kuisioner",
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
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
                                    fontSize: 12,
                                    color: black,
                                    fontWeight: FontWeight.w500),
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
        break;
      case 3:
        Get.to(() => KompetensiSectionView());
        break;
      case 4:
        Get.to(() => StudyMethodSectionView());
        break;
      case 5:
        Get.to(() => JobStreetSectionView());
        break;
      case 6:
        Get.to(() => FindJobSectionView());
        break;
      case 7:
        Get.to(() => CompanyApplySectionView());
        break;
      default:
        Get.to(() => JobSuitabilitySectionView());
        break;
    }
  }
}
