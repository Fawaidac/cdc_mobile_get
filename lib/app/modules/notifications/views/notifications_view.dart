import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  NotificationsView({Key? key}) : super(key: key);

  @override
  final controller = Get.put(NotificationsController());

  Future<void> _refreshData() async {
    await controller.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchNotifications();
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          backgroundColor: white,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: primaryColor,
            ),
          ),
          title: Text(
            "Notifikasi",
            style: AppFonts.poppins(
                fontSize: 16, color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: white,
            child: Obx(() => controller.notifications.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada notifikasi',
                      style: AppFonts.poppins(fontSize: 12, color: black),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final data = controller.notifications[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: primaryColor,
                                child: Center(
                                    child: Icon(
                                  Icons.info_outline,
                                  color: white,
                                )),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.type ?? "",
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
                            ],
                          ),
                        ),
                      );
                    },
                  )),
          ),
        ));
  }
}
