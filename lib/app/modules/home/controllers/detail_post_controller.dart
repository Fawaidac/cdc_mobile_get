import 'package:cdc/app/data/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
