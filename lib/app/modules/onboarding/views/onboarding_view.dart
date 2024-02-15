import 'package:cdc/app/modules/onboarding/views/onboarding_first.dart';
import 'package:cdc/app/modules/onboarding/views/onboarding_second.dart';
import 'package:cdc/app/modules/onboarding/views/onboarding_thrid.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  OnboardingView({Key? key}) : super(key: key);
  final PageController _controller = PageController();

  @override
  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              controller.onLastPage.value = (value == 2);
            },
            children: const [
              OnBoardingFirst(),
              OnBoardingSecond(),
              OnBoardingThrid(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.60),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: SlideEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: primaryColor,
              ),
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.85),
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Obx(() {
              if (controller.onLastPage.value) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70),
                      child: GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setBool('onBoarding', true);
                          Get.offNamed(Routes.LOGIN);
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Get Started",
                                style: AppFonts.poppins(
                                  fontSize: 14,
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                Icons.login_rounded,
                                color: white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Skip",
                              style: AppFonts.poppins(
                                fontSize: 14,
                                color: black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Next",
                              style: AppFonts.poppins(
                                fontSize: 14,
                                color: white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
