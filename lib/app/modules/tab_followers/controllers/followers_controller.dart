import 'dart:convert';

import 'package:cdc/app/data/models/followers_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FollowersController extends GetxController {
  final RxList<Follower> followersList = <Follower>[].obs;

  void fetchDataFollowers(String userId) async {
    try {
      final result = await fetchUserFollowers(userId);
      followersList.addAll(result);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Follower>> fetchUserFollowers(String userId) async {
    final String url = '${ApiServices.baseUrl}/user/followers/$userId';

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
          jsonResponse['data']['user']['followers'];

      // Parse the list of followers
      final List<Follower> followers = followersData.map((followerJson) {
        return Follower.fromJson(followerJson);
      }).toList();

      return followers;
    } else {
      throw Exception('Failed to fetch followers');
    }
  }
}
