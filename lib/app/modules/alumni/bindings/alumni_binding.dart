import 'package:get/get.dart';

import 'package:cdc/app/modules/alumni/controllers/alumni_all_controller.dart';

import '../controllers/alumni_controller.dart';

class AlumniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlumniAllController>(
      () => AlumniAllController(),
    );
    Get.lazyPut<AlumniController>(
      () => AlumniController(),
    );
  }
}
