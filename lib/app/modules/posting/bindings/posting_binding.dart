import 'package:get/get.dart';

import '../controllers/posting_controller.dart';

class PostingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostingController>(
      () => PostingController(),
    );
  }
}
