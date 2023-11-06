

import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/aktifasi_controller.dart';

class AktifasiView extends GetView<AktifasiController> {
  AktifasiView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(AktifasiController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Pengajuan Aktifasi",
                style: AppFonts.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Masukan data diri anda dengan benar",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  controller: controller.nama,
                  label: "Nama Lengkap",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.person),
              CustomTextField(
                  controller: controller.email,
                  label: "Email",
                  isEnable: true,
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.mail),
              CustomTextField(
                  controller: controller.telp,
                  label: "No.Telepon",
                  isEnable: true,
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 13,
                  icon: Icons.phone),
              CustomTextField(
                  controller: controller.nim,
                  label: "NIM (Nomor Induk Mahasiswa)",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 10,
                  icon: Icons.badge),
              CustomTextField(
                  controller: controller.tempatLahir,
                  label: "Tempat Lahir",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.location_city),
              Obx(() => GestureDetector(
                    onTap: () {
                      controller.selectDate(context);
                    },
                    child: Container(
                      height: 48,
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffC4C4C4).withOpacity(0.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              DateFormat('dd MMMM yyyy')
                                  .format(controller.selectedDate.value),
                              style:
                                  AppFonts.poppins(fontSize: 13, color: black),
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
                            color: grey,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  )),
              CustomTextField(
                  controller: controller.alamat,
                  label: "Alamat Domisili",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.location_city),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                      child: DropdownButtonFormField<String>(
                        value: controller.selectedJenisKelamin,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: grey,
                        ),
                        onChanged: (newValue) {
                          controller.toggleChangeType(newValue!);
                        },
                        items: controller.chooseOptions.map((v) {
                          return DropdownMenuItem<String>(
                            value: v,
                            child: Text(
                              v,
                              style:
                                  AppFonts.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih Jenis Kelamin",
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
                      ),
                    ),
                  ],
                ),
              ),
              CustomTextField(
                  controller: controller.jurusan,
                  label: "Jurusan",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.school),
              CustomTextField(
                  controller: controller.prodi,
                  label: "Program Studi",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  icon: Icons.school),
              CustomTextField(
                  controller: controller.angkatan,
                  label: "Tahun Masuk",
                  isEnable: true,
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 4,
                  icon: Icons.calendar_month),
              CustomTextField(
                  controller: controller.tahunLulus,
                  label: "Tahun Lulus",
                  isEnable: true,
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  isLength: 4,
                  icon: Icons.calendar_month),
              GestureDetector(
                onTap: () {
                  controller.pickAndUploadFile();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [8, 4],
                    strokeCap: StrokeCap.round,
                    color: black,
                    child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Obx(
                          () => controller.pdf.value == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/file.png",
                                      height: 40,
                                      color: black,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Upload Ijazah (PDF)",
                                      style: AppFonts.poppins(
                                          fontSize: 12, color: softgrey),
                                    )
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/pdf.png",
                                      height: 40,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      controller.pdf.value!.path
                                          .split('/')
                                          .last,
                                      style: AppFonts.poppins(
                                          fontSize: 12, color: softgrey),
                                    )
                                  ],
                                ),
                        )),
                  ),
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
                      controller.sendAktifasiAkun();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Ajukan',
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
            ],
          ),
        ),
      ),
    );
  }
}
