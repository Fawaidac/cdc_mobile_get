import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class OnBoardingThrid extends StatelessWidget {
  const OnBoardingThrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 200, child: Image.asset("images/onboarding3.png")),
          const SizedBox(
            height: 50,
          ),
          Text(
            "Eksplorasi",
            style: AppFonts.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Temukan rekan alumni dan jelajahi aplikasi sesuai dengan keinginan anda, share pengalaman, pendidikan, hingga pekerjaan anda terkini.",
              textAlign: TextAlign.center,
              style: AppFonts.poppins(fontSize: 12, color: black),
            ),
          )
        ],
      ),
    ));
  }
}
