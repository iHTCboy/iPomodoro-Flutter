import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {

  static const String K_STRING_POMODORO_HOURS = "k_string_pomodoro_hours";
  static const String K_STRING_POMODORO_MINUTES = "k_string_pomodoro_minutes";
  static const String K_STRING_POMODORO_BREAK_SHORT = "k_string_pomodoro_break_short";
  static const String K_STRING_POMODORO_BREAK_LONG = "k_string_pomodoro_break_long";
  static const String K_STRING_POMODORO_BREAK_LONG_DELAY = "k_string_pomodoro_break_long_delay";
  static const String K_STRING_POMODORO_NOTIFICATION = "k_string_pomodoro_notification";
  static const String K_STRING_POMODORO_TICKING_SOUND = "k_string_pomodoro_tick_sound";
  static const String K_STRING_POMODORO_ALARM_SOUND = "k_string_pomodoro_alarm_sound";
  static const String K_STRING_POMODORO_TITLE_BAR_COLOR = "k_string_pomodoro_title_bar_color";
  static const String K_STRING_POMODORO_BACKGROUND_COLOR = "k_string_pomodoro_background_color";
  static const String K_STRING_TIMER_HOURS = "k_string_timer_hours";
  static const String K_STRING_TIMER_MINUTES = "k_string_timer_minutes";
  static const String K_STRING_TIMER_NOTIFICATION = "k_string_timer_notification";
  static const String K_STRING_TIMER_TICKING_SOUND = "k_string_timer_tick_sound";
  static const String K_STRING_TIMER_ALARM_SOUND = "k_string_timer_alarm_sound";
  static const String K_STRING_TIMER_TITLE_BAR_COLOR = "k_string_timer_title_bar_color";
  static const String K_STRING_TIMER_BACKGROUND_COLOR = "k_string_timer_background_color";
  static const String K_STRING_COUNTDOWN_ORDER_INDEX = "k_string_countdown_order_idex";
  static const String K_STRING_COUNTDOWN_TITLE_BAR_COLOR = "k_string_countdown_title_bar_color";
  static const String K_STRING_COUNTDOWN_BACKGROUND_COLOR = "k_string_countdown_background_color";
  static const String K_STRING_LANGUAGE_SETTINGS = "k_string_language_settings";
  static const String K_STRING_PRIVACY_SHOW_TIPS = "k_string_privacy_show_tips";


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

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    int? result = prefs.getInt(key);
    return result;
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool? result = prefs.getBool(key);
    return result;
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString(key);
    return result;
  }

}
