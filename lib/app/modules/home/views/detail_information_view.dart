import 'package:cdc/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_fonts.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailInformationView extends GetView {
  final Map<String, dynamic> informationItem;

  const DetailInformationView({required this.informationItem, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String dateTime = informationItem['created_at'];
    final date = DateTime.parse(dateTime);
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final formattedDate = dateFormat.format(date);
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
              color: black,
            )),
        title: Text(
          "Informasi",
          style: AppFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(informationItem['title'],
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
                      image: NetworkImage(informationItem['poster']),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
              child: Text(
                formattedDate,
                style: AppFonts.poppins(fontSize: 14, color: grey),
              ), 
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Html(
                  data: informationItem['description'],
                  style: {"body": Style(fontSize: FontSize(16))},
                )),
          ],
        ),
      ),
    );
  }
}
