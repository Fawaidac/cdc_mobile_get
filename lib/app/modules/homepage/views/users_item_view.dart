import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UsersItemView extends GetView {
  const UsersItemView(this.user, {super.key});
  final user;
  @override
  Widget build(BuildContext context) {
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
              radius: 20,
              backgroundImage: NetworkImage(user['foto']),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['fullname'],
                    style: AppFonts.poppins(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.bold)),
                Text(user['gender'],
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
  }
}
