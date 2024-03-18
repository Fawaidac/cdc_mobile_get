import 'dart:convert';

import 'package:cdc/app/modules/quisioner/controllers/paket_questioner_controller.dart';
import 'package:cdc/app/resource/custom_textfieldform.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_dialog.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaketQuesionerView extends StatelessWidget {
  const PaketQuesionerView({super.key});

  void _showExitConfirmationDialog(BuildContext context) {
    Get.defaultDialog(
      title: "Perhatian !",
      barrierDismissible: false,
      backgroundColor: white,
      titleStyle: AppFonts.poppins(
          fontSize: 20, color: black, fontWeight: FontWeight.bold),
      radius: 10,
      titlePadding: const EdgeInsets.only(top: 15),
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      content: Column(
        children: [
          Text(
            "Silahkan selesaikan semua sesi quisioner",
            textAlign: TextAlign.center,
            style: AppFonts.poppins(
                fontSize: 12, color: black, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  primary: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  textStyle: AppFonts.poppins(
                      fontSize: 12, color: white, fontWeight: FontWeight.w500),
                ),
                child: const Text("Tutup"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController namaC = TextEditingController();
    String? prodi;
    Map<String, TextEditingController> controllers = {};
    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmationDialog(context);
        return Future.value(false);
      },
      child: GetX<PaketQuesionerController>(
        init: PaketQuesionerController(),
        initState: (_) {
          var id = Get.arguments['id'];
          var titlePaket = Get.arguments['title'];
          _.controller!.idPaket.value = id.toString();
          _.controller!.titlePaket.value = titlePaket.toString();
          _.controller!.getPaket(id);
          _.controller!.getProdi();
          _.controller!.getJurusan();
          _.controller!.getKodeQuesioner();
        },
        builder: (c) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: white,
              shadowColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  _showExitConfirmationDialog(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  color: black,
                ),
              ),
              title: Text(
                c.titlePaket.value,
                style: AppFonts.poppins(
                  fontSize: 16,
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: c.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : c.isLoadingKode.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: c.model!.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = c.model!.data;
                                  if (data[index].tipe.displayValue ==
                                      "Input Text") {
                                    controllers[data[index].kodePertanyaan] =
                                        TextEditingController(
                                            text: c.requestBody[data[index]
                                                    .kodePertanyaan] ??
                                                "");
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      width: MediaQuery.of(context).size.width,
                                      color: white,
                                      child: CustomTextFieldForm(
                                        controller: controllers[
                                            data[index].kodePertanyaan]!,
                                        isRequired: true,
                                        onChanged: (p0) {
                                          c.requestBody[data[index]
                                              .kodePertanyaan] = controllers[
                                                  data[index].kodePertanyaan]!
                                              .text;
                                        },
                                        label: data[index].pertanyaan,
                                        keyboardType: TextInputType.text,
                                        isEnable: true,
                                        inputFormatters:
                                            FilteringTextInputFormatter
                                                .singleLineFormatter,
                                      ),
                                    );
                                  } else if (data[index].tipe.value ==
                                          "select" ||
                                      data[index].tipe.value == "checkbox") {
                                    List<dynamic> option =
                                        jsonDecode(data[index].options ?? '0');
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            data[index].pertanyaan,
                                            style: AppFonts.poppins(
                                              fontSize: 12,
                                              color: black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        DropdownButtonFormField<String>(
                                          isExpanded: true,
                                          value: c.requestBody[
                                              data[index].kodePertanyaan],
                                          icon: const Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Colors.black,
                                          ),
                                          onChanged: (newValue) {
                                            c.requestBody[data[index]
                                                .kodePertanyaan] = newValue!;
                                          },
                                          items: option.map((prodi) {
                                            return DropdownMenuItem<String>(
                                              value: prodi,
                                              child: Text(
                                                prodi,
                                                style: AppFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                          decoration: InputDecoration(
                                            hintText: "Pilih",
                                            isDense: true,
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.grey),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xFFFCFDFE),
                                          ),
                                        ),
                                        const SizedBox(height: 8)
                                      ],
                                    );
                                  } else {
                                    if (data[index].tipe.value ==
                                        "select_jurusan") {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              data[index].pertanyaan,
                                              style: AppFonts.poppins(
                                                fontSize: 12,
                                                color: black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          c.isLoadingJurusan.value
                                              ? const CircularProgressIndicator()
                                              : DropdownButtonFormField<String>(
                                                  isExpanded: true,
                                                  value: c.requestBody[
                                                      data[index]
                                                          .kodePertanyaan],
                                                  icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  onChanged: (newValue) {
                                                    c.requestBody[data[index]
                                                            .kodePertanyaan] =
                                                        newValue!;
                                                  },
                                                  items: c.jurusanM?.data
                                                      .map((prodi) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          prodi.id.toString(),
                                                      child: Text(
                                                        prodi.namaJurusan,
                                                        style: AppFonts.poppins(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  decoration: InputDecoration(
                                                    hintText: "Pilih Jurusan",
                                                    isDense: true,
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xFFFCFDFE),
                                                  ),
                                                ),
                                          const SizedBox(height: 8)
                                        ],
                                      );
                                    } else {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 8,
                                            ),
                                            child: Text(
                                              data[index].pertanyaan,
                                              style: AppFonts.poppins(
                                                fontSize: 12,
                                                color: black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          c.isLoadingProdi.value
                                              ? const CircularProgressIndicator()
                                              : DropdownButtonFormField<String>(
                                                  isExpanded: true,
                                                  value: c.requestBody[
                                                      data[index]
                                                          .kodePertanyaan],
                                                  icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  onChanged: (newValue) {
                                                    c.requestBody[data[index]
                                                            .kodePertanyaan] =
                                                        newValue!;
                                                  },
                                                  items: c.prodiM?.data
                                                      .map((prodi) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value:
                                                          prodi.id.toString(),
                                                      child: Text(
                                                        prodi.namaProdi,
                                                        style: AppFonts.poppins(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  decoration: InputDecoration(
                                                    hintText: "Pilih Prodi",
                                                    isDense: true,
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                            fontSize: 13,
                                                            color: Colors.grey),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.black,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        const Color(0xFFFCFDFE),
                                                  ),
                                                ),
                                          const SizedBox(height: 8)
                                        ],
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                c.page.value == 1
                                    ? Container()
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFFDEF0FF),
                                        ),
                                        onPressed: () async {
                                          if (c.page.value > 1) {
                                            c.page.value -= 1;
                                          }
                                          c.update;
                                          print(c.page.value);
                                          await c.getPaket(Get.arguments['id']);
                                        },
                                        child: Text(
                                          "Sebelumnya",
                                          style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                c.isLoadingKode.value
                                    ? Container()
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: primaryColor,
                                        ),
                                        onPressed: () async {
                                          if (c.kodeQuesionerM!.data.length /
                                                  5 ==
                                              c.page.value) {
                                            // c.requestBody.forEach((key, value) {
                                            //   if (value == null) {
                                            //     AppDialog.show(
                                            //       title: "Perhatian !",
                                            //       isTouch: false,
                                            //       desc:
                                            //           "Quesioner harus terisi semua",
                                            //       onOk: () async {
                                            //         await c.postQuesioner();
                                            //       },
                                            //       onCancel: () {
                                            //         Get.back();
                                            //       },
                                            //     );
                                            //   } else {
                                            AppDialog.show(
                                              title: "Perhatian !",
                                              isTouch: false,
                                              desc:
                                                  "Apakah anda yakin ingin menyimpan quesioner anda ini ?",
                                              onOk: () async {
                                                await c.postQuesioner();
                                              },
                                              onCancel: () {
                                                Get.back();
                                              },
                                            );
                                            //   }
                                            // });
                                          } else {
                                            c.page.value += 1;
                                            c.update;
                                            print(c.page.value);
                                            await c
                                                .getPaket(Get.arguments['id']);
                                          }
                                        },
                                        child: Text(
                                          c.kodeQuesionerM!.data.length / 5 ==
                                                  c.page.value
                                              ? "Simpan"
                                              : "Selanjutnya",
                                          style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            // ElevatedButton(
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: primaryColor,
                            //   ),
                            //   onPressed: () async {
                            //     print(c.requestBody);
                            //     c.postQuesioner();
                            //   },
                            //   child: Text(
                            //     "Simpan",
                            //     style: AppFonts.poppins(
                            //       fontSize: 12,
                            //       color: white,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }
}
