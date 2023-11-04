import 'dart:async';

import 'package:cdc/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      checkLogin();
    });
  }

  void checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var tokenExpirationTime = preferences.getInt('tokenExpirationTime');

    if (token != null && tokenExpirationTime != null) {
      DateTime expirationDateTime =
          DateTime.fromMillisecondsSinceEpoch(tokenExpirationTime);
      DateTime currentDateTime = DateTime.now();

      if (currentDateTime.isBefore(expirationDateTime)) {
        Get.offAllNamed(Routes.HOMEPAGE);
      } else {
        preferences.remove('token');
        preferences.remove('tokenExpirationTime');
        Get.offAllNamed(Routes.ONBOARDING);
      }
    } else {
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }
}
