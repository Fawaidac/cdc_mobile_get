import 'package:cdc/app/modules/fasilitas/controllers/tracer_study_controller.dart';
import 'package:get/get.dart';

class TracerStudyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TracerStudyContoller>(() => TracerStudyContoller());
  }
}
