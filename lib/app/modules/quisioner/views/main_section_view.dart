import 'package:cdc/app/modules/quisioner/controllers/main_section_controller.dart';
import 'package:cdc/app/resource/custom_textfieldform.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSectionView extends GetView<MainSectionController> {
  MainSectionView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(MainSectionController());
  @override
  Widget build(BuildContext context) {
    controller.loadProvinsiData();
    controller.loadRegencyData();
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
            "Kuisioner Utama",
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
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
                              "Jelaskan status anda saat ini?",
                              style: GoogleFonts.poppins(fontSize: 12),
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
                          value: controller.selectedStatus,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedStatus = newValue;
                          },
                          items: controller.statusOptions.map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(
                                status,
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
                                "Apakah anda telah mendapat pekerjaan <= 6 bulan / termasuk bekerja sebelum lulus",
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
                          value: controller.selectedJobs,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedJobs = newValue;
                          },
                          items: controller.jobsOptions.map((jobs) {
                            return DropdownMenuItem<String>(
                              value: jobs,
                              child: Text(
                                jobs,
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
                            Column(
                              children: [
                                Text(
                                  "Berapa bulan anda mendapatkan pekerjaan SEBELUM LULUS",
                                  style: GoogleFonts.poppins(fontSize: 12),
                                ),
                              ],
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
                          value: controller.selectedMonth,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedMonth = newValue;
                          },
                          items: controller.monthOptions.map((month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
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
                    controller: controller.pendapatan,
                    isEnable: true,
                    isRequired: true,
                    isLength: 11,
                    label: "Rata-rata pendapatan perbulan",
                    keyboardType: TextInputType.number,
                    inputFormatters: FilteringTextInputFormatter.digitsOnly),
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
                              "Berapa bulan anda mendapatkan pekerjaan SETELAH LULUS",
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
                          isExpanded: true,
                          value: controller.selectedAfter,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedAfter = newValue;
                          },
                          items: controller.afterOptions.map((month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
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
                                "Dimana lokasi provinsi tempat anda bekerja?",
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
                              value: controller.selectedProvinsi.value,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: black,
                              ),
                              onChanged: (String? val) {
                                controller.selectedProvinsi.value = val!;
                              },
                              items: controller.provinsiList
                                  .map((String provinsi) {
                                return DropdownMenuItem<String>(
                                  value: provinsi,
                                  child: Text(
                                    provinsi,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Dimana lokasi kabupaten/kota tempat anda bekerja?",
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
                              value: controller.selectedRegency.value,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: black,
                              ),
                              onChanged: (String? val) {
                                controller.selectedRegency.value = val!;
                              },
                              items:
                                  controller.regencyList.map((String regency) {
                                return DropdownMenuItem<String>(
                                  value: regency,
                                  child: Text(
                                    regency,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Apa jenis perusahaan/instansi/institusi tempat anda bekerja sekarang?",
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
                          value: controller.selectedJenisInstansi,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedJenisInstansi = newValue;
                          },
                          items: controller.jenisInstansiOptions.map((jenis) {
                            return DropdownMenuItem<String>(
                              value: jenis,
                              child: Text(
                                jenis,
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
                      if (controller.selectedJenisInstansi == 'Lainnya')
                        CustomTextFieldForm(
                            controller: controller.jenis,
                            label: "Jenis Instansi",
                            keyboardType: TextInputType.text,
                            isEnable: true,
                            inputFormatters: FilteringTextInputFormatter
                                .singleLineFormatter),
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
                    controller: controller.namaPerusahaan,
                    isEnable: true,
                    isRequired: true,
                    label: "Nama perusahaan/kantor",
                    keyboardType: TextInputType.text,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Bila Anda berwiraswasta, apa posisi/jabatan Anda saat ini ?",
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
                          value: controller.selectedJabatan,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedJabatan = newValue;
                          },
                          items: controller.jabatanOptions.map((jabatan) {
                            return DropdownMenuItem<String>(
                              value: jabatan,
                              child: Text(
                                jabatan,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Apa tingkatan tempat kerja Anda?",
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
                          isExpanded: true,
                          value: controller.selectedTingkatan,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedTingkatan = newValue;
                          },
                          items: controller.tingkatanOptions.map((tingkatan) {
                            return DropdownMenuItem<String>(
                              value: tingkatan,
                              child: Text(
                                tingkatan,
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
                          controller.handleQuisionerMain();
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
