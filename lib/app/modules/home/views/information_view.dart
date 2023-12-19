import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/home/controllers/information_controller.dart';
import 'package:cdc/app/modules/home/views/detail_information_view.dart';
import 'package:cdc/app/services/api_services.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  final controller = Get.put(InformationController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: controller.fetchInformationsData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (controller.informationList.isEmpty) {
            return Center(
                child: Text(
              "Belum ada Informasi",
              style: AppFonts.poppins(fontSize: 12, color: black),
            ));
          }
          return Obx(() => ListView.builder(
                shrinkWrap: false,
                scrollDirection: Axis.vertical,
                itemCount: controller.informationList.length,
                itemBuilder: (context, index) {
                  String dateTime =
                      controller.informationList[index]['created_at'];
                  final date = DateTime.parse(dateTime);
                  initializeDateFormatting('id_ID', null);
                  final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
                  final formattedDate = dateFormat.format(date);
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => DetailInformationView(
                          informationItem: controller.informationList[index]));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 15),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(controller
                                                .informationList[index]['mitra']
                                            ['logo'] ==
                                        ApiServices.baseUrlImage
                                    ? "https://th.bing.com/th/id/OIP.dcLFW3GT9AKU4wXacZ_iYAHaGe?pid=ImgDet&rs=1"
                                    : controller.informationList[index]['mitra']
                                        ['logo']),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.informationList[index]['mitra']
                                        ['name'],
                                    style: AppFonts.poppins(
                                        fontSize: 12,
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    controller.informationList[index]['mitra']
                                        ['address'],
                                    style: AppFonts.poppins(
                                        fontSize: 12, color: black),
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: 300,
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  controller.informationList[index]['poster']),
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
                                controller.informationList[index]['title'],
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
                                formattedDate,
                                style: AppFonts.poppins(
                                  fontSize: 12,
                                  color: black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ));
        }
      },
    );
  }
}
