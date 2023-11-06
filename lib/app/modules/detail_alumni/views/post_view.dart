import 'package:cdc/app/modules/detail_alumni/controllers/post_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PostView extends GetView<PostController> {
  var idUser;
  PostView({this.idUser, Key? key}) : super(key: key);

  @override
  final controller = Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    controller.scrollController.addListener(() {
      controller.scrollListener(idUser);
    });
    controller.fetchData(idUser);
    return Obx(() => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            mainAxisSpacing: 10,
          ),
          shrinkWrap: true,
          controller: controller.scrollController,
          itemBuilder: (context, index) {
            if (index < controller.postList.length) {
              final post = controller.postList[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(
                        post['image']), // Update the key to 'image'
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          },
          itemCount: controller.postList.length,
        ));
  }
}
