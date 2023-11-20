import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class KartuAlumniView extends GetView {
  const KartuAlumniView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            'Kartu Alumni',
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: white,
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: white,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 1,
                        offset: Offset(0.1, 0.95))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "images/polije.png",
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "POLITEKNIK NEGERI JEMBER",
                                      style: AppFonts.montserrat(
                                          fontSize: 14,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Jl. Mastrip 164 Jember 68101",
                                      style: AppFonts.montserrat(
                                          fontSize: 12,
                                          color: black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "www.polije.ac.id",
                                      style: AppFonts.montserrat(
                                          fontSize: 12, color: black),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Image.asset(
                            "images/sip.png",
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      color: Colors.amber[700],
                      child: Center(
                        child: Text(
                          "KARTU ALUMNI",
                          style: AppFonts.montserrat(
                              fontSize: 14,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color(0xff0177ff),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Achmad Fawa'id",
                                style: AppFonts.montserrat(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "E41210280",
                                style: AppFonts.montserrat(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "D4-Teknik Informatika",
                                style: AppFonts.montserrat(
                                    fontSize: 14,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff0177ff),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1,
                          offset: Offset(0.1, 0.95))
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 0,
                          right: 0,
                          left: 0,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: Column(
                              children: [
                                Text(
                                  "Kartu Alumni Politeknik Negeri Jember",
                                  style: AppFonts.montserrat(
                                      fontSize: 14,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Smart Innovative Professional",
                                    style: GoogleFonts.tangerine(
                                        color: white, fontSize: 25)),
                                Divider(
                                  color: white,
                                ),
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          right: -50,
                          child: Transform(
                            transform: Matrix4.rotationZ(0.3),
                            child: Opacity(
                              opacity: 0.1,
                              child: ClipRRect(
                                child: Image.asset(
                                  "images/polije.png",
                                  height: 180,
                                ),
                              ),
                            ),
                          )),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  "images/logopuith.png",
                                  height: 30,
                                ),
                                Image.asset(
                                  "images/Untitled.png",
                                  height: 60,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ));
  }
}
