import 'package:get/get.dart';

import '../controllers/aktifasi_controller.dart';

class AktifasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AktifasiController>(
      () => AktifasiController(),
    );
  }
}
