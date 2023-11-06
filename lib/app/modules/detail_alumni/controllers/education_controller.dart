import 'dart:convert';
import 'package:cdc/app/data/models/educations_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/services/api_services.dart';

class EducationController extends GetxController {
  final RxList<EducationsModel> educations = RxList<EducationsModel>();

  void fetchData(String userId) async {
    try {
      final result = await fetchEducations(userId);
      educations.assignAll(result);
    } catch (e) {
      print('Error fetching education details: $e');
    }
  }

  Future<List<EducationsModel>> fetchEducations(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(
      Uri.parse('${ApiServices.baseUrl}/user/detail/$userId'),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse['status'] == true) {
        final userDetail = UserDetail.fromJson(jsonResponse['data']);
        return userDetail.educations ?? <EducationsModel>[];
      } else {
        throw Exception(
            'Failed to fetch user details: ${jsonResponse['message']}');
      }
    } else {
      throw Exception(
          'Failed to fetch user details. Status code: ${response.statusCode}');
    }
  }

}
