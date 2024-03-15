import 'package:cdc/app/modules/quisioner/controllers/paket_questioner_controller.dart';
import 'package:get/get.dart';

import 'package:cdc/app/modules/quisioner/controllers/company_apply_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/find_job_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/identitas_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/job_street_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/job_suitability_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/kompetensi_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/main_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/study_method_section_controller.dart';
import 'package:cdc/app/modules/quisioner/controllers/study_section_controller.dart';

import '../controllers/quisioner_controller.dart';

class QuisionerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobSuitabilitySectionController>(
      () => JobSuitabilitySectionController(),
    );
    Get.lazyPut<CompanyApplySectionController>(
      () => CompanyApplySectionController(),
    );
    Get.lazyPut<FindJobSectionController>(
      () => FindJobSectionController(),
    );
    Get.lazyPut<JobStreetSectionController>(
      () => JobStreetSectionController(),
    );
    Get.lazyPut<StudyMethodSectionController>(
      () => StudyMethodSectionController(),
    );
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
    Get.lazyPut<PaketQuesionerController>(
      () => PaketQuesionerController(),
    );
  }
}
