import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  static void show({
    required String title,
    required String desc,
    required VoidCallback onOk,
    VoidCallback? onCancel,
    bool isTouch = true,
  }) {
    Get.defaultDialog(
      title: title,
      backgroundColor: white,
      titleStyle: AppFonts.poppins(
          fontSize: 20, color: black, fontWeight: FontWeight.bold),
      radius: 10,
      barrierDismissible: isTouch,
      titlePadding: const EdgeInsets.only(top: 15),
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      content: Column(
        children: [
          Text(
            desc,
            textAlign: TextAlign.center,
            style: AppFonts.poppins(
                fontSize: 12, color: black, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      textStyle: AppFonts.poppins(
                          fontSize: 12,
                          color: white,
                          fontWeight: FontWeight.w500),
                    ),
                    child: Text("Batal"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onOk,
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      textStyle: AppFonts.poppins(
                          fontSize: 12,
                          color: white,
                          fontWeight: FontWeight.w500),
                    ),
                    child: Text("OK"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage:
// CustomDialog.show(
//   title: "Error!",
//   description: "Ops, sesi anda telah habis, silahkan login ulang",
//   onOk: () {
//     Get.offAll(() => LoginView());
//   },
//   onCancel: () {
//     Get.back();
//   },
// );
  // Get.dialog(
  //     AlertDialog(
  //       title: Text(
  //         title,
  //         textAlign: TextAlign.center,
  //         style: AppFonts.poppins(
  //             fontSize: 20, color: black, fontWeight: FontWeight.bold),
  //       ),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0), // Set the radius here
  //       ),
  //       contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
  //       content: Column(
  //         children: [
  //           Text(
  //             desc,
  //             textAlign: TextAlign.center,
  //             style: AppFonts.poppins(
  //                 fontSize: 12, color: black, fontWeight: FontWeight.w500),
  //           ),
  //         ],
  //       ),
  //       actions: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             ElevatedButton(
  //               onPressed: onOk,
  //               style: ElevatedButton.styleFrom(
  //                 primary: Colors.green,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 textStyle: AppFonts.poppins(
  //                     fontSize: 12, color: white, fontWeight: FontWeight.w500),
  //               ),
  //               child: Text("OK"),
  //             ),
  //             ElevatedButton(
  //               onPressed: onCancel,
  //               style: ElevatedButton.styleFrom(
  //                 primary: Colors.red,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8.0),
  //                 ),
  //                 textStyle: AppFonts.poppins(
  //                     fontSize: 12, color: white, fontWeight: FontWeight.w500),
  //               ),
  //               child: Text("Batal"),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  
