import 'package:cdc/app/modules/quisioner/controllers/paket_questioner_controller.dart';
import 'package:get/get.dart';

class PaketQuesionerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaketQuesionerController>(
      () => PaketQuesionerController(),
    );
  }
}
