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
      // final data = json.decode(response.body);
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // final int totalFollowers = data['data']['total_followers'];
      // final User user = User.fromJson(data['data']['user']);
      // List<Follower> followers = [];
      // if (data['data']['user']['followers'] != null) {
      //   data['data']['user']['followers'].forEach((followerData) {
      //     followers.add(Follower.fromJson(followerData));
      //   });
      // }
      final userFollowers =
          UserFollowersInfo.fromJson(jsonResponse['data']['user']['followers']);
      return userFollowers.followers ?? <Follower>[];
    } else {
      throw Exception('Failed to fetch followers');
    }
  }
}
