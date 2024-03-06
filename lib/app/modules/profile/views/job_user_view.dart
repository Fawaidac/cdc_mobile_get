import 'package:cdc/app/modules/profile/controllers/job_user_controller.dart';
import 'package:cdc/app/modules/profile/views/edit_job_user_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_dialog.dart';

class JobUserView extends StatefulWidget {
  const JobUserView({Key? key}) : super(key: key);

  @override
  _JobUserViewState createState() => _JobUserViewState();
}

class _JobUserViewState extends State<JobUserView> {
  final JobUserController controller = Get.put(JobUserController());
  final RxList<bool> isVisible = <bool>[].obs;

  @override
  void initState() {
    super.initState();
    controller.fetchAndAssignJob();
  }

  @override
  Widget build(BuildContext context) {
    controller.update();
    return Obx(
      () => controller.jobList.isEmpty
          ? const Center(
              child: Text("Pekerjaan masih kosong!."),
            )
          : ListView.builder(
              itemCount: controller.jobList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final jobs = controller.jobList[index];
                if (isVisible.isEmpty) {
                  for (int i = 0; i < controller.jobList.length; i++) {
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
                        borderRadius: BorderRadius.circular(5), color: white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${jobs.perusahaan}",
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
                                  "${jobs.jabatan}",
                                  style: AppFonts.poppins(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${jobs.jenisPekerjaan}, ${jobs.tahunMasuk} - ${jobs.tahunKeluar != null ? jobs.tahunKeluar! : 'Sekarang'}",
                                  style: AppFonts.poppins(
                                      fontSize: 12,
                                      color: primaryColor,
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
                                      Get.to(() => EditJobUserView(),
                                          arguments: jobs);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shadowColor: Colors.transparent,
                                      primary: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      textStyle: AppFonts.poppins(
                                          fontSize: 12,
                                          color: white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(color: white),
                                    ),
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
                                          controller
                                              .handleDeleteJobs("${jobs.id}");
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      textStyle: AppFonts.poppins(
                                          fontSize: 12,
                                          color: white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    child: Text(
                                      "Hapus",
                                      style: TextStyle(color: white),
                                    ),
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
