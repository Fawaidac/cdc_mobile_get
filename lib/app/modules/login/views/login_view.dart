import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  TextEditingController nik = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showpass = true;
  @override
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selamat Datang",
                style: AppFonts.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Masuk ke akun anda",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                  controller: nik,
                  label: "Masukan Email / NIK",
                  keyboardType: TextInputType.text,
                  isEnable: true,
                  icon: Icons.mail,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: password,
                      obscureText: showpass,
                      style: AppFonts.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.text,
                      onSaved: (val) => password = val as TextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter
                      ],
                      decoration: InputDecoration(
                        hintText: "Kata Sandi",
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.toggleShowPassword();
                            },
                            icon: showpass
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                    color: grey,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: primaryColor,
                                    size: 20,
                                  )),
                        isDense: true,
                        hintStyle:
                            GoogleFonts.poppins(fontSize: 13, color: grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Color(0xffC4C4C4).withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.RECOVERY_PASSWORD);
                        },
                        child: Text(
                          "Lupa Sandi ?",
                          style: AppFonts.poppins(
                              fontSize: 12, color: primaryColor),
                        ))
                  ],
                ),
              ),
              Obx(
                () => Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 15),
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
                        controller.checkLogin(nik.text, password.text);
                      },
                      child: controller.loading.value == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: white,
                              ),
                            )
                          : Text('Masuk',
                              style: AppFonts.poppins(
                                fontSize: 14,
                                color: white,
                              )),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum memiliki akun ? ",
                    style: AppFonts.poppins(fontSize: 12, color: black),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.VERIFIKASI);
                    },
                    child: Text(
                      "Daftar Sekarang ",
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: first,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
