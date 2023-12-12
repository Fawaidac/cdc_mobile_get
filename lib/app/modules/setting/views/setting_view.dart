import 'package:cdc/app/modules/setting/controllers/kartu_alumni_controller.dart';
import 'package:cdc/app/modules/setting/views/add_education_user_view.dart';
import 'package:cdc/app/modules/setting/views/add_job_user_view.dart';
import 'package:cdc/app/modules/setting/views/kartu_alumni_view.dart';
import 'package:cdc/app/modules/setting/views/tentang_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.find<KartuAlumniController>().getDataAlumni();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: black,
            ),
          ),
        ),
        title: Text(
          "Pengaturan",
          style: AppFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Akun",
                    style: AppFonts.poppins(fontSize: 12, color: black),
                  ),
                  getWidgetSetting(
                      0, context, "Kartu Alumni", Icons.badge_outlined),
                  getWidgetSetting(
                      1, context, "Tambah Pendidikan", Icons.school_outlined),
                  getWidgetSetting(2, context, "Tambah Pekerjaan",
                      Icons.work_outline_rounded),
                  getWidgetSetting(
                      3, context, "Ubah Kata Sandi", Icons.key_outlined),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 10),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aksi",
                    style: AppFonts.poppins(fontSize: 12, color: black),
                  ),
                  getWidgetSetting(5, context, "Keluar", Icons.logout),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 10),
              color: white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Info",
                    style: AppFonts.poppins(fontSize: 12, color: black),
                  ),
                  getWidgetSetting(6, context, "Tentang", Icons.help_outline),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 70),
              child: Center(
                child: Text(
                  "CDC Versi 1.0.0",
                  style: AppFonts.poppins(fontSize: 12, color: softgrey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getWidgetSetting(
      int i, BuildContext context, String name, IconData iconData,
      {bool show = false}) {
    return GestureDetector(
      onTap: () async {
        if (i == 0) {
          Get.to(() => KartuAlumniView());
        } else if (i == 1) {
          Get.to(() => AddEducationUserView());
        } else if (i == 2) {
          Get.to(() => AddJobUserView());
        } else if (i == 3) {
          Get.toNamed(Routes.RECOVERY_PASSWORD);
        } else if (i == 4) {
        } else if (i == 5) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.remove('token');
          preferences.remove('tokenExpirationTime');

          Get.offAllNamed(Routes.LOGIN);
          Get.snackbar("Success", "Berhasil keluar dari aplikasi",
              margin: const EdgeInsets.all(10));
        } else {
          Get.to(() => const TentangView());
        }
      },
      child: Container(
        color: white,
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(
              iconData,
              color: black,
              size: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: AppFonts.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            show
                ? Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: true,
                      onChanged: (bool value1) {},
                      activeColor: black,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                : Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: black,
                  )
          ],
        ),
      ),
    );
  }
}
