import 'package:get/get.dart';

import '../controllers/recovery_password_controller.dart';

class RecoveryPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecoveryPasswordController>(
      () => RecoveryPasswordController(),
    );
  }
}
