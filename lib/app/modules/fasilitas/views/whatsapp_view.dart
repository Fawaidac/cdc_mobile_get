import 'package:card_loading/card_loading.dart';
import 'package:cdc/app/modules/fasilitas/controllers/whatsapp_controller.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class WhatsappView extends GetView<WhatsappController> {
  WhatsappView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(WhatsappController());

  Future<void> _refreshData() async {
    await controller.fetchGrupWhatsAppData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: primaryColor,
              )),
          title: Text(
            "Grup Whatsapp",
            style: AppFonts.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: RefreshIndicator(
            onRefresh: _refreshData,
            edgeOffset: 0,
            color: primaryColor,
            child: Obx(() {
              return Column(
                children: [
                  if (controller.isLoading.value) widgetIsLoading(),
                  if (controller.grupWhatsAppList.isNotEmpty)
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.grupWhatsAppList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final data = controller.grupWhatsAppList[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: LinearGradient(
                                    colors: [Color(0xff07B29D), white],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: white,
                                  child: CircleAvatar(
                                    radius: 48,
                                    backgroundImage:
                                        NetworkImage(data['image']),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, right: 5, left: 5),
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: const BoxDecoration(
                                      color: Color(0xff007E6F),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        data['name'],
                                        style: AppFonts.poppins(
                                            fontSize: 12,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  decoration: BoxDecoration(
                                      color: Color(0xff007E6F),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "Gabung",
                                      style: AppFonts.poppins(
                                          fontSize: 12,
                                          color: white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              );
            }),
          ),
        ));
  }

  GridView widgetIsLoading() {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return const CardLoading(
          height: 150,
          width: 100,
        );
      },
    );
  }
}
