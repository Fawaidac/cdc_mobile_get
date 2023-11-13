import 'dart:convert';

import 'package:cdc/app/data/models/comment_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:cdc/app/modules/profile/controllers/post_user_controller.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/post_model.dart';

class DetailPostController extends GetxController {
  var comment = TextEditingController();
  final comments = <CommentModel>[].obs;

  void initializeComments(List<CommentModel> commentModel) {
    comments.assignAll(commentModel);
  }

  Future<void> launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      Get.snackbar("Error", "Tidak bisa mengunjungi situs",
          margin: const EdgeInsets.all(10));
    }
  }

  Future<void> deletePostingan(String postId) async {
    try {
      EasyLoading.show(status: "Loading...");
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.delete(
          Uri.parse('${ApiServices.baseUrl}/user/post/delete/$postId'),
          headers: {"Authorization": "Bearer $token"});
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['code'] == 200) {
        Get.snackbar("Success", "Berhasil menghapus postingan",
            margin: const EdgeInsets.all(10));
        Get.find<PostUserController>().postList.refresh();
        Get.find<PostUserController>().fetchData();
        Get.offAllNamed(Routes.HOMEPAGE);
      } else {
        Get.snackbar("Error", data['message'],
            margin: const EdgeInsets.all(10));
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<Map<String, dynamic>> nonActiveComment(
      String postId, bool option) async {
    final Map<String, dynamic> requestBody = {"option": option};
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.put(
        Uri.parse('${ApiServices.baseUrl}/user/post/update/comment/$postId'),
        body: jsonEncode(requestBody),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> fetchDetailPost(String postId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.get(
      Uri.parse('${ApiServices.baseUrl}/user/post/detail-post/$postId'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['status'] == true) {
        return data['data'];
      } else {
        print("Failed to fetch post: ${data['message']}");
      }
    } else {
      print("Failed to fetch post: ${response.statusCode}");
    }

    // Return a default or placeholder Map<String, dynamic> when fetch fails
    return {
      "id": "", // Provide default values for other fields as needed
      "userId": "",
      "linkApply": "",
      "image": "",
      "description": "",
      "company": "",
      "position": "",
      "expired": "",
      "postAt": "",
      "canComment": 0,
      "verified": "",
      "comments": [],
      "typeJobs": "",
      "uploader": {
        "id": "",
        "fullname": "",
        "email": "",
        "nik": "",
        "noTelp": "",
        "foto": "",
        "tempatTanggalLahir": "",
        "alamat": "",
        "about": "",
        "gender": "",
        "level": "",
        "linkedin": "",
        "facebook": "",
        "instagram": "",
        "twitter": "",
        "accountStatus": 0,
        "lat": "",
        "long": "",
      },
    };
  }

  Future<Map<String, dynamic>> storeComment(
      String postId, String comment) async {
    final Map<String, dynamic> requestBody = {
      "comment": comment,
      "post_id": postId
    };
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(
        Uri.parse('${ApiServices.baseUrl}/user/post/comment'),
        body: jsonEncode(requestBody),
        headers: {
          "Authorization": "Bearer $token",
          'Content-Type': 'application/json',
        });
    final data = jsonDecode(response.body);
    return data;
  }

  Future<Map<String, dynamic>> deleteComment(
      String postID, String commentID) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token not found");
    }

    final response = await http.delete(
      Uri.parse('${ApiServices.baseUrl}/user/post/comment'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'post_id': postID,
        'comment_id': commentID,
      }),
    );

    final data = jsonDecode(response.body);
    return data;
  }
}
