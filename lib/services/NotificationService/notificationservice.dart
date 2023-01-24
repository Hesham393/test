import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;

// all set up
//https://www.freecodecamp.org/news/local-notifications-in-flutter/
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings settings;

  static Future<void> initialize1(
      void Function(NotificationResponse response)
          onDidReceiveNotificationResponse) async {
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    await _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    tzData.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Asia/Baghdad'));
  }

  static Future<void> initialize(
      void Function(NotificationResponse response)
          onDidReceiveNotificationResponse) async {
    tzData.initializeTimeZones();
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosinitializationSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const settings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosinitializationSettings);

    _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static Future<void> displayNotification(String title, String body) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final notificationDetails = await _notificationDetails();

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<void> displayNotificationWithPayload(
      String title, String body, String payload) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final notificationDetails = await _notificationDetails();

      await _notificationsPlugin.show(id, title, body, notificationDetails,
          payload: payload);
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<void> displayZonedNotification(
      String title, String body, int seconds) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final notificationDetails = await _notificationDetails();
      // final timezone =
      //     tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, seconds);
      final timezone =
          tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));
      await _notificationsPlugin.zonedSchedule(
          id, title, body, timezone, notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);
    } on Exception catch (e) {
      print(e);
    }
  }

  static Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("id_adhan", "adhan",
            channelDescription: "description",
            playSound: true,
            priority: Priority.max,
            importance: Importance.max);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  static void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    print(id);
  }
}


// Future<void> showNotification(int id, String title, String body) async {
//   final details = await _notificationDetails();
//   await _notificationsPlugin.show(id, title, body, details);
// }
