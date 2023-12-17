import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsServices {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialized() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/icon"));
    notificationsPlugin.initialize(initializationSettings);
  }

  static void showNotificationForeground(RemoteMessage message) {
    final notificationsDetail = NotificationDetails(
        android: AndroidNotificationDetails("com.jtinova.cdc", "CDC POLIJE",
            importance: Importance.max, priority: Priority.high));
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    notificationsPlugin.show(notificationId, message.notification!.title,
        message.notification!.body, notificationsDetail);
  }
}
