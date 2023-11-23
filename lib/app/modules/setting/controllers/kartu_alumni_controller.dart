import 'dart:convert';

import 'package:cdc/app/modules/setting/views/add_education_user_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class KartuAlumniController extends GetxController {
  RxMap<String, dynamic> alumniData = RxMap();

  Future<void> getDataAlumni() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http
          .get(Uri.parse('${ApiServices.baseUrl}/user/card'), headers: {
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'];
        if (data['educations'] == null) {
          AppDialog.show(
            title: "Perhatian !",
            isTouch: false,
            desc:
                "Ops , data pendidikan politeknik negeri jember anda kosong, silahkan tambah data terlebih dahulu",
            onOk: () async {
              Get.to(() => AddEducationUserView());
            },
            onCancel: () {
              Get.back();
            },
          );
        }
        alumniData.value = data;
        print('Data fetched successfully: $alumniData');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataAlumni();
  }
}
