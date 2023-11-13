import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../resource/custom_textfieldform.dart';
import '../../../utils/app_colors.dart';
import '../controllers/update_post_controller.dart';

class UpdatePostView extends GetView<UpdatePostController> {
  UpdatePostView({Key? key}) : super(key: key);

  final controller = Get.put(UpdatePostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
              )),
          title: Text(
            "Edit Postingan",
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Tambah Keterangan",
                      style: AppFonts.poppins(fontSize: 12, color: black),
                    ),
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
                      controller: controller.desc,
                      style: AppFonts.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.text,
                      onSaved: (val) =>
                          controller.desc = val as TextEditingController,
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
                        hintStyle:
                            GoogleFonts.poppins(fontSize: 13, color: grey),
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
                        fillColor: Color(0xFFFCFDFE),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextFieldForm(
                          isEnable: true,
                          controller: controller.posisi,
                          label: "Nama Posisi",
                          isRequired: true,
                          keyboardType: TextInputType.name,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomTextFieldForm(
                          isEnable: true,
                          controller: controller.perusahaan,
                          label: "Nama Perusahaan",
                          isRequired: true,
                          keyboardType: TextInputType.name,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Jenis Pekerjaan",
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
                      value: controller.selectedType,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: black,
                      ),
                      onChanged: (newValue) {
                        controller.selectedType = newValue;
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
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Tanggal Tutup",
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
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.selectDate(context);
                  },
                  child: Container(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          controller.selectedDate.value == null
                              ? "Tanggal Masuk"
                              : DateFormat('dd MMMM yyyy')
                                  .format(controller.selectedDate.value!),
                          style: AppFonts.poppins(fontSize: 13, color: black),
                        )),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: black,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              CustomTextFieldForm(
                  isEnable: true,
                  controller: controller.tautan,
                  isRequired: true,
                  label: "Tautan",
                  keyboardType: TextInputType.name,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
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
                      controller.submitPost();
                    },
                    child: Text('Perbarui Postingan',
                        style: AppFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: white,
                        )),
                  )),
            ],
          ),
        ));
  }
}
