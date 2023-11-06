import 'dart:convert';

import 'package:cdc/app/data/models/followers_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FollowedController extends GetxController {
  final RxList<Follower> followersList = <Follower>[].obs;

  void fetchDataFollowed(String userId) async {
    try {
      final result = await fetchUserFollowed(userId);
      followersList.addAll(result);
    } catch (e) {
      print(e);
    }
  }

  Future<List<Follower>> fetchUserFollowed(String userId) async {
    final String url = '${ApiServices.baseUrl}/user/followed/$userId';

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
      final userFollowers =
          UserFollowersInfo.fromJson(jsonResponse['data']['user']['followed']);
      return userFollowers.followers ?? <Follower>[];
      // final data = json.decode(response.body);

      // final int totalFollowers = data['data']['total_followers'];
      // final User user = User.fromJson(data['data']['user']);
      // List<Follower> followed = [];
      // if (data['data']['user']['followed'] != null) {
      //   data['data']['user']['followed'].forEach((followerData) {
      //     followed.add(Follower.fromJson(followerData));
      //   });
      // }

      // return UserFollowedInfo(
      //     totalFollowers: totalFollowers, user: user, followed: followed);
    } else {
      throw Exception('Failed to fetch followers');
    }
  }
}
