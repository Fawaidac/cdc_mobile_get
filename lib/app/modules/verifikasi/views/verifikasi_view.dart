// import 'package:cdc/app/routes/app_pages.dart';
// import 'package:cdc/app/utils/app_colors.dart';
// import 'package:cdc/app/utils/app_fonts.dart';
// import 'package:cdc/app/resource/custom_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:get/get.dart';

// import '../controllers/verifikasi_controller.dart';

// class VerifikasiView extends StatelessWidget {
//   const VerifikasiView({super.key});
//   // final controller = Get.put(VerifikasiController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//         title: Text("Verivikasi"),
//       ),
//       // appBar: AppBar(
//       //   backgroundColor: white,
//       //   shadowColor: Colors.transparent,
//       //   automaticallyImplyLeading: false,
//       //   actions: [
//       //     IconButton(
//       //       onPressed: () {
//       //         showMenu(
//       //             context: context,
//       //             position: RelativeRect.fromLTRB(
//       //                 MediaQuery.of(context).size.width - 20, 20, 0, 0),
//       //             items: [
//       //               PopupMenuItem<int>(
//       //                   value: 1,
//       //                   child: Row(
//       //                     children: [
//       //                       Icon(
//       //                         Icons.login,
//       //                         color: black,
//       //                         size: 20,
//       //                       ),
//       //                       const SizedBox(
//       //                         width: 10,
//       //                       ),
//       //                       Text(
//       //                         "Aktifasi akun",
//       //                         style:
//       //                             AppFonts.poppins(fontSize: 12, color: black),
//       //                       ),
//       //                     ],
//       //                   )),
//       //             ]).then((value) {
//       //           if (value != null) {
//       //             if (value == 1) {
//       //               Get.toNamed(Routes.AKTIFASI);
//       //             }
//       //           }
//       //         });
//       //       },
//       //       icon: Icon(
//       //         Icons.more_vert,
//       //         color: black,
//       //       ),
//       //     ),
//       //   ],
//       // ),
//       // body: Center(
//       //   child: SingleChildScrollView(
//       //     padding: const EdgeInsets.all(25),
//       //     child: Column(
//       //       crossAxisAlignment: CrossAxisAlignment.center,
//       //       children: [
//       //         Text(
//       //           "Verifikasi Alumni",
//       //           style: AppFonts.poppins(
//       //               fontSize: 24, color: black, fontWeight: FontWeight.bold),
//       //         ),
//       //         Text(
//       //           "Masukan NIM / Email anda",
//       //           style: AppFonts.poppins(fontSize: 12, color: black),
//       //         ),
//       //         const SizedBox(
//       //           height: 50,
//       //         ),
//       //         CustomTextField(
//       //             controller: controller.nimOrEmail,
//       //             label: "Nim / Email",
//       //             isEnable: true,
//       //             keyboardType: TextInputType.emailAddress,
//       //             inputFormatters:
//       //                 FilteringTextInputFormatter.singleLineFormatter,
//       //             icon: Icons.badge),
//       //         Obx(
//       //           () => Container(
//       //               margin: const EdgeInsets.fromLTRB(0, 50, 0, 45),
//       //               height: 48,
//       //               width: MediaQuery.of(context).size.width,
//       //               decoration: BoxDecoration(
//       //                   color: primaryColor,
//       //                   borderRadius: BorderRadius.circular(15)),
//       //               child: ElevatedButton(
//       //                 style: ElevatedButton.styleFrom(
//       //                     backgroundColor: Colors.transparent,
//       //                     shadowColor: Colors.transparent,
//       //                     shape: RoundedRectangleBorder(
//       //                       borderRadius: BorderRadius.circular(10),
//       //                     )),
//       //                 onPressed: () {
//       //                   controller.checkVerifikasi();
//       //                 },
//       //                 child: controller.loading.value == true
//       //                     ? Center(
//       //                         child: CircularProgressIndicator(
//       //                           color: white,
//       //                         ),
//       //                       )
//       //                     : Text('Verifikasi',
//       //                         style: AppFonts.poppins(
//       //                           fontSize: 14,
//       //                           color: white,
//       //                         )),
//       //               )),
//       //         ),
//       //         Row(
//       //           mainAxisAlignment: MainAxisAlignment.center,
//       //           children: [
//       //             Text(
//       //               "Sudah memiliki akun? ",
//       //               style: AppFonts.poppins(fontSize: 12, color: black),
//       //             ),
//       //             InkWell(
//       //               onTap: () {
//       //                 Get.toNamed(Routes.LOGIN);
//       //               },
//       //               child: Text(
//       //                 "Masuk",
//       //                 style: AppFonts.poppins(
//       //                     fontSize: 12,
//       //                     color: primaryColor,
//       //                     fontWeight: FontWeight.bold),
//       //               ),
//       //             )
//       //           ],
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

import 'package:cdc/app/modules/verifikasi/controllers/verifikasi_controller.dart';
import 'package:cdc/app/resource/custom_textfield.dart';
import 'package:cdc/app/routes/app_pages.dart';
import 'package:cdc/app/utils/app_colors.dart';
import 'package:cdc/app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class VerifikasiView extends StatelessWidget {
  VerifikasiView({super.key});
  // VerifikasiController controller = Get.put(VerifikasiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                    MediaQuery.of(context).size.width - 20, 20, 0, 0),
                items: [
                  PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.login,
                            color: black,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Aktifasi akun",
                            style: AppFonts.poppins(fontSize: 12, color: black),
                          ),
                        ],
                      )),
                ],
              ).then((value) {
                if (value != null) {
                  if (value == 1) {
                    Get.toNamed(Routes.AKTIFASI);
                  }
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
              color: black,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Verifikasi Alumni",
                style: AppFonts.poppins(
                    fontSize: 24, color: black, fontWeight: FontWeight.bold),
              ),
              Text(
                "Masukan NIM / Email anda",
                style: AppFonts.poppins(fontSize: 12, color: black),
              ),
              const SizedBox(
                height: 50,
              ),
              // CustomTextField(
              //     controller: controller.nimOrEmail,
              //     label: "Nim / Email",
              //     isEnable: true,
              //     keyboardType: TextInputType.emailAddress,
              //     inputFormatters:
              //         FilteringTextInputFormatter.singleLineFormatter,
              //     icon: Icons.badge),
              // Obx(
              //   () => Container(
              //       margin: const EdgeInsets.fromLTRB(0, 50, 0, 45),
              //       height: 48,
              //       width: MediaQuery.of(context).size.width,
              //       decoration: BoxDecoration(
              //           color: primaryColor,
              //           borderRadius: BorderRadius.circular(15)),
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.transparent,
              //             shadowColor: Colors.transparent,
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(10),
              //             )),
              //         onPressed: () {
              //           controller.checkVerifikasi();
              //         },
              //         child: controller.loading.value == true
              //             ? Center(
              //                 child: CircularProgressIndicator(
              //                   color: white,
              //                 ),
              //               )
              //             : Text('Verifikasi',
              //                 style: AppFonts.poppins(
              //                   fontSize: 14,
              //                   color: white,
              //                 )),
              //       )),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah memiliki akun? ",
                    style: AppFonts.poppins(fontSize: 12, color: black),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(
                      "Masuk",
                      style: AppFonts.poppins(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
