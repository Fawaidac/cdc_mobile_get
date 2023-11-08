import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DetailNewsView extends GetView {
  final Map<String, dynamic> newsItem;

  const DetailNewsView({required this.newsItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dateTime = newsItem['updated_at'];
    final date = DateTime.parse(dateTime);
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final timeFormat = DateFormat('HH:mm');
    final formattedDate = dateFormat.format(date);
    final formattedTime = timeFormat.format(date);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        shadowColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            )),
        centerTitle: true,
        title: Text(
          "Berita",
          style: AppFonts.poppins(
              fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(newsItem['title'],
                  style: AppFonts.poppins(
                      fontSize: 20, color: black, fontWeight: FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(newsItem['image']),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Text(
                '$formattedDate, $formattedTime',
                style: AppFonts.poppins(fontSize: 14, color: grey),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Html(
                  data: newsItem['description'],
                  style: {"body": Style(fontSize: FontSize(16))},
                )),
          ],
        ),
      ),
    );
  }
}
