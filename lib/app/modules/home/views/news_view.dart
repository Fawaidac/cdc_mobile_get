import 'package:cdc/app/modules/home/controllers/news_controller.dart';
import 'package:cdc/app/modules/home/views/detail_news_view.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_loading/card_loading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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

    return FutureBuilder(
      future: controller.fetchNewsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: CardLoading(
              height: 175,
              width: size.width - 20,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (controller.newsList.isEmpty) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.FASILITAS);
              },
              child: Container(
                height: 175,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        colors: [primaryColor, first],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ayo Isi Kuisioner !",
                            style: AppFonts.poppins(
                                fontSize: 18,
                                color: white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Verifikasi akun anda dan bantu rekan alumni untuk mengetahui track record anda",
                            style: AppFonts.poppins(fontSize: 12, color: white),
                          ),
                          Image.asset(
                            "images/logowhite.png",
                            height: 40,
                          ),
                        ],
                      ),
                    )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 120,
                        child: Image.asset(
                          "images/quis.png",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return buildNewsListView(context);
        }
      },
    );
  }

  Widget buildNewsListView(BuildContext _) {
    var size = MediaQuery.of(_).size;

    return Column(
      children: [
        SizedBox(
          height: 175,
          child: ListView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: controller.newsList.length,
            itemBuilder: (context, index) {
              String dateTime = controller.newsList[index]['created_at'];
              final date = DateTime.parse(dateTime);
              initializeDateFormatting('id_ID', null);
              final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
              final timeFormat = DateFormat('HH:mm');
              final formattedDate = dateFormat.format(date);
              final formattedTime = timeFormat.format(date);
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
                          borderRadius: BorderRadius.circular(10),
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Colors.transparent,
                          //     white.withOpacity(0.5),
                          //   ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // ),
                          color: black.withOpacity(0.2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.newsList[index]['title'],
                                    style: AppFonts.poppins(
                                      fontSize: 16,
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '$formattedDate',
                                    style: AppFonts.poppins(
                                      fontSize: 12,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index == controller.newsList.length - 1)
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.ALL_BERITA);
                                },
                                child: Text(
                                  'Lihat Semua',
                                  style: AppFonts.poppins(
                                    fontSize: 12,
                                    color: white,
                                    fontWeight: FontWeight.w500,
                                  ),
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
