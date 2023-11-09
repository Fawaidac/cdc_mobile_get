import 'package:cdc/app/modules/setting/controllers/add_education_user_controller.dart';
import 'package:cdc/app/resource/custom_textfieldform.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEducationUserView extends GetView<AddEducationUserController> {
  AddEducationUserView({Key? key}) : super(key: key);

  final controller = Get.put(AddEducationUserController());
  @override
  Widget build(BuildContext context) {
    controller.fetchData();
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
              color: primaryColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Tambah Pendidikan",
            style: AppFonts.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
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
                            "Pilih Perguruan Tinggi",
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
                        child: Obx(
                          () => DropdownButtonFormField<String>(
                            value: controller.selectedPerguruan.value,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: black,
                            ),
                            onChanged: (newValue) {
                              controller.selectedPerguruan.value = newValue!;
                              controller.update();
                            },
                            items: controller.perguruanOptions.map((perguruan) {
                              return DropdownMenuItem<String>(
                                value: perguruan,
                                child: Text(
                                  perguruan,
                                  style: AppFonts.poppins(
                                      fontSize: 12, color: black),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: "Pilih Perguruan Tinggi",
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
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.selectedPerguruan.value == 'Lainnya',
                  child: CustomTextFieldForm(
                    controller: controller.perguruantinggi,
                    label: "Perguruan Tinggi",
                    isEnable: true,
                    keyboardType: TextInputType.text,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter,
                  ),
                ),
              ),
              Padding(
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
                            "Strata",
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
                        value: controller.selectedStrata,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedStrata = newValue;
                        },
                        items: controller.strataOptions.map((strata) {
                          return DropdownMenuItem<String>(
                            value: strata,
                            child: Text(
                              strata,
                              style:
                                  AppFonts.poppins(fontSize: 12, color: black),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: "Pilih Strata",
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
              CustomTextFieldForm(
                  isEnable: true,
                  controller: controller.jurusan,
                  label: "Jurusan / Fakultas",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              Obx(() => Visibility(
                    visible: controller.selectedPerguruan.value == 'Lainnya',
                    child: CustomTextFieldForm(
                        isEnable: true,
                        controller: controller.prodi,
                        label: "Program Studi",
                        keyboardType: TextInputType.text,
                        inputFormatters:
                            FilteringTextInputFormatter.singleLineFormatter),
                  )),
              if (controller.selectedPerguruan.value ==
                  'Politeknik Negeri Jember')
                Obx(() => Visibility(
                    visible: controller.selectedPerguruan.value ==
                        'Politeknik Negeri Jember',
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "Program Studi",
                                  style: GoogleFonts.poppins(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 50,
                            child: Obx(
                              () => DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: controller.selectedProdi.value.isEmpty
                                    ? null
                                    : controller.selectedProdi.value,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.black,
                                ),
                                onChanged: (newValue) {
                                  controller.selectedProdi.value = newValue!;
                                },
                                items: controller.prodiList.map((prodi) {
                                  return DropdownMenuItem<String>(
                                    value: prodi['nama_prodi'],
                                    child: Text(
                                      prodi['nama_prodi'],
                                      style: AppFonts.poppins(
                                          fontSize: 12, color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  hintText: "Pilih Program Studi",
                                  isDense: true,
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 13, color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFFCFDFE),
                                ),
                              ),
                            )),
                      ],
                    ))),
              CustomTextFieldForm(
                  isEnable: true,
                  controller: controller.tahunMasuk,
                  label: "Tahun Masuk",
                  isLength: 4,
                  keyboardType: TextInputType.number,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
              CustomTextFieldForm(
                  isEnable: true,
                  controller: controller.tahunLulus,
                  label: "Tahun Lulus",
                  keyboardType: TextInputType.number,
                  isLength: 4,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
              CustomTextFieldForm(
                  isEnable: true,
                  controller: controller.noIjazah,
                  label: "No. Ijazah",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () {
                      // handleAddEducation();
                      controller.addEducation();
                    },
                    child: Text('Simpan',
                        style: AppFonts.poppins(
                          fontSize: 14,
                          color: white,
                        )),
                  )),
            ],
          ),
        ));
  }
}
