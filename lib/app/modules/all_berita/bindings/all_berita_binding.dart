import 'package:get/get.dart';

import '../controllers/all_berita_controller.dart';

class AllBeritaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllBeritaController>(
      () => AllBeritaController(),
    );
  }
}
