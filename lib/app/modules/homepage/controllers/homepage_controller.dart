import 'dart:convert';

import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomepageController extends GetxController {
  var currentIndex = 0;
  final active = true.obs;
  final searchController = TextEditingController();
  final searchResult = [].obs;
  late PermissionStatus notificationStatus;
  late PermissionStatus storageStatus;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  void setActive(bool value) {
    active.value = value;
  }

  List navButtons = [
    {
      "active": Image.asset(
        "images/active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_home.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Home"
    },
    {
      "active": Image.asset(
        "images/active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_graph.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Gatau"
    },
    {
      "active": Image.asset(
        "images/active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "non_active": Image.asset(
        "images/non_active_plus.png",
        height: 20,
        width: 20,
        color: primaryColor,
      ),
      "label": "Posting"
    },
    {
      "active": Image.asset(
        "images/fill.png",
        height: 25,
        width: 25,
      ),
      "non_active": Image.asset(
        "images/non.png",
        height: 25,
        width: 25,
        color: primaryColor,
      ),
      "label": "Gatau"
    },
    {
      "active": Image.asset(
        "images/active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "non_active": Image.asset(
        "images/non_active_profile.png",
        height: 20,
        color: primaryColor,
        width: 20,
      ),
      "label": "Profile"
    },
  ];

  // RxString currentRoute = "".obs;
  // @override
  // void onInit() {
  //   super.onInit();
  //   requestPermissions();
  //   storeFcmToken();
  // }

  Future<void> requestPermissions() async {
    // Request notification permission
    final status = await Permission.notification.request();
    notificationStatus = status;

    // Request external storage permission
    final storage = await Permission.storage.request();
    storageStatus = storage;
  }

  Future<void> searchUser(String key) async {
    try {
      final result = await searchDataUser(key);

      if (result.isNotEmpty) {
        searchResult.assignAll(result);
      } else {
        searchResult.clear();
      }
    } catch (e) {
      print("Error searching users: $e");
    }
  }

  void storeFcmToken() async {
    final fcmToken = await firebaseMessaging.getToken();
    await firebaseMessaging.subscribeToTopic('all');
    print(' fcmTOken : $fcmToken');
    final res = await sendFcmToken(fcmToken!);
    if (res['code'] == 200) {
      print('ok');
    } else {
      print(res['message']);
    }
  }

  static Future<Map<String, dynamic>> sendFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final res = await http
        .put(Uri.parse('${ApiServices.baseUrl}/user/fcmtoken'), body: {
      'token': token,
    }, headers: {
      "Authorization": "Bearer $token",
    });
    final data = jsonDecode(res.body);
    return data;
  }

  static Future<List<Map<String, dynamic>>> searchDataUser(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.post(
      Uri.parse('${ApiServices.baseUrl}/user/search'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'key': key}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == true) {
        final List<dynamic> dataList = data['data'];

        List<Map<String, dynamic>> result = [];

        for (var item in dataList) {
          result.add({
            'id': item['id'],
            'fullname': item['fullname'],
            'email': item['email'],
            'nik': item['nik'],
            'no_telp': item['no_telp'],
            'foto': item['foto'],
            'ttl': item['ttl'],
            'alamat': item['alamat'],
            'about': item['about'],
            'gender': item['gender'],
            'level': item['level'],
            'linkedin': item['linkedin'],
            'facebook': item['facebook'],
            'instagram': item['instagram'],
            'twiter': item['twiter'],
            'account_status': item['account_status'],
          });
        }

        return result;
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to fetch user data');
    }
  }
}
