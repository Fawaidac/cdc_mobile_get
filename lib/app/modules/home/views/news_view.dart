import 'package:cdc/app/modules/home/controllers/news_controller.dart';
import 'package:cdc/app/modules/home/views/detail_news_view.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class NewsView extends GetView<NewsController> {
  NewsView({Key? key}) : super(key: key);

  PageController pageController = PageController();

  @override
  final controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: 175,
          child: Obx(
            () => ListView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: controller.newsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() =>
                        DetailNewsView(newsItem: controller.newsList[index]));
                  },
                  child: Container(
                    width: size.width - 20,
                    height: 175,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  controller.newsList[index]['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 175,
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                white.withOpacity(0.5),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.newsList[index]['title'],
                                style: AppFonts.poppins(
                                  fontSize: 18,
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: const Alignment(0, 0.60),
          child: SmoothPageIndicator(
            controller: pageController,
            count: controller.newsList.length,
            effect: SlideEffect(
              dotWidth: 8,
              dotHeight: 8,
              activeDotColor: primaryColor,
              dotColor: Color(0xffD1E8F7),
            ),
          ),
        ),
      ],
    );
  }
}
