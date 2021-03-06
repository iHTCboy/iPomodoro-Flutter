import 'package:flutter/services.dart';
import 'package:iPomodoro/config/app_config.dart';

//调用原生方法
class NativeChannel {

  static Future invokeMethod(String method) async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod(method);
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future requestReview() async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('requestReview');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future gotoStoreReview() async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('gotoStoreReview');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future shareApp() async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('shareApp', {'url': AppConfig.AppAppStoreUrl, 'content': AppConfig.AppShareText});
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future emailConnect() async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('email', {'appname': AppConfig.AppName, 'email': AppConfig.kEmail});
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future moreLearn() async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('more');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future appVersion() async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('version');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future timeZone() async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('timeZone');
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future changeBadgeNumber(int badgeNumber) async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('badgeNumber', {'badgeNumber': badgeNumber});
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future idleTimerDisabled(bool idDisabled) async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('idleTimer', {'idleTimer': idDisabled});
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future changeBrightness(String brightness, {String getBrightness="0"}) async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('brightness', {'brightness': brightness, 'getBrightness': getBrightness});
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }



}
