import 'package:cdc/app/data/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPostController extends GetxController {
  late TextEditingController comment;
  final comments = <CommentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    comment = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    comment.dispose();
  }

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
}
