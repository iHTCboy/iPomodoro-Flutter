import 'package:flutter/services.dart';


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

  static Future shareApp(String url, String content) async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('shareApp', {'url': url, 'content': content});
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future emailConnect(String appname, String email) async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('email', {'appname': appname, 'email': email});
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

  static Future openPrivacyView(String languageCode) async {
    const platform = const MethodChannel('iPomodoro');
    var result;
    try {
      result = await platform.invokeMethod('privacy_policy', {'languageCode': languageCode});
      return Future.value(result);
    } on PlatformException catch (e) {
      return Future.error(e.toString());
    }
  }

}
