import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/detail_alumni/controllers/post_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../home/views/detail_post_item_view.dart';

// ignore: must_be_immutable
// class PostView extends GetView<PostController> {
//   var idUser;
//   PostView({this.idUser, Key? key}) : super(key: key);

//   @override
//   final controller = Get.put(PostController());

//   @override
//   Widget build(BuildContext context) {
//     controller.scrollController.addListener(() {
//       controller.scrollListener(idUser);
//     });
//     return Obx(() => GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio: 1,
//             crossAxisSpacing: 10,
//             crossAxisCount: 3,
//             mainAxisSpacing: 10,
//           ),
//           shrinkWrap: true,
//           controller: controller.scrollController,
//           itemBuilder: (context, index) {
//             if (index < controller.postList.length) {
//               final post = controller.postList[index];
//               return Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   image: DecorationImage(
//                     image: NetworkImage(post['image']),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               );
//             }
//             return const SizedBox();
//           },
//           itemCount: controller.postList.length,
//         ));
//   }
// }

class PostView extends StatefulWidget {
  var idUser;

  PostView({required this.idUser, super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  final ScrollController scrollController = ScrollController();

  final controller = Get.put(PostController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('call');
      if (controller.currentPage.value < controller.totalPage.value) {
        controller.currentPage.value = controller.currentPage.value + 1;
        controller.fetchData(widget.idUser);
      }
    } else {
      print('dont call');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.fetchData(widget.idUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadPost();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              crossAxisCount: 3,
              mainAxisSpacing: 5,
            ),
            shrinkWrap: true,
            controller: controller.scrollController,
            itemBuilder: (context, index) {
              final post = controller.postList[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => DetailPostItemView(
                        id: post['id'],
                        isUser: false,
                        isPostUser: true,
                        idUser: widget.idUser,
                      ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: NetworkImage(post['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            itemCount: controller.postList.length,
          );
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
          borderRadius: BorderRadius.circular(5),
        );
      },
    );
  }
}
