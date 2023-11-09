import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/profile/controllers/profile_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resource/custom_textfield_checkbox.dart';
import '../../../resource/custom_textfieldform.dart';
import '../../../utils/app_colors.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  EditProfileView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(EditProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Edit Profile",
            style: AppFonts.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.getImageGalery();
                        },
                        child: Obx(
                          () => Stack(
                            children: [
                              controller.image.value == null
                                  ? CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(controller
                                                  .user.value.foto ==
                                              null
                                          ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                          : controller.user.value.foto ?? ""),
                                    )
                                  : CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          FileImage(controller.image.value!),
                                    ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: primaryColor),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 15,
                                        color: white,
                                      )))
                            ],
                          ),
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Visibility(
                                visible: controller.user.value.fullname != null,
                                replacement: CardLoading(
                                  height: 20,
                                  width: 125,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  controller.user.value.fullname.toString(),
                                  style: AppFonts.poppins(
                                    fontSize: 16,
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          Visibility(
                              visible: controller.user.value.alamat != null,
                              replacement: CardLoading(
                                height: 15,
                                margin: const EdgeInsets.only(top: 10),
                                width: 100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                controller.user.value.alamat.toString(),
                                style: AppFonts.poppins(
                                  fontSize: 12,
                                  color: black,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFieldForm(
                  controller: controller.fullname,
                  isEnable: true,
                  label: "Nama Lengkap",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Jenis Kelamin",
                            style: GoogleFonts.poppins(fontSize: 12),
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
                            value: controller.selectedGender.value,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: black,
                            ),
                            onChanged: (newValue) {
                              controller.selectedGender.value = newValue!;
                            },
                            items: controller.genderOptions.map((strata) {
                              return DropdownMenuItem<String>(
                                value: strata,
                                child: Text(
                                  strata,
                                  style: AppFonts.poppins(
                                      fontSize: 12, color: black),
                                ),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              hintText: "Pilih Jenis Kelamin",
                              isDense: true,
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 13, color: grey),
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
                        )),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: second.withOpacity(0.2),
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Visibilitas",
                          style: AppFonts.poppins(
                              fontSize: 14,
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        CustomTextFieldCheckbox(
                          controller: controller.telp,
                          label: "No. Telepon",
                          isEnable: true,
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              FilteringTextInputFormatter.digitsOnly,
                          checkboxValue: controller.isCheckedTelp.value,
                          onCheckboxChanged: (value) async {
                            controller.isCheckedTelp.value = value!;
                            controller.updateVisibility('no_telp', value);
                          },
                        ),
                        CustomTextFieldCheckbox(
                          controller: controller.ttl,
                          label: "Tempat, Tanggal Lahir",
                          isEnable: true,
                          keyboardType: TextInputType.text,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                          checkboxValue: controller.isCheckedTtl.value,
                          onCheckboxChanged: (value) {
                            controller.isCheckedTtl.value = value!;
                            controller.updateVisibility('ttl', value);
                          },
                        ),
                        CustomTextFieldCheckbox(
                          controller: controller.email,
                          onTap: () => updateEmail(),
                          label: "Email",
                          isEnable: true,
                          isReadOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                          checkboxValue: controller.isCheckedEmail.value,
                          onCheckboxChanged: (value) {
                            controller.isCheckedEmail.value = value!;
                            controller.updateVisibility('email', value);
                          },
                        ),
                        CustomTextFieldCheckbox(
                          controller: controller.nik,
                          label: "NIK",
                          isEnable: true,
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              FilteringTextInputFormatter.digitsOnly,
                          checkboxValue: controller.isCheckedNik.value,
                          onCheckboxChanged: (value) {
                            controller.isCheckedNik.value = value!;
                            controller.updateVisibility('nik', value);
                          },
                        ),
                        CustomTextFieldCheckbox(
                          controller: controller.alamat,
                          label: "Alamat",
                          isEnable: true,
                          keyboardType: TextInputType.text,
                          inputFormatters:
                              FilteringTextInputFormatter.singleLineFormatter,
                          checkboxValue: controller.isCheckedAlamat.value,
                          onCheckboxChanged: (value) {
                            controller.isCheckedAlamat.value = value!;
                            controller.updateVisibility('alamat', value);
                          },
                        ),
                      ],
                    ),
                  )),
              CustomTextFieldForm(
                  controller: controller.about,
                  label: "Tentang",
                  isEnable: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              CustomTextFieldForm(
                  controller: controller.linkedin,
                  isEnable: true,
                  label: "LinkedIn",
                  isPlaceholder: true,
                  hint: "Nickname linkedIn anda",
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              CustomTextFieldForm(
                  controller: controller.ig,
                  isEnable: true,
                  label: "Instagram",
                  hint: "Nickname instagram anda",
                  isPlaceholder: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              CustomTextFieldForm(
                  controller: controller.fb,
                  isEnable: true,
                  label: "Facebook",
                  hint: "Nickname facebook anda",
                  isPlaceholder: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              CustomTextFieldForm(
                  controller: controller.x,
                  isEnable: true,
                  label: "X",
                  hint: "Nickname x anda",
                  isPlaceholder: true,
                  keyboardType: TextInputType.text,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter),
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 15),
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
                      controller.handleUpdateProfile();
                    },
                    child: Text('Simpan Perubahan',
                        style: AppFonts.poppins(
                            fontSize: 14,
                            color: white,
                            fontWeight: FontWeight.bold)),
                  )),
            ],
          ),
        ));
  }

  void updateEmail() {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.white, // Change the background color here
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Change the radius here
      ),
      title: Text(
        "Perbarui email anda",
        style: AppFonts.poppins(fontSize: 14, color: primaryColor),
      ),
      content: TextField(
        controller: controller.newEmail,
        autofocus: true,
        style: AppFonts.poppins(fontSize: 12, color: black),
        decoration: InputDecoration(
          hintText: "Masukan email baru anda",
          hintStyle: AppFonts.poppins(fontSize: 12, color: softgrey),
          isDense: true,
          filled: true,
          fillColor: const Color(0xFFFCFDFE),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffF0F1F7),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        TextButton.icon(
            onPressed: () async {
              await controller.updateEmailUser(controller.newEmail.text);
            },
            icon: Icon(
              Icons.done,
              color: primaryColor,
            ),
            label: Text(
              "Simpan",
              style: AppFonts.poppins(fontSize: 12, color: primaryColor),
            ))
      ],
    ));
  }
}
