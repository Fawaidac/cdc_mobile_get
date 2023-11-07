import 'package:get/get.dart';

import 'package:cdc/app/modules/quisioner/controllers/identitas_section_controller.dart';

import '../controllers/quisioner_controller.dart';

class QuisionerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdentitasSectionController>(
      () => IdentitasSectionController(),
    );
    Get.lazyPut<QuisionerController>(
      () => QuisionerController(),
    );
  }
}
