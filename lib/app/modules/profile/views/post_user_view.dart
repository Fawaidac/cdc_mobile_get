import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/profile/controllers/post_user_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../home/views/detail_post_item_view.dart';

// ignore: must_be_immutable
class PostUserView extends GetView<PostUserController> {
  String name;
  String image;

  PostUserView({required this.image, required this.name, Key? key})
      : super(key: key);
  @override
  final controller = Get.put(PostUserController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadPost();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (controller.postList.isEmpty) {
            return const SizedBox();
          }
          return buildPost();
        }
      },
    );
  }

  Widget loadPost() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        crossAxisCount: 3,
        mainAxisSpacing: 5,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return CardLoading(
          height: 50,
          borderRadius: BorderRadius.circular(8),
        );
      },
    );
  }

  Widget buildPost() {
    return Obx(() => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            crossAxisCount: 3,
            mainAxisSpacing: 5,
          ),
          shrinkWrap: true,
          controller: controller.scrollController,
          itemBuilder: (context, index) {
            if (index < controller.postList.length) {
              final post = controller.postList[index];

              return InkWell(
                onTap: () {
                  Get.to(() => DetailPostItemView(
                        id: post.id,
                        isUser: true,
                        isPostUser: false,
                      ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: post.image,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
          itemCount: controller.postList.length,
        ));
  }
}
