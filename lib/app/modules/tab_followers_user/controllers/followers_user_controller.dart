import 'dart:convert';

import 'package:cdc/app/data/models/followers_model.dart';
import 'package:http/http.dart' as http;
import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FollowersUserController extends GetxController {
  final RxList<Follower> followersList = <Follower>[].obs;

  void fetchDataFollowers() async {
    try {
      final result = await fetchUserFollowers();
      followersList.assignAll(result);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Follower>> fetchUserFollowers() async {
    String url = '${ApiServices.baseUrl}/user/followers';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> followersData = jsonResponse['data']['followers'];

      final List<Follower> followers = followersData.map((followerJson) {
        return Follower.fromJson(followerJson);
      }).toList();

      return followers;
    } else {
      throw Exception('Failed to fetch followers');
    }
  }
}
