import 'package:cdc/app/modules/profile/controllers/job_user_controller.dart';
import 'package:cdc/app/modules/profile/views/edit_job_user_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_dialog.dart';

class JobUserView extends GetView<JobUserController> {
  JobUserView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(JobUserController());
  @override
  Widget build(BuildContext context) {
    controller.fetchAndAssignJob();

    return Obx(
      () => ListView.builder(
        itemCount: controller.jobList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final jobs = controller.jobList[index];
          return Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff242760).withOpacity(0.03)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${jobs.jabatan}",
                        style: AppFonts.poppins(
                            fontSize: 16,
                            color: black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${jobs.perusahaan}, ${jobs.jenisPekerjaan}",
                        style: AppFonts.poppins(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${jobs.tahunMasuk} - ${jobs.tahunKeluar != null ? jobs.tahunKeluar! : 'Sekarang'}",
                        style: AppFonts.poppins(
                            fontSize: 12,
                            color: first,
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "Rp. ${NumberFormat.decimalPattern('id').format(jobs.gaji)}",
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
                        Get.to(() => EditJobUserView(), arguments: jobs);
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
                            controller.handleDeleteJobs("${jobs.id}");
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
      ),
    );
  }
}
