import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  static String verify = "";

  RegisterView(
      {String? nama,
      String? email,
      String? nim,
      String? alamat,
      String? prodi,
      Key? key})
      : super(key: key) {
    controller.initializeValues(
        nama: nama!, email: email!, nim: nim!, alamat: alamat!, prodi: prodi!);
  }
  bool showpass = true;
  bool connpass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Daftar Akun",
                style: AppFonts.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Buat akun anda",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextField(
                  controller: controller.fullname,
                  label: "Nama Lengkap",
                  keyboardType: TextInputType.name,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.person_rounded),
              CustomTextField(
                  controller: controller.nik,
                  label: "Nomer Induk Kependudukan",
                  keyboardType: TextInputType.name,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.badge),
              CustomTextField(
                  controller: controller.email,
                  label: "Email",
                  keyboardType: TextInputType.emailAddress,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.mail),
              CustomTextField(
                  controller: controller.nim,
                  label: "NIM",
                  keyboardType: TextInputType.name,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.mail),
              CustomTextField(
                  controller: controller.prodi,
                  label: "Program Studi",
                  keyboardType: TextInputType.text,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.school),
              CustomTextField(
                  controller: controller.alamat,
                  label: "Alamat",
                  keyboardType: TextInputType.emailAddress,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.location_city),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffC4C4C4).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 30,
                      child: TextField(
                        controller: controller.countryCode,
                        style: AppFonts.poppins(fontSize: 12, color: black),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: AppFonts.poppins(fontSize: 20, color: black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      style: AppFonts.poppins(fontSize: 13, color: black),
                      onChanged: (value) {
                        controller.phone = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                          suffixIcon: Icon(
                            Icons.phone_android_rounded,
                            size: 20,
                            color: grey,
                          ),
                          isDense: false,
                          hintStyle:
                              AppFonts.poppins(fontSize: 13, color: grey)),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: controller.password,
                      obscureText: showpass,
                      style: AppFonts.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.text,
                      onSaved: (val) =>
                          controller.password = val as TextEditingController,
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
                                    color: first,
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
                        fillColor: const Color(0xffC4C4C4).withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: controller.confirmPassword,
                      obscureText: connpass,
                      style: AppFonts.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.text,
                      onSaved: (val) => controller.confirmPassword =
                          val as TextEditingController,
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
                        hintText: "Konfirmasi Kata Sandi",
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.toggleShowConfirmPassword();
                            },
                            icon: connpass
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                    color: grey,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: first,
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
                        fillColor: const Color(0xffC4C4C4).withOpacity(0.2),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 15),
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
                          borderRadius: BorderRadius.circular(15),
                        )),
                    onPressed: () {
                      controller.checkRegister();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Lanjut',
                            style: AppFonts.poppins(
                              fontSize: 14,
                              color: white,
                            )),
                        Icon(
                          Icons.keyboard_arrow_right,
                          color: white,
                        )
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah memiliki akun ? ",
                    style: AppFonts.poppins(fontSize: 12, color: black),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      "Masuk ",
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
