import 'package:cdc/app/modules/quisioner/controllers/study_section_controller.dart';
import 'package:cdc/app/resource/custom_textfieldform.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';

class StudySectionView extends GetView<StudySectionController> {
  StudySectionView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(StudySectionController());
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
            "Kuisioner Studi Lanjut",
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
                  "Jawablah pertanyaan ini jika Anda melaksanakan STUDI LANJUT (dari D3 ke D4 / dari D4 ke S2)",
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
                            Text(
                              "Sumber biaya Studi Lanjut Anda?",
                              style: GoogleFonts.poppins(fontSize: 12),
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
                          value: controller.selectedBiaya,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedBiaya = newValue;
                          },
                          items: controller.biayaOptions.map((v) {
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
                    controller: controller.namaPerguruan,
                    isEnable: true,
                    label: "Nama Perguruan Tinggi Studi Lanjut",
                    keyboardType: TextInputType.text,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: CustomTextFieldForm(
                    controller: controller.namaProdi,
                    isEnable: true,
                    label: "Nama Program Studi Studi Lanjut",
                    keyboardType: TextInputType.text,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  width: MediaQuery.of(context).size.width,
                  color: white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Tanggal Masuk Awal Studi Lanjut Anda?",
                              style: GoogleFonts.poppins(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.selectDate(context);
                          },
                          child: Container(
                            height: 48,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1, color: black)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  controller.selectedDate.value == null
                                      ? "Tanggal Masuk"
                                      : DateFormat('dd MMMM yyyy').format(
                                          controller.selectedDate.value!),
                                  style: AppFonts.poppins(
                                      fontSize: 13, color: black),
                                )),
                                Icon(
                                  Icons.calendar_month_outlined,
                                  color: black,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
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
                                "Sebutkan sumberdana dalam pembiayaan kuliah? (bukan ketika Studi Lanjut)",
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
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              value: controller.selectedSumberdana.value,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: black,
                              ),
                              onChanged: (newValue) {
                                controller.selectedSumberdana.value = newValue!;
                              },
                              items: controller.sumberDanaOptions.map((v) {
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
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: 13, color: grey),
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
                          )),
                      Obx(() => Visibility(
                            visible: controller.selectedSumberdana.value ==
                                'Lainnya',
                            child: CustomTextFieldForm(
                                controller: controller.sumberDana,
                                isEnable: true,
                                label: "Sumber dana pembiayaan kuliah",
                                keyboardType: TextInputType.text,
                                inputFormatters: FilteringTextInputFormatter
                                    .singleLineFormatter),
                          )),
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
                                "Seberapa erat hubungan bidang studi dengan pekerjaan Anda?",
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
                          value: controller.selectedHubungan,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedHubungan = newValue;
                          },
                          items: controller.hubunganOptions.map((v) {
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
                          children: [
                            Expanded(
                              child: Text(
                                "Tingkat pendidikan apa yang paling tepat/sesuai untuk pekerjaan anda saat ini?",
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
                          value: controller.selectedTingkat,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedTingkat = newValue;
                          },
                          items: controller.tingkatOptions.map((v) {
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.handleQuisionerStudy();
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
