import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuisionerController extends GetxController {
  var quisionerData = RxList<Map<String, dynamic>>([]);
  RxList<String> data = RxList([
    'Identitas Diri',
    'Kuisioner Umum',
    'Studi Lanjut',
    'Tingkat Kompetensi',
    'Metode Pembelajaran',
    'Mulai Mencari Pekerjaan',
    'Bagaimana anda mencari pekerjaan tersebut?',
    'Jumlah Perusahaan/instansi/institusi yang sudah anda lamar',
    'Kesesuaian pekerjaan anda saat ini dengan pendidikan anda',
  ]);

  void fetchQuisionerData() async {
    try {
      final response = await quisionerCheck();
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        final List<String> questionKeys = [
          'identitas_section',
          'main_section',
          'furthe_study_section',
          'competent_level_section',
          'study_method_section',
          'jobs_street_section',
          'how_find_jobs_section',
          'company_applied_section',
          'job_suitability_section',
        ];

        final List<Map<String, dynamic>> questions = questionKeys
            .where((key) => data[key] != null)
            .map((key) => {
                  'title': key,
                  'value': true,
                })
            .toList();
        print(questions);
        quisionerData.addAll(questions);
        update();
      }
    } catch (e) {
      print('Error fetching questionnaire data: $e');
    }
  }

  static Future<Map<String, dynamic>> quisionerCheck() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print(token);
      final response = await http.get(
          Uri.parse('${ApiServices.baseUrl}/user/quisioner/check'),
          headers: {"Authorization": "Bearer $token"});
      final responseJson = jsonDecode(response.body);
      return responseJson;
    } catch (e) {
      print('Error fetching quisioner check: $e');
      throw e;
    }
  }

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   fetchQuisionerData();
  // }
}
