import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {

  static const String K_STRING_POMODORO_HOURS = "k_string_pomodoro_hours";
  static const String K_STRING_POMODORO_MINUTES = "k_string_pomodoro_minutes";
  static const String K_STRING_POMODORO_BREAK_SHORT = "k_string_pomodoro_break_short";
  static const String K_STRING_POMODORO_BREAK_LONG = "k_string_pomodoro_break_long";
  static const String K_STRING_POMODORO_BREAK_LONG_DELAY = "k_string_pomodoro_break_long_delay";
  static const String K_STRING_TIMER_HOURS = "k_string_timer_hours";
  static const String K_STRING_TIMER_MINUTES = "k_string_timer_minutes";


  static Future<bool> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await prefs.setInt(key, value);
    return status;
  }

  static Future<bool> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await prefs.setBool(key, value);
    return status;
  }

  static Future<bool> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    bool status = await prefs.setString(key, value);
    return status;
  }

  static Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int result = prefs.getInt(key);
    return result;
  }

  static Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool result = prefs.getBool(key);
    return result;
  }

  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String result = prefs.getString(key);
    return result;
  }

}
