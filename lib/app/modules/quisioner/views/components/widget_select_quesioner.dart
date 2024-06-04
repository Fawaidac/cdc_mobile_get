import 'package:cdc/app/data/models/paket_quesioner_model.dart';
import 'package:cdc/app/modules/quisioner/controllers/paket_questioner_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Column widgetSelectQuesioner(List<Datum> data, int index,
    PaketQuesionerController c, List<dynamic> option) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
        value: c.requestBody[data[index].kodePertanyaan],
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.black,
        ),
        onChanged: (newValue) {
          c.requestBody[data[index].kodePertanyaan] = newValue!;
        },
        items: option.map((prodi) {
          return DropdownMenuItem<String>(
            value: prodi.toString(),
            child: Text(
              prodi.toString(),
              style: AppFonts.poppins(fontSize: 12, color: Colors.black),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          hintText: "Pilih",
          isDense: true,
          hintStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
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
      const SizedBox(height: 8)
    ],
  );
}

Column widgetSelectJurusanQuesioner(
    List<Datum> data, int index, PaketQuesionerController c) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data[index].pertanyaan,
              style: AppFonts.poppins(
                fontSize: 12,
                color: black,
                fontWeight: FontWeight.w400,
              ),
            ),
            // Text(
            //   '*',
            //   style: AppFonts.poppins(
            //     fontSize: 20,
            //     color: Colors.red,
            //     fontWeight: FontWeight.w700,
            //   ),
            // )
          ],
        ),
      ),
      c.isLoadingJurusan.value
          ? const CircularProgressIndicator()
          : DropdownButtonFormField<String>(
              isExpanded: true,
              value: c.requestBody[data[index].kodePertanyaan],
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.black,
              ),
              onChanged: (newValue) {
                c.requestBody[data[index].kodePertanyaan] = newValue!;
              },
              items: c.jurusanM?.data.map((prodi) {
                return DropdownMenuItem<String>(
                  value: prodi.id.toString(),
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
                    GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
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
      const SizedBox(height: 8)
    ],
  );
}
