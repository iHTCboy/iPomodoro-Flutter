import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/ui/widget/custom_picker.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';
import 'package:iPomodoro/common/utils/audio_utils.dart';
import 'package:flutter/services.dart';

class TimerSettingsPage extends StatefulWidget {
  @override
  _TimerSettingsPageState createState() => _TimerSettingsPageState();
}

class _TimerSettingsPageState extends State<TimerSettingsPage> {
  int _timer_hours = 1;
  int _timer_minutes = 30;
  int _setting_notification = 0;
  int _play_clock_ticking_sound = 0;
  String _alarm_sound = "Cowbell";

  @override
  void initState() {
    super.initState();
    _init_storage();
  }

  void _init_storage() {
    AppStorage.getInt(AppStorage.K_STRING_TIMERT_NOTIFICATION).then((value) {
      _setting_notification = value ?? 0;
    });
    AppStorage.getInt(AppStorage.K_STRING_TIMER_HOURS).then((value) {
      _timer_hours = value ?? 1;
    });
    AppStorage.getInt(AppStorage.K_STRING_TIMER_MINUTES)
        .then((value) {
      setState(() {
        _timer_minutes = value ?? 30;
      });
    });
    AppStorage.getInt(AppStorage.K_STRING_TIMER_TICKING_SOUND).then((value) {
      _play_clock_ticking_sound = value ?? 0;
    });
    AppStorage.getString(AppStorage.K_STRING_TIMER_ALARM_SOUND).then((value) {
      _alarm_sound = value ?? 'Cowbell';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).timer_settings),
        brightness: Brightness.dark,
        backgroundColor: AppColors.TIMER_MAIN_COLOR,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              '⏳',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).timer_duration,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 130, 140, 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_timer_hours == 0 ? S.of(context).pomodoro_minutes('${_timer_minutes}') : S.of(context).pomodoro_hours_minutes('${_timer_hours}', '${_timer_minutes}'),
                        style: TextStyle(
                            color: AppColors.TIMER_SUB_COLOR,
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
              '📢',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).background_push_tips,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 130, 130, 200),
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
                    Text(_play_clock_ticking_sound == 0 ? S.of(context).switch_on : S.of(context).switch_off,
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
    TimerPicker().show(context, _timer_hours, _timer_minutes, (duration) {
      _change_time(duration, false);
    }).then((durationTime) {
      if (durationTime != null) {
        _change_time(durationTime, true);
      }
    });
  }

  void _change_time(Duration duration, bool isSave) {
    int minutes = duration.inMinutes;
    if (minutes >= 60) {
      minutes = minutes % 60;
    }

    setState(() {
      _timer_hours = duration.inHours;
      _timer_minutes = minutes;
    });

    if (isSave) {
      AppStorage.setInt(AppStorage.K_STRING_TIMER_HOURS, duration.inHours);
      AppStorage.setInt(AppStorage.K_STRING_TIMER_MINUTES, minutes);
    }
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
      AppStorage.setInt(AppStorage.K_STRING_TIMERT_NOTIFICATION, value);
    });
  }

  void _pressed_play_clock_ticking_sound() {
    CustomPicker().show(context, [S.of(context).switch_on, S.of(context).switch_off], _play_clock_ticking_sound, (position) {
      setState(() {
        _play_clock_ticking_sound = position;
      });
    }, looping: false).then((value) {
      print(value);
      setState(() {
        _play_clock_ticking_sound = value;
      });
      AppStorage.setInt(AppStorage.K_STRING_TIMER_TICKING_SOUND, value);
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
      }
    }, looping: false).then((value) {
      print(value);
      var sound = sounds[value];
      setState(() {
        _alarm_sound = sound;
      });
      AppStorage.setString(AppStorage.K_STRING_TIMER_ALARM_SOUND, sound);
    });
  }

}
