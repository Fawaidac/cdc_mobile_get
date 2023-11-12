import 'package:cdc/app/modules/splash/bindings/splash_binding.dart';
import 'package:cdc/app/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  // Notifikasi diterima saat aplikasi ditutup (terminated)
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.title}");
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.body}");
  LocalNotificationsServices.showNotificationForeground(message);
}

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  LocalNotificationsServices.initialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
    return GetMaterialApp(
      title: "Carrear Development Center",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: SplashBinding(),
      builder: EasyLoading.init(),
    );
  }
}
