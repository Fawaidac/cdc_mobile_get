import 'package:cdc/app/resource/custom_textfieldform.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/posting_controller.dart';

class PostingView extends GetView<PostingController> {
  PostingView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(PostingController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            "Pilih Gambar",
            style: AppFonts.poppins(fontSize: 12, color: black),
          ),
          GestureDetector(
            onTap: () => controller.getImageGalery(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [8, 4],
                strokeCap: StrokeCap.round,
                color: black,
                child: Obx(() {
                  final imageValue =
                      controller.image.value; // Get the value once
                  return imageValue == null
                      ? Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/photo.png",
                                height: 40,
                                color: black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "upload gambar",
                                style: AppFonts.poppins(
                                  fontSize: 12,
                                  color: softgrey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(imageValue),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                }),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Tambah Keterangan",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
              Text(
                "*",
                style: AppFonts.poppins(fontSize: 12, color: red),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  controller: controller.keterangan,
                  style: AppFonts.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.text,
                  onSaved: (val) =>
                      controller.keterangan = val as TextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  decoration: InputDecoration(
                    hintText: "Keterangan ...",
                    isDense: true,
                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
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
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Tambah Posisi",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
              Text(
                "*",
                style: AppFonts.poppins(fontSize: 12, color: red),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  controller: controller.posisi,
                  style: AppFonts.poppins(fontSize: 13, color: black),
                  keyboardType: TextInputType.text,
                  onSaved: (val) =>
                      controller.posisi = val as TextEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  decoration: InputDecoration(
                    hintText: "Posisi",
                    isDense: true,
                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
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
                )
              ],
            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: ElevatedButton.icon(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.add,
          //       color: white,
          //       size: 20,
          //     ),
          //     label: Text("Tambah"),
          //     style: ElevatedButton.styleFrom(
          //       shadowColor: Colors.transparent,
          //       primary: primaryColor,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //       textStyle: AppFonts.poppins(
          //           fontSize: 12, color: white, fontWeight: FontWeight.w500),
          //     ),
          //   ),
          // ),
          CustomTextFieldForm(
              isEnable: true,
              controller: controller.perusahaan,
              label: "Nama Perusahaan",
              isRequired: true,
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Jenis Pekerjaan",
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
                  value: controller.selectedType,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: black,
                  ),
                  onChanged: (newValue) {
                    controller.toggleChangeType(newValue!);
                  },
                  items: controller.typeOptions.map((v) {
                    return DropdownMenuItem<String>(
                      value: v,
                      child: Text(
                        v,
                        style: AppFonts.poppins(fontSize: 12, color: black),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: "Pilih",
                    isDense: true,
                    hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
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
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Tanggal Tutup",
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
          Obx(() => GestureDetector(
                onTap: () {
                  controller.selectDate(context);
                },
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat('dd MMMM yyyy')
                              .format(controller.selectedDate.value),
                          style: AppFonts.poppins(fontSize: 13, color: black),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: black,
                        ),
                      )
                    ],
                  ),
                ),
              )),
          CustomTextFieldForm(
              isEnable: true,
              controller: controller.tautan,
              isRequired: true,
              label: "Tautan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "*",
                style: AppFonts.poppins(fontSize: 14, color: red),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Wajib Isi",
                style: AppFonts.poppins(fontSize: 14, color: black),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 25),
              height: 48,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(15)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () {
                  controller.check();
                },
                child: Text('Unggah',
                    style: AppFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: white,
                    )),
              )),
        ],
      ),
    );
  }
}
