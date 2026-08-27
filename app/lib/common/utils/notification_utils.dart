import 'dart:async';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationUtils {
  static const String _channelId = 'ipomodoro_reminders';
  static const String _channelName = 'iPomodoro';
  static const String _channelDescription = 'Timer and pomodoro reminders';

  /// Avoid jumping to the exact-alarm settings page on every background pause.
  static bool _hasAskedExactAlarmThisSession = false;

  static Future<void> showNotification(int id, String title, String body, {int badgeNumber = 1, String payload = ""}) async {
    if (!await _hasNotificationsPermission()) {
      return;
    }

    var android = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        priority: Priority.high,
        importance: Importance.max);
    var iOS = DarwinNotificationDetails(badgeNumber: badgeNumber);
    var macOS = DarwinNotificationDetails(badgeNumber: badgeNumber);
    var platform = NotificationDetails(android: android, iOS: iOS, macOS: macOS);
    await flutterLocalNotificationsPlugin.show(id, title, body, platform, payload: payload);
  }

  static Future<void> addScheduleNotification(int id, String title, String body, int seconds) async {
    if (!await _hasNotificationsPermission()) {
      return;
    }

    final bool canExact = await _ensureExactAlarmPermission();
    final AndroidScheduleMode scheduleMode = canExact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
    final NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails(
            _channelId, _channelName,
            channelDescription: _channelDescription,
            priority: Priority.max,
            importance: Importance.max,
            fullScreenIntent: false));
    final tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds));

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id, title, body, scheduledDate, details,
          androidScheduleMode: scheduleMode);
    } catch (_) {
      if (scheduleMode == AndroidScheduleMode.exactAllowWhileIdle) {
        try {
          await flutterLocalNotificationsPlugin.zonedSchedule(
              id, title, body, scheduledDate, details,
              androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle);
        } catch (_) {
          // Never crash when the app is backgrounded.
        }
      }
    }
  }

  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future<bool> _hasNotificationsPermission() async {
    if (!Platform.isAndroid) {
      return true;
    }
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    return await androidImplementation?.areNotificationsEnabled() ?? false;
  }

  /// Returns true if exact alarms can be used.
  /// Requests the system setting at most once per process, and only after
  /// notification permission is already granted.
  static Future<bool> _ensureExactAlarmPermission() async {
    if (!Platform.isAndroid) {
      return true;
    }
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidImplementation == null) {
      return false;
    }

    final bool canSchedule =
        await androidImplementation.canScheduleExactNotifications() ?? false;
    if (canSchedule) {
      return true;
    }

    if (!_hasAskedExactAlarmThisSession) {
      _hasAskedExactAlarmThisSession = true;
      return await androidImplementation.requestExactAlarmsPermission() ?? false;
    }
    return false;
  }

  static Future<bool> checkExactAlarmPermission() async {
    if (!Platform.isAndroid) {
      return true;
    }
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    return await androidImplementation?.canScheduleExactNotifications() ?? false;
  }

  static Future<bool> isNotificationsPermission() async {
    if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      return grantedNotificationPermission ?? false;
    } else {
      return true;
    }
  }
}
