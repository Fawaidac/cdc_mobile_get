import 'package:get/get.dart';

import 'package:cdc/app/modules/setting/controllers/add_education_user_controller.dart';
import 'package:cdc/app/modules/setting/controllers/add_job_user_controller.dart';
import 'package:cdc/app/modules/setting/controllers/kartu_alumni_controller.dart';
import 'package:cdc/app/modules/setting/controllers/tentang_controller.dart';

import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KartuAlumniController>(
      () => KartuAlumniController(),
    );
    Get.lazyPut<AddEducationUserController>(
      () => AddEducationUserController(),
    );
    Get.lazyPut<AddJobUserController>(
      () => AddJobUserController(),
    );
    Get.lazyPut<TentangController>(
      () => TentangController(),
    );
    Get.lazyPut<SettingController>(
      () => SettingController(),
    );
  }
}
