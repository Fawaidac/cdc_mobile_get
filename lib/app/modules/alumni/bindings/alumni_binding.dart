import 'package:get/get.dart';

import '../controllers/alumni_controller.dart';

class AlumniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlumniController>(
      () => AlumniController(),
    );
  }
}
