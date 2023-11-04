import 'package:get/get.dart';

import '../controllers/fasilitas_controller.dart';

class FasilitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FasilitasController>(
      () => FasilitasController(),
    );
  }
}
