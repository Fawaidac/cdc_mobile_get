import 'package:cdc/app/modules/detail_alumni/controllers/education_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EducationView extends StatefulWidget {
  final String idUser;

  EducationView({required this.idUser, Key? key}) : super(key: key);

  @override
  _EducationViewState createState() => _EducationViewState();
}

class _EducationViewState extends State<EducationView> {
  final EducationController controller = Get.put(EducationController());

  @override
  void initState() {
    super.initState();
    controller.fetchData(widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final educations = controller.educations;

      return ListView.builder(
        itemCount: educations.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final education = educations[index];

          return Container(
            height: 125,
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
                  "${education.perguruan}",
                  style: AppFonts.poppins(
                      fontSize: 14, color: black, fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 20,
                  color: black,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${education.strata}, ${education.jurusan}",
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${education.prodi}, ${education.tahunMasuk}-${education.tahunLulus}",
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.normal),
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
              ],
            ),
          );
        },
      );
    });
  }
}
