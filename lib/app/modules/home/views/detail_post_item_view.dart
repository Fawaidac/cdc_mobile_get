import 'package:cdc/app/data/models/comment_model.dart';
import 'package:cdc/app/modules/home/controllers/detail_post_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailPostItemView extends GetView<DetailPostController> {
  final String image;
  final String id;
  final String description;
  final String position;
  final String company;
  final String linkApply;
  final String typeJobs;
  final String expired;
  final String verified;
  final String name;
  final String profile;
  final String postAt;
  final int can;
  final bool isUser;
  List<CommentModel> commentModel;

  DetailPostItemView({
    super.key,
    required this.image,
    required this.description,
    required this.id,
    required this.position,
    required this.company,
    required this.typeJobs,
    required this.expired,
    required this.isUser,
    required this.linkApply,
    required this.verified,
    required this.name,
    required this.profile,
    required this.postAt,
    required this.can,
    required this.commentModel,
  });

  @override
  final controller = Get.put(DetailPostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPostItemView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPostItemView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
