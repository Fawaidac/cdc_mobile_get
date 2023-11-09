import 'package:cdc/app/modules/setting/views/add_education_user_view.dart';
import 'package:cdc/app/modules/setting/views/add_job_user_view.dart';
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
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
            size: 30,
          ),
        ),
        title: Text(
          "Pengaturan",
          style: AppFonts.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Akun",
              style: AppFonts.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            get(context, "Kartu Alumni", Icons.badge_outlined),
            GestureDetector(
                onTap: () {
                  Get.to(() => AddEducationUserView());
                },
                child: get(context, "Pendidikan", Icons.school_outlined)),
            GestureDetector(
                onTap: () {
                  Get.to(() => AddJobUserView());
                },
                child: get(context, "Pekerjaan", Icons.work_outline)),
            GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.RECOVERY_PASSWORD);
                },
                child: get(context, "Ubah Sandi", Icons.lock_outline)),
            Text(
              "Aksi",
              style: AppFonts.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            get(context, "Notifikasi", Icons.notifications_outlined,
                show: true),
            GestureDetector(
                onTap: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove('token');
                  preferences.remove('tokenExpirationTime');

                  Get.offAllNamed(Routes.LOGIN);
                },
                child: get(context, "Keluar", Icons.logout)),
            Text(
              "Info",
              style: AppFonts.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => const TentangView());
                },
                child: get(context, "Tentang", Icons.help_outline))
          ],
        ),
      ),
    );
  }

  Padding get(BuildContext context, String name, IconData iconData,
      {bool show = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        color: white,
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Icon(
              iconData,
              color: primaryColor,
              size: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: AppFonts.poppins(fontSize: 14, color: black),
            ),
            const Spacer(),
            show
                ? Transform.scale(
                    scale: 0.6,
                    child: Switch(
                      value: true,
                      onChanged: (bool value1) {},
                      activeColor: primaryColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
