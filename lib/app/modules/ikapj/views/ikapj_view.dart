import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/ikapj_controller.dart';

class IkapjView extends GetView<IkapjController> {
  IkapjView({Key? key}) : super(key: key);
  final controller = Get.put(IkapjController());
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        SizedBox(child: WebViewWidget(controller: controller.controllerWeb)));
  }
}
