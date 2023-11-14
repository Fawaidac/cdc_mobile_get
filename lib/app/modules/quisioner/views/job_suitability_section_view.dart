import 'package:cdc/app/modules/quisioner/controllers/job_suitability_section_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resource/custom_textfieldform.dart';
import '../../../utils/app_fonts.dart';

class JobSuitabilitySectionView
    extends GetView<JobSuitabilitySectionController> {
  JobSuitabilitySectionView({Key? key}) : super(key: key);

  final controller = Get.put(JobSuitabilitySectionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: black,
            ),
          ),
          title: Text(
            "Kuisioner Kesesuaian Pekerjaan",
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  "Kesesuaian pekerjaan anda saat ini dengan pendidikan anda",
                  style: AppFonts.poppins(fontSize: 14, color: black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Apakah pekerjaan anda saat ini tidak sesuai dengan pendidikan anda ?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.notReleated,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.notReleated = newValue;
                          },
                          items: controller.chooseOptions.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Apakah pekerjaan anda saat ini tidak sesuai dengan pendidikan anda ?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: controller.checkboxValue1.value,
                              activeColor: primaryColor,
                              onChanged: (value) {
                                controller.checkboxValue1.value = value!;
                              },
                            ),
                            Expanded(
                                child: Text(
                              "Pekerjaan saya sudah sesuai",
                              style:
                                  AppFonts.poppins(fontSize: 12, color: black),
                            ))
                          ],
                        ),
                      ),
                      Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              activeColor: primaryColor,
                              value: controller.checkboxValue2.value,
                              onChanged: (value) {
                                controller.checkboxValue2.value = value!;
                              },
                            ),
                            Expanded(
                                child: Text(
                              "Saya belum mendapatkan pekerjaan yang lebih sesuai",
                              style:
                                  AppFonts.poppins(fontSize: 12, color: black),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.notReason,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.notReason = newValue;
                          },
                          items: controller.chooseOptions1.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.notReason2,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.notReason2 = newValue;
                          },
                          items: controller.chooseOptions2.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya? ",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason = newValue;
                          },
                          items: controller.chooseOptions3.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason2,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason2 = newValue;
                          },
                          items: controller.chooseOptions4.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason3,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason3 = newValue;
                          },
                          items: controller.chooseOptions5.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason4,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason4 = newValue;
                          },
                          items: controller.chooseOptions6.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason5,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason5 = newValue;
                          },
                          items: controller.chooseOptions7.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason6,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason6 = newValue;
                          },
                          items: controller.chooseOptions8.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason7,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason7 = newValue;
                          },
                          items: controller.chooseOptions9.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya?",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason8,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason8 = newValue;
                          },
                          items: controller.chooseOptions10.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Jika pekerjaan anda saat ini tidak sesuai dengan pendidikan anda, mengapa anda mengambilnya? Selain pilihan dijawaban soal diatas",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                            ),
                            Text(
                              "*",
                              style: AppFonts.poppins(fontSize: 12, color: red),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        child: DropdownButtonFormField<String>(
                          isExpanded: true,
                          value: controller.otherReason9,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.otherReason9 = newValue;
                          },
                          items: controller.chooseOptions11.map((v) {
                            return DropdownMenuItem<String>(
                              value: v,
                              child: Text(
                                v,
                                style: AppFonts.poppins(
                                    fontSize: 12, color: black),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "Pilih",
                            isDense: true,
                            hintStyle:
                                GoogleFonts.poppins(fontSize: 13, color: grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFCFDFE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: CustomTextFieldForm(
                    controller: controller.otherReason10,
                    isRequired: true,
                    isRequiredExp: true,
                    label:
                        "Apakah anda aktif mencari pekerjaan dalam 4 minggu terakhir (Selain jawaban diatas), Tuliskan",
                    keyboardType: TextInputType.text,
                    isEnable: true,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.check();
                        },
                        child: Text(
                          "Selanjutnya",
                          style: AppFonts.poppins(
                              fontSize: 12,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
