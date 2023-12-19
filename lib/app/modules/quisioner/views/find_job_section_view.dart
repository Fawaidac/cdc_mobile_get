import 'package:cdc/app/modules/quisioner/controllers/find_job_section_controller.dart';
import 'package:cdc/app/modules/quisioner/views/company_apply_section_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resource/custom_textfieldform.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';

class FindJobSectionView extends GetView<FindJobSectionController> {
  FindJobSectionView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(FindJobSectionController());
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
            "Kuisioner Mencari Pekerjaan",
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Text(
                  "Bagaimana anda mencari pekerjaan tersebut? Jawaban bisa lebih dari satu Section",
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
                                "Melalui iklan di koran/majalah, brosur ? ",
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
                          value: controller.selectedPlatform,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedPlatform = newValue;
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
                                "Melamar ke perusahaan tanpa mengetahui lowongan yang ada",
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
                          value: controller.selectedVacancies,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedVacancies = newValue;
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
                                "Pergi ke bursa/pameran kerja",
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
                          value: controller.selectedExcanges,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedExcanges = newValue;
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
                                "Mencari lewat internet/iklan online/milis ",
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
                          value: controller.selectedInternet,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedInternet = newValue;
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
                                "Dihubungi oleh perusahaan",
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
                          value: controller.selectedCompany,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedCompany = newValue;
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
                                "Menghubungi Kemenakertrans",
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
                          value: controller.selectedKemenakertrans,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedKemenakertrans = newValue;
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
                                "Menghubungi agen tenaga kerja komersial/swasta",
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
                          value: controller.selectedAgen,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedAgen = newValue;
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
                                "Memperoleh informasi dari pusat/kantor pengembangan karir fakultas/universitas",
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
                          value: controller.selectedInformasi,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedInformasi = newValue;
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
                                "Menghubungi kantor kemahasiswaan/hubungan alumni ",
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
                          value: controller.selectedKantor,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedKantor = newValue;
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
                                "Membangun jejaring (network) sejak masih kuliah",
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
                          value: controller.selectedNetwork,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedNetwork = newValue;
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
                                "Melalui relasi (misalnya dosen, orang tua, saudara, teman, Ikatan Alumni dll.)",
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
                          value: controller.selectedRelasi,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedRelasi = newValue;
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
                                "Membangun bisnis sendiri",
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
                          value: controller.selectedBisnis,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedBisnis = newValue;
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
                                "Melalui penempatan kerja atau magang",
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
                          value: controller.selectedPenempatan,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedPenempatan = newValue;
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
                                "Bekerja di tempat yang sama dengan tempat kerja semasa kuliah",
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
                          value: controller.selectedCollage,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedCollage = newValue;
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
                                "Mencari lewat internet/iklan online/milis ",
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
                          value: controller.selectedInternet,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedInternet = newValue;
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
                                "Lainnya",
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
                          value: controller.selectedLainnya,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: black,
                          ),
                          onChanged: (newValue) {
                            controller.selectedLainnya = newValue;
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
                child: CustomTextFieldForm(
                    hint: "",
                    controller: controller.lainnya,
                    label:
                        "Mendapatkan pekerjaan selain yang sudah ditanyakan (diatas), Tuliskan",
                    keyboardType: TextInputType.text,
                    isEnable: true,
                    inputFormatters:
                        FilteringTextInputFormatter.singleLineFormatter),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Sebelumnya",
                          style: AppFonts.poppins(
                              fontSize: 12,
                              color: black,
                              fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          if (controller.isUpdate.value == true) {
                            controller.handleQuisionerFindJobsUpdate();
                          } else {
                            controller.handleQuisionerFindJobs();
                          }
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
