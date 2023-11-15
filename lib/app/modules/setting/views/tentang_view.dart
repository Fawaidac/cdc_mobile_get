import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TentangView extends GetView {
  const TentangView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: black,
          ),
        ),
        title: Text(
          "Tentang Aplikasi",
          style: AppFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Aplikasi CDC Career Development Center adalah solusi yang dirancang oleh Teaching Factory Jurusan Teknologi Informasi Politeknik Negeri Jember untuk membantu mahasiswa dan alumni kami dalam menjalani perjalanan karir mereka. Aplikasi ini menyediakan akses ke berbagai informasi dan layanan yang diperlukan untuk mencapai kesuksesan dalam dunia kerja.",
                  style: AppFonts.poppins(fontSize: 12, color: white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "CDC Versi 1.0.0",
            style: AppFonts.poppins(fontSize: 12, color: black),
          ),
          Image.asset(
            "images/cdcasset/primaryblack.png",
            height: 125,
          ),
          const Spacer(),
          Image.asset(
            "images/about.png",
            height: 390,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
    );
  }
}
