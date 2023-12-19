import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../../home/views/detail_news_view.dart';
import '../controllers/all_berita_controller.dart';

class AllBeritaView extends GetView<AllBeritaController> {
  AllBeritaView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(AllBeritaController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: black,
            ),
          ),
          title: Text(
            "Semua Berita",
            style: AppFonts.poppins(
                fontSize: 16, color: black, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: controller.fetchNewsData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadNewsList(context);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if (controller.newsList.isEmpty) {
                return const SizedBox();
              }
              return buildNewsListView(context);
            }
          },
        ));
  }

  Widget buildNewsListView(BuildContext _) {
    var size = MediaQuery.of(_).size;

    return Obx(() => ListView.builder(
          controller: controller.scrollController,
          scrollDirection: Axis.vertical,
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
                Get.to(
                    () => DetailNewsView(newsItem: controller.newsList[index]));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: size.width,
                    height: 175,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:
                            NetworkImage(controller.newsList[index]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          controller.newsList[index]['title'],
                          style: AppFonts.poppins(
                            fontSize: 14,
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          '$formattedDate',
                          style: AppFonts.poppins(
                            fontSize: 12,
                            color: black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget loadNewsList(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
          child: Column(
            children: [
              CardLoading(
                height: 175,
                width: size.width,
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(
                height: 10,
              ),
              CardLoading(
                height: 10,
                width: size.width - 20,
              )
            ],
          ),
        );
      },
    );
  }

}
