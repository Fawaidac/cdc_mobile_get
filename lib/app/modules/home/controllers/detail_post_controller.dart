import 'dart:convert';

import 'package:cdc/app/data/models/comment_model.dart';
import 'package:cdc/app/data/models/user_model.dart';
import 'package:cdc/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPostController extends GetxController {
  late TextEditingController comment;
  final comments = <CommentModel>[].obs;
  User? user;
  HomeController homeController = Get.find<HomeController>();
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
    print(comments);
  }
}
