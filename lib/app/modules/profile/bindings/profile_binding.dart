import 'package:get/get.dart';

import 'package:cdc/app/modules/profile/controllers/edit_education_user_controller.dart';
import 'package:cdc/app/modules/profile/controllers/edit_job_user_controller.dart';
import 'package:cdc/app/modules/profile/controllers/education_user_controller.dart';
import 'package:cdc/app/modules/profile/controllers/job_user_controller.dart';
import 'package:cdc/app/modules/profile/controllers/post_user_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditJobUserController>(
      () => EditJobUserController(),
    );
    Get.lazyPut<EditEducationUserController>(
      () => EditEducationUserController(),
    );
    Get.lazyPut<EducationUserController>(
      () => EducationUserController(),
    );
    Get.lazyPut<JobUserController>(
      () => JobUserController(),
    );
    Get.lazyPut<PostUserController>(
      () => PostUserController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
