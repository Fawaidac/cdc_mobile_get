import 'package:cdc/app/data/models/post_model.dart';
import 'package:cdc/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PostItemController extends GetxController {
  Future<void> fetchData() async {
    try {
      final data = await Get.find<HomeController>()
          .getData(Get.find<HomeController>().page);
      // ignore: unnecessary_type_check
      if (data is Map<String, dynamic>) {
        if (data.containsKey('total_page')) {
          Get.find<HomeController>().totalPage = data['total_page'];
        }
        final List<PostAllModel> newPosts =
            data.keys.where((key) => int.tryParse(key) != null).map((key) {
          return PostAllModel.fromJson(data[key]);
        }).toList();
        if (Get.find<HomeController>().page >
            Get.find<HomeController>().lastLoadedPage) {
          Get.find<HomeController>().postList.addAll(newPosts);
          Get.find<HomeController>().lastLoadedPage =
              Get.find<HomeController>().page;
        }
      } else {
        print("Response data is not in the expected format.");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      Get.snackbar("Error", "Tidak bisa mengunjungi situs",
          margin: const EdgeInsets.all(10));
    }
  }
}
