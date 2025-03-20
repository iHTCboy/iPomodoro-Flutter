import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationUtils {
  static showNotification(int id, String title, String body, {int badgeNumber=1, String payload=""}) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = DarwinNotificationDetails(badgeNumber: badgeNumber);
    var macOS = DarwinNotificationDetails(badgeNumber: badgeNumber);
    var platform = NotificationDetails(android: android, iOS: iOS, macOS: macOS);
    await flutterLocalNotificationsPlugin.show(id, title, body, platform, payload: payload);
    // await flutterLocalNotificationsPlugin.show(
    //     0, 'plain title', 'plain body', platform,
    //     payload: 'item x');
  }

  static Future<void> addScheduleNotification(int id, String title, String body, int seconds) async {
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //     id,
    //     title,
    //     body,
    //     tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
    //     const NotificationDetails(
    //         android: AndroidNotificationDetails('your channel id', 'your channel name')),
    //     androidAllowWhileIdle: true,
    //     uiLocalNotificationDateInterpretation:
    //     UILocalNotificationDateInterpretation.absoluteTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'full screen channel id', 'full screen channel name',
                channelDescription: 'full screen channel description',
                priority: Priority.max,
                importance: Importance.max,
                fullScreenIntent: false)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }


  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
