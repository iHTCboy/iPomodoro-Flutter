import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/ui/widget/custom_picker.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';
import 'package:iPomodoro/common/utils/audio_utils.dart';
import 'package:flutter/services.dart';

class PomodoroSettingsPage extends StatefulWidget {
  @override
  _PomodoroSettingsPageState createState() => _PomodoroSettingsPageState();
}

class _PomodoroSettingsPageState extends State<PomodoroSettingsPage> {
  int _pomodoro_hours = 0;
  int _pomodoro_minutes = 0;
  int _break_short = 0;
  int _break_long = 0;
  int _break_long_delay = 0;
  int _setting_notification = 0;
  String _ticking_sound = "Ticking";
  String _alarm_sound = "Cowbell";

  @override
  void initState() {
    super.initState();

    _init_storage();
  }

  void _init_storage() {
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_HOURS).then((value) {
      _pomodoro_hours = value ?? 0;
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_MINUTES).then((value) {
      _pomodoro_minutes = value ?? 25;
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_BREAK_SHORT).then((value) {
      _break_short = value ?? 5;
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_BREAK_LONG).then((value) {
      _break_long = value ?? 15;
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_NOTIFICATION).then((value) {
      _setting_notification = value ?? 0;
    });
    AppStorage.getString(AppStorage.K_STRING_POMODORO_TICKING_SOUND).then((value) {
      _ticking_sound = value ?? "Ticking";
    });
    AppStorage.getString(AppStorage.K_STRING_POMODORO_ALARM_SOUND).then((value) {
      _alarm_sound = value ?? 'Cowbell';
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_BREAK_LONG_DELAY)
        .then((value) {
      setState(() {
        _break_long_delay = value ?? 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).pomodoro_settings),
        backgroundColor: AppColors.PRIMARY_MAIN_COLOR, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              '🍅',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).pomodoro_duration,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 120, 120, 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pomodoro_hours == 0 ? S.of(context).pomodoro_minutes('${_pomodoro_minutes}') : S.of(context).pomodoro_hours_minutes('${_pomodoro_hours}', '${_pomodoro_minutes}'),
                        style: TextStyle(
                            color: AppColors.PRIMARY_SUB_COLOR,
                            fontSize:
                                DeviceUtils.get_size(context, 14, 15, 18))),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_pomodoro_item,
          ),
          Divider(height: 1),
          ListTile(
            leading: Text(
              '🍌',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).pomodoro_short_break_duration,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 100, 100, 150),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).pomodoro_minutes('${_break_short}'),
                        style: TextStyle(
                            color: AppColors.TIMER_MAIN_COLOR,
                            fontSize:
                                DeviceUtils.get_size(context, 14, 15, 18))),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_short_break_item,
          ),
          Divider(height: 1),
          ListTile(
            leading: Text(
              '☕️',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).pomodoro_long_break_duration,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 100, 100, 150),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).pomodoro_minutes('${_break_long}'),
                        style: TextStyle(
                            color: AppColors.TIMER_MAIN_COLOR,
                            fontSize:
                                DeviceUtils.get_size(context, 14, 15, 18))),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_long_break_item,
          ),
          Divider(height: 1),
          ListTile(
            leading: Text(
              '⏱',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).pomodoro_logn_break_delay,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 130, 140, 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(S.of(context).pomodoro_times('${_break_long_delay}'),
                        style: TextStyle(
                            color: AppColors.TIMER_MAIN_COLOR,
                            fontSize:
                                DeviceUtils.get_size(context, 14, 15, 18))),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_long_break_delay_item,
          ),
          Divider(height: 1),
          ListTile(
            leading: Text(
              '📢',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).background_push_tips,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 120, 120, 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_setting_notification == 0 ? S.of(context).switch_on : S.of(context).switch_off,
                        style: TextStyle(
                            color: AppColors.TIMER_MAIN_COLOR,
                            fontSize:
                            DeviceUtils.get_size(context, 14, 15, 18))),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_setting_notification_item,
          ),
          Divider(height: 1),
          ListTile(
            leading: Text(
              '🎏',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).play_clock_ticking_sound,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 120, 120, 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${_ticking_sound}",
                        style: TextStyle(
                            color: AppColors.TIMER_MAIN_COLOR,
                            fontSize: DeviceUtils.get_size(context, 14, 15, 18))),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_play_clock_ticking_sound,
          ),
          Divider(height: 1),
          ListTile(
            leading: Text(
              '🔔',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).alarm_sound,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 120, 120, 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${_alarm_sound}",
                        style: TextStyle(
                            color: AppColors.TIMER_MAIN_COLOR,
                            fontSize:
                            DeviceUtils.get_size(context, 14, 15, 18))),
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_alarm_sound,
          ),
          Divider(height: 1),
        ],
      ),
    );
  }

  void _pressed_pomodoro_item() {
    TimerPicker().show(context, _pomodoro_hours, _pomodoro_minutes, (duration) {
      _change_pomodoro_time(duration, false);
    }).then((durationTime) {
      _change_pomodoro_time(durationTime, true);
        });
  }

  void _change_pomodoro_time(Duration duration, bool isSave) {
    int minutes = duration.inMinutes;
    if (minutes >= 60) {
      minutes = minutes % 60;
    }

    setState(() {
      _pomodoro_hours = duration.inHours;
      _pomodoro_minutes = minutes;
    });

    if (isSave) {
      AppStorage.setInt(AppStorage.K_STRING_POMODORO_HOURS, duration.inHours);
      AppStorage.setInt(AppStorage.K_STRING_POMODORO_MINUTES, minutes);
    }
  }

  void _pressed_short_break_item() {
    CustomPicker().show(context, List.generate(20, (index) => '${index+1}'), _break_short -1, (position) {
      setState(() {
        _break_short = position + 1;
      });
    }).then((value) {
      setState(() {
        _break_short = value + 1;
      });
      AppStorage.setInt(AppStorage.K_STRING_POMODORO_BREAK_SHORT, value + 1);
    });
  }

  void _pressed_long_break_item() {
    CustomPicker().show(context, List.generate(31, (index) => '${index+15}'), _break_long -15, (position) {
      setState(() {
        _break_long = position + 15;
      });
    }).then((value) {
      setState(() {
        _break_long = value + 15;
      });
      AppStorage.setInt(AppStorage.K_STRING_POMODORO_BREAK_LONG, value + 15);
    });
  }

  void _pressed_long_break_delay_item() {
    CustomPicker().show(context, List.generate(10, (index) => '${index+1}'), _break_long_delay -1, (position) {
      setState(() {
        _break_long_delay = position + 1;
      });
    }).then((value) {
      print(value);
      setState(() {
        _break_long_delay = value + 1;
      });
      AppStorage.setInt(AppStorage.K_STRING_POMODORO_BREAK_LONG_DELAY, value + 1);
    });
  }

  void _pressed_setting_notification_item() {
    CustomPicker().show(context, [S.of(context).switch_on, S.of(context).switch_off], _setting_notification, (position) {
      setState(() {
        _setting_notification = position;
      });
    }, looping: false).then((value) {
      print(value);
      setState(() {
        _setting_notification = value;
      });
      AppStorage.setInt(AppStorage.K_STRING_POMODORO_NOTIFICATION, value);
    });
  }

  void _pressed_play_clock_ticking_sound() {
    final List<String> sounds = ['None', 'Birds', 'Campfire', 'RiverStream', 'SeaWaves', 'SummerNight', 'Thunderstorm', 'Ticking', 'WhiteNoise'];
    CustomPicker().show(context, sounds, sounds.indexOf(_ticking_sound), (position) {
      var sound = sounds[position];
      setState(() {
        _ticking_sound = sound;
      });
      if (sound != "None") {
        AudioPlayerUtil.playAudio("musics/${sound}.mp3");
      } else {
        AudioPlayerUtil.stopAudio();
      }
    }, looping: false).then((value) {
      AudioPlayerUtil.stopAudio();
      var sound = sounds[value];
      setState(() {
        _ticking_sound = sound;
      });
      AppStorage.setString(AppStorage.K_STRING_POMODORO_TICKING_SOUND, sound);
    });
  }

  void _pressed_alarm_sound() {
    final List<String> sounds = ['None', 'Afternoon', 'Cowbell', 'Happiness', 'Morning', 'Ring', 'Vintage'];
    CustomPicker().show(context, sounds, sounds.indexOf(_alarm_sound), (position) {
      var sound = sounds[position];
      setState(() {
        _alarm_sound = sound;
      });
      if (sound != "None") {
        AudioPlayerUtil.playAudio("musics/${sound}.mp3");
      } else {
        AudioPlayerUtil.stopAudio();
      }
    }, looping: false).then((value) {
      print(value);
      var sound = sounds[value];
      setState(() {
        _alarm_sound = sound;
      });
      AppStorage.setString(AppStorage.K_STRING_POMODORO_ALARM_SOUND, sound);
    });
  }

}
