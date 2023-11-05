import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/modules/alumni/controllers/alumni_all_controller.dart';
import 'package:cdc/app/modules/alumni/controllers/alumni_controller.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AlumniAllView extends GetView<AlumniController> {
  AlumniAllView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(AlumniController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: controller.toggleSortOrder,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 10, left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: primaryColor),
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                      ),
                      child: Center(
                        child: Text(
                          controller.isAscending.value ? "A - Z" : "Z - A",
                          style: AppFonts.poppins(
                              fontSize: 12, color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      // _showProdiBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                          color: white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Program Studi",
                            style: AppFonts.poppins(
                                fontSize: 12, color: primaryColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (controller.showCloseIcon.value == true)
                            InkWell(
                              onTap: () async {
                                controller.selectedProdi = null;
                                controller.showCloseIcon.value = false;

                                controller.alumniList.clear();
                                final data = await controller.fetchAlumniAll(
                                    controller.currentPage,
                                    prodi: controller.selectedProdi!.value,
                                    angkatan: controller.angkatan!.value);

                                if (data is Map<String, dynamic>) {
                                  if (data.containsKey('total_page')) {
                                    controller.totalPage = data['total_page'];
                                  }
                                  final List<Alumni> alumni = data.keys
                                      .where((key) => int.tryParse(key) != null)
                                      .map((key) {
                                    return Alumni.fromJson(data[key]);
                                  }).toList();

                                  controller.alumniList.addAll(alumni);
                                } else {
                                  print(
                                      "Response data is not in the expected format.");
                                }
                              },
                              child: Icon(
                                Icons.close,
                                size: 15,
                                color: black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      // _showAngkatanBottomSheet(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: primaryColor),
                          borderRadius: BorderRadius.circular(10),
                          color: white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.showCloseIconAngkatan.value == false
                                ? "Angkatan"
                                : controller.angkatan.toString(),
                            style: AppFonts.poppins(
                                fontSize: 12, color: primaryColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          if (controller.showCloseIconAngkatan.value == true)
                            InkWell(
                              onTap: () async {
                                controller.angkatan = null;
                                controller.showCloseIconAngkatan.value = false;

                                controller.alumniList.clear();
                                final data = await controller.fetchAlumniAll(
                                    controller.currentPage,
                                    prodi: controller.selectedProdi!.value,
                                    angkatan: controller.angkatan!.value);

                                if (data is Map<String, dynamic>) {
                                  if (data.containsKey('total_page')) {
                                    controller.totalPage = data['total_page'];
                                  }
                                  final List<Alumni> alumni = data.keys
                                      .where((key) => int.tryParse(key) != null)
                                      .map((key) {
                                    return Alumni.fromJson(data[key]);
                                  }).toList();

                                  controller.alumniList.addAll(alumni);
                                } else {
                                  print(
                                      "Response data is not in the expected format.");
                                }
                              },
                              child: Icon(
                                Icons.close,
                                size: 15,
                                color: black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.alumniList.length,
                controller: controller.scrollController,
                itemBuilder: (context, index) {
                  final data = controller.alumniList[index];
                  final educations = data.educations;
                  final filteredEducations = educations
                      .where((education) =>
                          education.perguruan == 'Politeknik Negeri Jember')
                      .toList();
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => DetailUser(
                      //         id: data.user.id ?? "",
                      //       ),
                      //     ));
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.2),
                                image: DecorationImage(
                                    image: NetworkImage(data.user.foto ==
                                            ApiServices.baseUrlImage
                                        ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                        : data.user.foto ?? ""),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  data.user.fullname ?? "",
                                  style: AppFonts.poppins(
                                      fontSize: 14,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              for (var education in filteredEducations)
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jurusan : ${education.jurusan}',
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        'Program studi : ${education.prodi}',
                                        style: AppFonts.poppins(
                                            fontSize: 12, color: black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          '${education.tahunMasuk}',
                                          textAlign: TextAlign.center,
                                          style: AppFonts.poppins(
                                              fontSize: 12, color: white),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          // alignment: Alignment.bottomRight,
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Color(0xffFAC301),
                                          ),
                                          child: Text(
                                            "Kunjungi",
                                            style: AppFonts.poppins(
                                                fontSize: 12,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}