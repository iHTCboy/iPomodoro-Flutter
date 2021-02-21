
enum TimerStateMode {
  start,
  timing,
  pause,
  stop,
}

enum PomodoroMode {
  stop,
  timing,
  breaktime,
}

class TimeUtils {
  static List calculateDate(int secoonds) {
    int hours = 0;
    int seconds = secoonds % 60;
    int minutes = (secoonds / 60).floor();
    if (minutes >= 60) {
      hours = (minutes / 60).floor();
      minutes = minutes % 60;
    }
    List time = [
      hours,
      minutes > 9 ? minutes.toString() : '0$minutes',
      seconds > 9 ? seconds.toString() : '0$seconds'
    ];
    return time;
  }

  static String get_formatted_date(DateTime date) {
    String formattedDate =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  static int get_difference_day(DateTime date) {
    //当前日期
    final now = DateTime.now();
    //比较相差的天数
    final difference = date.difference(now).inDays;
    return difference;
  }
}