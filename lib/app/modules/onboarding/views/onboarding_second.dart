import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class OnBoardingSecond extends StatelessWidget {
  const OnBoardingSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200, child: Image.asset("images/onboarding2.png")),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Mudah, dan Multi Fungsi",
            style: AppFonts.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Aplikasi ini juga memuat informasi dari alumni, postingan, dan fitur IKAPJ yang dapat diakses dengan mudah",
              textAlign: TextAlign.center,
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
          )
        ],
      ),
    ));
  }
}
