import 'package:cdc/app/modules/fasilitas/views/whatsapp_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/fasilitas_controller.dart';

class FasilitasView extends GetView<FasilitasController> {
  FasilitasView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(FasilitasController());

  Future<void> _refreshData() async {
    await controller.fetchQuisionerCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: white,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: primaryColor,
          ),
        ),
        title: Text(
          "Fasilitas",
          style: AppFonts.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Column(
          children: [
            Obx(() {
              int completedSection = controller.calculateCompletedSections();
              int totalSection = 9;
              return Column(
                children: [
                  if (completedSection != totalSection)
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 175,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [primaryColor, first],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ayo Isi Kuisioner !",
                                    style: AppFonts.poppins(
                                        fontSize: 18,
                                        color: white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Verifikasi akun anda dan bantu rekan alumni untuk mengetahui track record anda",
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: white),
                                  ),
                                  Image.asset(
                                    "images/logowhite.png",
                                    height: 40,
                                  ),
                                ],
                              ),
                            )),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SizedBox(
                                height: 120,
                                child: Image.asset(
                                  "images/quis.png",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 25),
                    child: LinearProgressIndicator(
                      value: totalSection == 0
                          ? 0.0
                          : completedSection / totalSection,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lengkapi kuisioner anda agar akun anda terverifikasi",
                          style:
                              AppFonts.poppins(fontSize: 12, color: softgrey),
                        ),
                        Text(
                          '$completedSection/$totalSection',
                          textAlign: TextAlign.end,
                          style:
                              AppFonts.poppins(fontSize: 12, color: softgrey),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            InkWell(
              onTap: () {
                Get.to(() => WhatsappView());
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                height: 175,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                      colors: [Color(0xff17b9a4), Color(0xff8bebd7)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Row(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        height: 120,
                        child: Image.asset(
                          "images/face.png",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Grup WhatsAppFonts",
                            style: AppFonts.poppins(
                                fontSize: 20,
                                color: white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Cari relasi anda berdasarkan\nkota tempat kelahiran anda",
                            style: AppFonts.poppins(
                                fontSize: 12,
                                color: white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
