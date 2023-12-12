import 'package:cdc/app/modules/setting/controllers/kartu_alumni_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class KartuAlumniView extends GetView<KartuAlumniController> {
  KartuAlumniView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(KartuAlumniController());

  @override
  Widget build(BuildContext context) {
    controller.getDataAlumni();
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
          child: Obx(() {
            final data = controller.alumniData;
            final educations = data['educations'];
            final fullname = data['fullname'] ?? 'No Name';
            final nim = (data['nim'] ?? 'No Nim').toUpperCase();
            final jurusan = educations['jurusan'] ?? 'No Jurusan';
            final prodi = educations['prodi'] ?? 'No Prodi';
            final angkatan = educations['tahun_masuk'] ?? 'No Angkatan';
            final strata = educations['strata'] ?? 'No Strata';
            return Column(
              children: [
                Container(
                  height: 210,
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff262626),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "images/ikapj.png",
                                      height: 50,
                                    ),
                                    Text(
                                      "IKAPJ",
                                      style: AppFonts.montserrat(
                                          fontSize: 14,
                                          color: Color(0xfff8b430)),
                                    )
                                  ],
                                ),
                                Image.asset(
                                  "images/bjapn.png",
                                  height: 80,
                                )
                              ],
                            ),
                          )),
                      Positioned(
                          bottom: -20,
                          top: 60,
                          left: -50,
                          child: Opacity(
                            opacity: 0.5,
                            child: ClipRRect(
                              child: Image.asset(
                                "images/ikapj.png",
                                height: 170,
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "NAMA MU",
                                      style: AppFonts.montserrat(
                                          fontSize: 20,
                                          color: white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "2015-0000-0003",
                                      style: AppFonts.montserrat(
                                          fontSize: 18, color: white),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.language_outlined,
                                          size: 15,
                                          color: white,
                                        ),
                                        Text(
                                          "alumni.polije.ac.id",
                                          style: AppFonts.montserrat(
                                              fontSize: 12, color: white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "images/qrcode.jpeg",
                                      height: 60,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                      "images/bni.png",
                                      width: 60,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 15),
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        controller.launchURL(
                            "https://ikapj.or.id/product/kartu-anggota-ikapj/");
                      },
                      child: Text('Pesan Sekarang',
                          style: AppFonts.poppins(
                            fontSize: 14,
                            color: white,
                          )),
                    )),
              ],
            );
          }),
        ));
  }
}
