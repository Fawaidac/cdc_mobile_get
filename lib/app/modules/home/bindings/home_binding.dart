import 'package:get/get.dart';

import 'package:cdc/app/modules/home/controllers/detail_post_controller.dart';
import 'package:cdc/app/modules/home/controllers/news_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(
      () => NewsController(),
    );
    Get.lazyPut<DetailPostController>(
      () => DetailPostController(),
    );
    Get.put(HomeController());
  }
}
