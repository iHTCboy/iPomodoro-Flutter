import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/ui/widget/custom_picker.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';

class TimerSettingsPage extends StatefulWidget {
  @override
  _TimerSettingsPageState createState() => _TimerSettingsPageState();
}

class _TimerSettingsPageState extends State<TimerSettingsPage> {
  int _timer_hours = 1;
  int _timer_minutes = 30;
  int _setting_notification = 0;

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
                width: 120,
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
                width: 120,
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

}
