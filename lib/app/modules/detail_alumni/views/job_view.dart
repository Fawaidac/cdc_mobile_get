import 'package:cdc/app/modules/detail_alumni/controllers/job_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
                  "${data.perusahaan}",
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
                      "${data.jabatan}",
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: black,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${data.jenisPekerjaan}, ${data.tahunMasuk} - ${data.tahunKeluar != null ? data.tahunKeluar! : 'Sekarang'}",
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "Rp. ${NumberFormat.decimalPattern('id').format(data.gaji)}",
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
