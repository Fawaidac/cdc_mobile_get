import 'package:cdc/app/modules/quisioner/controllers/kompetensi_section_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/app_fonts.dart';

class KompetensiSectionView extends GetView<KompetensiSectionController> {
  KompetensiSectionView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(KompetensiSectionController());
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
          "Kuisioner Tingkat Kompetensi",
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
                "Tingkat KOMPETENSI anda pada SAAT LULUS dan Tingkat KOMPETENSI anda pada SAAT INI",
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
                              "Pada tingkat mana kompetensi ETIKA anda kuasai pada SAAT LULUS?",
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
                        value: controller.selectedEtikaLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedEtikaLulus = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi ETIKA anda kuasai pada SAAT INI?",
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
                        value: controller.selectedEtikaNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedEtikaNow = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KEAHLIAN BERDASARKAN BIDANG ILMU anda kuasai pada SAAT LULUS?",
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
                        value: controller.selectedKeahlianLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedKeahlianLulus = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KEAHLIAN BERDASARKAN BIDANG ILMU anda kuasai pada SAAT INI?",
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
                        value: controller.selectedKeahlianNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedKeahlianNow = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi BAHASA INGGRIS anda kuasai pada SAAT LULUS?",
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
                        value: controller.selectedEnglishLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedEnglishLulus = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi BAHASA INGGRIS anda kuasai pada SAAT INI?",
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
                        value: controller.selectedEnglishNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedEnglishNow = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi TEKNOLOGI INFORMASI anda kuasai pada SAAT LULUS?",
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
                        value: controller.selectedItLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedItLulus = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi TEKNOLOGI INFORMASI anda kuasai pada SAAT INI?",
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
                        value: controller.selectedItNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedItNow = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KOMUNIKASI anda kuasai pada SAAT LULUS?",
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
                        value: controller.selectedKomunikasiLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedKomunikasiLulus = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KOMUNIKASI anda kuasai pada SAAT INI?",
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
                        value: controller.selectedKomunikasiNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedKomunikasiNow = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KERJA SAMA TIM anda kuasai pada SAAT LULUS?",
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
                        value: controller.selectedTeamWorkLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedTeamWorkLulus = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi KERJA SAMA TIM anda kuasai pada SAAT INI?",
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
                        value: controller.selectedTeamWorkNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedTeamWorkNow = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi PENGEMBANGAN DIRI anda kuasai pada SAAT LULUS?",
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
                        value: controller.selectedSelfDevLulus,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedSelfDevLulus = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                              "Pada tingkat mana kompetensi PENGEMBANGAN DIRI anda kuasai pada SAAT INI?",
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
                        value: controller.selectedSelfDevNow,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: black,
                        ),
                        onChanged: (newValue) {
                          controller.selectedSelfDevNow = newValue;
                        },
                        items: controller.tingkatOptions.map((v) {
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
                        controller.handleQuisionerKompetensi();
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
      ),
    );
  }
}
