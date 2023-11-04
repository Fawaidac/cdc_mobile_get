import 'package:get/get.dart';

import '../controllers/ikapj_controller.dart';

class IkapjBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IkapjController>(
      () => IkapjController(),
    );
  }
}
