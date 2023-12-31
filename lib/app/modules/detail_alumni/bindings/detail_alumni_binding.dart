import 'package:get/get.dart';

import 'package:cdc/app/modules/detail_alumni/controllers/education_controller.dart';
import 'package:cdc/app/modules/detail_alumni/controllers/job_controller.dart';
import 'package:cdc/app/modules/detail_alumni/controllers/post_controller.dart';

import '../controllers/detail_alumni_controller.dart';

class DetailAlumniBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EducationController>(
      () => EducationController(),
    );
    Get.lazyPut<JobController>(
      () => JobController(),
    );
    Get.lazyPut<PostController>(
      () => PostController(),
    );
    Get.lazyPut<DetailAlumniController>(
      () => DetailAlumniController(),
    );
  }
}
