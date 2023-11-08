import 'package:get/get.dart';

import 'package:cdc/app/modules/tab_followers_user/controllers/followed_user_controller.dart';
import 'package:cdc/app/modules/tab_followers_user/controllers/followers_user_controller.dart';

import '../controllers/tab_followers_user_controller.dart';

class TabFollowersUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowedUserController>(
      () => FollowedUserController(),
    );
    Get.lazyPut<FollowersUserController>(
      () => FollowersUserController(),
    );
    Get.lazyPut<TabFollowersUserController>(
      () => TabFollowersUserController(),
    );
  }
}
