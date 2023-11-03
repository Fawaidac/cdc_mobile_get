import 'package:cdc/resources/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: [second, first])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/logowhite.png",
              height: 125,
            ),
            const SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(
              color: white,
            )
          ],
        ),
      ),
    );
  }
}