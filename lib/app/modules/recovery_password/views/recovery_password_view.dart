import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/recovery_password_controller.dart';

class RecoveryPasswordView extends GetView<RecoveryPasswordController> {
  RecoveryPasswordView({Key? key}) : super(key: key);

  var email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: black,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Atur Ulang Sandi",
              style: AppFonts.poppins(fontSize: 24, color: black),
            ),
            Text(
              "Masukan email yang ditautkan di email anda",
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
                controller: email,
                label: "Email",
                isEnable: true,
                keyboardType: TextInputType.emailAddress,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                icon: Icons.mail_rounded),
            Obx(
              () => Container(
                  margin: const EdgeInsets.fromLTRB(0, 50, 0, 45),
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [second, first]),
                      borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      controller.checkRecovery(email.text);
                    },
                    child: controller.loading.value == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: white,
                            ),
                          )
                        : Text('Verifikasi',
                            style: AppFonts.poppins(
                              fontSize: 14,
                              color: white,
                            )),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
