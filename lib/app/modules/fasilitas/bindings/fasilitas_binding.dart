import 'package:get/get.dart';

import 'package:cdc/app/modules/fasilitas/controllers/whatsapp_controller.dart';

import '../controllers/fasilitas_controller.dart';

class FasilitasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhatsappController>(
      () => WhatsappController(),
    );
    Get.lazyPut<FasilitasController>(
      () => FasilitasController(),
    );
  }
}
