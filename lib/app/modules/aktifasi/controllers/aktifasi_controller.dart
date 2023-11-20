import 'dart:convert';
import 'dart:io';

import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class AktifasiController extends GetxController {
  Rx<File?> pdf = Rx<File?>(null);
  String? selectedJenisKelamin;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  late TextEditingController nama;
  late TextEditingController email;
  late TextEditingController nim;
  late TextEditingController telp;
  late TextEditingController tempatLahir;
  late TextEditingController alamat;
  late TextEditingController gender;
  late TextEditingController jurusan;
  late TextEditingController prodi;
  late TextEditingController tahunLulus;
  late TextEditingController angkatan;

  List<String> chooseOptions = [
    'Laki-Laki',
    'Perempuan',
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nama = TextEditingController();
    email = TextEditingController();
    nim = TextEditingController();
    telp = TextEditingController();
    tempatLahir = TextEditingController();
    jurusan = TextEditingController();
    prodi = TextEditingController();
    tahunLulus = TextEditingController();
    angkatan = TextEditingController();
    alamat = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nama.dispose();
    email.dispose();
    nim.dispose();
    telp.dispose();
    tempatLahir.dispose();
    alamat.dispose();
    jurusan.dispose();
    prodi.dispose();
    tahunLulus.dispose();
    angkatan.dispose();
  }

  void toggleChangeType(String v) {
    selectedJenisKelamin = v;
  }

  void selectDate(BuildContext _) async {
    final DateTime? pickedDate = await showDatePicker(
      context: _,
      initialDate: selectedDate.value ?? DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  Future pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    if (result != null) {
      final filePath = result.paths.first;
      if (filePath != null) {
        pdf.value = File(filePath);
      }
    }
  }

  Future<void> sendAktifasiAkun() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);
    if (pdf.value == null) {
      Get.snackbar("Error", "Silahkan upload ijazah anda dengan format pdf",
          margin: const EdgeInsets.all(10));
    } else {
      final response = await send(
          pdf: pdf.value!,
          nama: nama.text,
          email: email.text,
          nim: nim.text,
          telp: telp.text,
          tempatlahir: tempatLahir.text,
          tanggalLahir: formattedDate,
          alamat: alamat.text,
          gender: selectedJenisKelamin.toString(),
          jurusan: jurusan.text,
          prodi: prodi.text,
          tahunLulus: tahunLulus.text,
          angkatan: angkatan.text);
      if (response['code'] == 200) {
        // ignore: use_build_context_synchronously
        Get.toNamed(Routes.LOGIN);
        Get.snackbar("Success", "Berhasil mengirim pengajuan aktifasi akun",
            margin: const EdgeInsets.all(10));
      } else if (response['message'] ==
          "The ijazah must not be greater than 1024 kilobytes.") {
        Get.snackbar("Error", "Ukuran pdf ijazah tidak boleh melebihi 1024 KB",
            margin: const EdgeInsets.all(10));
      } else {
        Get.snackbar("Error", response['message'],
            margin: const EdgeInsets.all(10));
        print(response['message']);
      }
    }
  }

  static Future<Map<String, dynamic>> send({
    required File pdf,
    required String nama,
    required String email,
    required String nim,
    required String telp,
    required String tempatlahir,
    required String tanggalLahir,
    required String alamat,
    required String gender,
    required String jurusan,
    required String prodi,
    required String tahunLulus,
    required String angkatan,
  }) async {
    // Buat request Multipart
    final request = http.MultipartRequest(
        'POST', Uri.parse('${ApiServices.baseUrl}/alumni/submissions'));

    // Tambahkan data Multipart
    request.fields['nama_lengkap'] = nama;
    request.fields['nim'] = nim;
    request.fields['email'] = email;
    request.fields['no_telp'] = telp;
    request.fields['tempat_lahir'] = tempatlahir;
    request.fields['tanggal_lahir'] = tanggalLahir;
    request.fields['alamat_domisili'] = alamat;
    request.fields['jenis_kelamin'] = gender;
    request.fields['jurusan'] = jurusan;
    request.fields['program_studi'] = prodi;
    request.fields['tahun_lulus'] = tahunLulus;
    request.fields['angkatan'] = angkatan;

    // Tambahkan gambar sebagai File Multipart
    final pdfFileName = path.basename(pdf.path);
    final pdfStream = http.ByteStream(pdf.openRead());
    final pdfLength = await pdf.length();
    final pdfUpload = http.MultipartFile('ijazah', pdfStream, pdfLength,
        filename: pdfFileName);
    request.files.add(pdfUpload);

    final response = await request.send();
    final streamedResponse = await http.Response.fromStream(response);
    final data = json.decode(streamedResponse.body);
    return data;
  }
}
