import 'package:get/get.dart';

class TabFollowersUserController extends GetxController {
  RxString name = RxString("");
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    name.value = Get.arguments;
  }
}
