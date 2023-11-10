import 'package:get/get.dart';

import 'package:cdc/app/modules/quisioner/controllers/identitas_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/kompetensi_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/main_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/study_section_controller.dart';

import '../controllers/quisioner_controller.dart';

class QuisionerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KompetensiSectionController>(
      () => KompetensiSectionController(),
    );
    Get.lazyPut<StudySectionController>(
      () => StudySectionController(),
    );
    Get.lazyPut<MainSectionController>(
      () => MainSectionController(),
    );
    Get.lazyPut<IdentitasSectionController>(
      () => IdentitasSectionController(),
    );
    Get.lazyPut<QuisionerController>(
      () => QuisionerController(),
    );
  }
}
