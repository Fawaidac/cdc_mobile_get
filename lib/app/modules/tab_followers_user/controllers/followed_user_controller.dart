import 'dart:convert';

import 'package:cdc/app/data/models/followers_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FollowedUserController extends GetxController {
  final RxList<Follower> followersList = <Follower>[].obs;

  void fetchDataFollowed() async {
    try {
      final result = await fetchUserFollowed();
      followersList.assignAll(result);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Follower>> fetchUserFollowed() async {
    String url = '${ApiServices.baseUrl}/user/followed';

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> followersData =
          jsonResponse['data']['user']['followed'];
      final List<Follower> followers = followersData.map((followerJson) {
        return Follower.fromJson(followerJson);
      }).toList();

      return followers;
    } else {
      throw Exception('Failed to fetch followers');
    }
  }
}
