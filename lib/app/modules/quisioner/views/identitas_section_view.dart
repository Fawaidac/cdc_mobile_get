import 'package:cdc/app/modules/quisioner/controllers/identitas_section_controller.dart';
import 'package:cdc/app/resource/custom_textfieldform.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IdentitasSectionView extends GetView<IdentitasSectionController> {
  IdentitasSectionView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(IdentitasSectionController());

  @override
  Widget build(BuildContext context) {
    controller.fetchData();
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
          "Identitas Diri",
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
              child: CustomTextFieldForm(
                  controller: controller.kdptimsmh,
                  label: "Kode Perguruan Tinggi/kdptimsmh",
                  keyboardType: TextInputType.text,
                  isRequired: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                width: MediaQuery.of(context).size.width,
                color: white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih Program Studi",
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
                        child: Obx(
                          () => DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: controller.selectedProdi.value.isEmpty
                                ? null
                                : controller.selectedProdi.value,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.black,
                            ),
                            onChanged: (newValue) {
                              controller.selectedProdi.value = newValue!;
                              controller.selectedId.value = controller.prodiList
                                  .firstWhere((prodi) =>
                                      prodi['nama_prodi'] == newValue)['id']
                                  .toString();
                            },
                            items: controller.prodiList.map((prodi) {
                              return DropdownMenuItem<String>(
                                value: prodi['nama_prodi'],
                                child: Text(
                                  prodi['nama_prodi'],
                                  style: AppFonts.poppins(
                                      fontSize: 12, color: Colors.black),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: "Pilih Program Studi",
                              isDense: true,
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.grey),
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
                          ),
                        )),
                  ],
                )),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: controller.nim,
                  isRequired: true,
                  label: "NIM / nimhsmsmh  (Gunakan Huruf Besar)",
                  keyboardType: TextInputType.text,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: controller.nama,
                  isRequired: true,
                  label: "Nama Lengkap / nmmhsmsmh",
                  keyboardType: TextInputType.text,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: controller.telp,
                  isRequired: true,
                  isLength: 15,
                  label: "Nomor Telepon/HP (Whatsapp) / telpomsmh",
                  keyboardType: TextInputType.number,
                  isEnable: true,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: controller.email,
                  isRequired: true,
                  label: "Alamat Email / emailmsmh",
                  keyboardType: TextInputType.emailAddress,
                  isEnable: true,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: controller.tahunLulus,
                  isRequired: true,
                  isLength: 4,
                  label: "Tahun Lulus",
                  keyboardType: TextInputType.number,
                  isEnable: true,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                  controller: controller.nik,
                  isLength: 16,
                  isRequired: true,
                  label: "NIK / nik (Nomor Induk Kependudukan/No KTP)",
                  keyboardType: TextInputType.number,
                  isEnable: true,
                  inputFormatters: FilteringTextInputFormatter.digitsOnly),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
              width: MediaQuery.of(context).size.width,
              color: white,
              child: CustomTextFieldForm(
                controller: controller.npwp,
                label: "NPWP / npwp (Nomor Pokok Wajib Pajak)",
                keyboardType: TextInputType.number,
                isEnable: true,
                isRequired: true,
                inputFormatters: FilteringTextInputFormatter.digitsOnly,
                isLength: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        if (controller.isUpdate.value == true) {
                          controller.handleUpdateQuisionerIdentitas();
                        } else {
                          controller.handleQuisionerIdentitas();
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
            ),
          ],
        ),
      ),
    );
  }
}
