import 'package:cdc/app/modules/tab_followers_user/controllers/followed_user_controller.dart';
import 'package:cdc/app/modules/tab_followers_user/controllers/followers_user_controller.dart';
import 'package:get/get.dart';

class TabFollowersUserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Get.find<FollowersUserController>().fetchDataFollowers();
    // Get.find<FollowedUserController>().fetchDataFollowed();
  }
}
