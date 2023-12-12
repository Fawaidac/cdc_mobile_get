import 'package:cdc/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_fonts.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  NotificationsView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.keyboard_arrow_left_rounded,
            color: black,
          ),
        ),
        title: Text(
          "Notifikasi",
          style: AppFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchNotifications();
        },
        child: FutureBuilder(
          future: controller.fetchNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (controller.notifications.isEmpty) {
              return Center(
                child: Text(
                  'Belum ada notifikasi',
                  style: AppFonts.poppins(fontSize: 12, color: black),
                ),
              );
            } else {
              return Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final data = controller.notifications[index];
                    return GestureDetector(
                      onTap: () {
                        getTypeAction(data.type);
                      },
                      child: Container(
                        // height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: primaryColor,
                              child: Center(
                                child: Icon(
                                  Icons.info_outline,
                                  color: white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(getTypeText(data.type),
                                      style: AppFonts.poppins(
                                          fontSize: 14,
                                          color: black,
                                          fontWeight: FontWeight.bold)),
                                  Text(data.message ?? "",
                                      style: AppFonts.poppins(
                                          fontSize: 12,
                                          color: black,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

String getTypeText(String? type) {
  switch (type) {
    case 'news':
      return 'Berita';
    case 'quisioner':
      return 'Kuisioner';
    case 'post':
      return 'Postingan';
    default:
      return type ?? '';
  }
}

void getTypeAction(String? type) {
  switch (type) {
    case 'news':
      Get.toNamed(Routes.ALL_BERITA);
      break;
    case 'quisioner':
      Get.toNamed(Routes.QUISIONER);
      break;
    case 'post':
      Get.back();
      break;
    default:
      Get.back();
  }
}
