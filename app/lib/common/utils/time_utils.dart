
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
}