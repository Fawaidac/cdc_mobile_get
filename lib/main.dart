import 'package:cdc/app/modules/splash/bindings/splash_binding.dart';
import 'package:cdc/app/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
//   LocalNotificationsServices.initialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (GetPlatform.isIOS) {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  LocalNotificationsServices.initialized();
  runApp(const MyApp());
}

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  // Notifikasi diterima saat aplikasi ditutup (terminated)
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.title}");
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.body}");
  // LocalNotificationsServices.showNotificationForeground(message);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void configureFirebaseMessaging() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Notifikasi diterima saat aplikasi dibuka dari background (terminated)
        print(
            "Notifikasi diterima saat aplikasi dibuka dari background (terminated): ${message.notification?.title}");
        print(
            "Notifikasi diterima saat aplikasi dibuka dari background (terminated): ${message.notification?.body}");
        LocalNotificationsServices.showNotificationForeground(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Notifikasi diterima saat aplikasi berjalan di foreground
      print(
          "Notifikasi diterima saat aplikasi berjalan di foreground: ${message.notification?.title}");
      print(
          "Notifikasi diterima saat aplikasi berjalan di foreground: ${message.notification?.body}");
      LocalNotificationsServices.showNotificationForeground(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Notifikasi diterima saat aplikasi dibuka dari background (background running)
      print(
          "Notifikasi diterima saat aplikasi dibuka dari background (background running): ${message.notification?.title}");
      print(
          "Notifikasi diterima saat aplikasi dibuka dari background (background running): ${message.notification?.body}");
      LocalNotificationsServices.showNotificationForeground(message);
      Get.toNamed(Routes.SPLASH);
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future<void> fcm() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    // Notifikasi diterima saat aplikasi ditutup (terminated)
    print(
        "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.title}");
    print(
        "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.body}");
    LocalNotificationsServices.showNotificationForeground(message);
  }

  @override
  void initState() {
    super.initState();
    configureFirebaseMessaging();
    fcm();
    LocalNotificationsServices.initialized();
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: "CDC POLIJE",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: SplashBinding(),
      builder: EasyLoading.init(),
    );
  }
}
