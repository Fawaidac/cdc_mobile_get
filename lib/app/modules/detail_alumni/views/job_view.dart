import 'package:cdc/app/modules/detail_alumni/controllers/job_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobView extends GetView<JobController> {
  final String idUser;

  JobView({required this.idUser, Key? key}) : super(key: key);

  @override
  final controller = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    controller.fetchData(idUser);

    return Obx(() {
      final jobs = controller.jobs;

      return ListView.builder(
        itemCount: jobs.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final data = jobs[index];
          return Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xff242760).withOpacity(0.03),
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
                        "${data.jabatan}",
                        style: AppFonts.poppins(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${data.perusahaan}, ${data.jenisPekerjaan}",
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
                        "${data.tahunMasuk} - ${data.tahunKeluar != null ? data.tahunKeluar! : 'Sekarang'}",
                        style: AppFonts.poppins(
                          fontSize: 12,
                          color: first,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Rp. ${data.gaji}",
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
