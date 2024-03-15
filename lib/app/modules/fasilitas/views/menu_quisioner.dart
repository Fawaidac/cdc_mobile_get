import 'package:cdc/app/modules/fasilitas/controllers/tracer_study_controller.dart';
import 'package:cdc/app/modules/quisioner/views/identitas_section_view.dart';
import 'package:cdc/app/modules/quisioner/views/paket_questioner_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_dialog.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuQuisioner extends StatelessWidget {
  const MenuQuisioner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: white,
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
          "Menu Quesioner",
          style: AppFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetX<TracerStudyContoller>(
        init: TracerStudyContoller(),
        initState: (c) {
          c.controller!.getTracerStudy();
        },
        builder: (c) {
          return c.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                )
              : c.isEmptyData.value
                  ? const Center(child: Text("Paket Quesioner masih kosong!"))
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pilih Paket Quesioner",
                            style: AppFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: black,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            children: [
                              ListView.builder(
                                itemCount: c.model!.data.length,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var data = c.model?.data;
                                  return cardItems(
                                    index,
                                    data?[index].judul,
                                    data?[index].tipe,
                                    data?[index].id,
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    );
        },
      ),
    );
  }

  InkWell cardItems(index, title, type, id) {
    return InkWell(
      onTap: () {
        AppDialog.show(
          title: "Perhatian !",
          isTouch: false,
          desc:
              "Mohon perhatikan dengan baik, setelah Anda masuk ke dalam kuesioner, tidak ada kemungkinan untuk kembali. Pastikan Anda melengkapi semua pertanyaan disetiap sesi",
          onOk: () async {
            // Get.to(() => IdentitasSectionView());
            Get.toNamed(Routes.PAKET_QUISIONER, arguments: id);
          },
          onCancel: () {
            Get.back();
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: primaryColor, width: 1.5),
            borderRadius: BorderRadius.circular(7),
          ),
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: AppFonts.poppins(
                        fontSize: 16,
                        color: white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                    Text(
                      type,
                      style: AppFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
