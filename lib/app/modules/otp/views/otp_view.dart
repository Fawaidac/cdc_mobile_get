import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  OtpView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(OtpController());
  String code = "";
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
            Navigator.pop(context);
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "Verifikasi Otp",
              style: AppFonts.poppins(fontSize: 24, color: black),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
              child: Text(
                "Masukkan 6 digit kode yang dikirim di nomor +62 ${controller.phone} untuk verifikasi.",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                controller.otpCode.value = value;
              },
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 45),
              height: 48,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  controller.verifikasiOtp(code);
                },
                child: Text(
                  'Verifikasi',
                  style: AppFonts.poppins(fontSize: 14, color: white),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tidak menerima kode OTP ? ",
                  style: AppFonts.poppins(fontSize: 12, color: black),
                ),
                InkWell(
                  onTap: () {
                    if (controller.canResend.value) {
                      controller.sendOtpAgain();
                    }
                  },
                  child: Text(
                    "Kirim Ulang",
                    style: AppFonts.poppins(
                      fontSize: 12,
                      color: controller.canResend.value
                          ? primaryColor
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Obx(() {
              return Center(
                child: Text(
                  "Harap tunggu kode dalam 00:${controller.countdown.toString().padLeft(2, '0')}s",
                  style: AppFonts.poppins(
                      fontSize: 12,
                      color: controller.countdown > 0 ? grey : primaryColor),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
