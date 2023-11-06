import 'package:get/get.dart';

import 'package:cdc/app/modules/tab_followers/controllers/followed_controller.dart';
import 'package:cdc/app/modules/tab_followers/controllers/followers_controller.dart';

import '../controllers/tab_followers_controller.dart';

class TabFollowersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowersController>(
      () => FollowersController(),
    );
    Get.lazyPut<FollowedController>(
      () => FollowedController(),
    );
    Get.lazyPut<TabFollowersController>(
      () => TabFollowersController(),
    );
  }
}
