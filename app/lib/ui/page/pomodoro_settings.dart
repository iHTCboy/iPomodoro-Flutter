import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/ui/widget/custom_picker.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';

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
        title: Text('番茄设置'),
        brightness: Brightness.dark,
        backgroundColor: AppColors.PRIMARY_MAIN_COLOR,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              '🍅',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text('每个番茄学习时间',
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pomodoro_hours == 0 ? '${_pomodoro_minutes}分钟' : '${_pomodoro_hours}小时${_pomodoro_minutes}分钟',
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
            title: Text('每个番茄休息时间(短)',
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${_break_short}分钟',
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
            title: Text('每个番茄休息时间(长)',
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${_break_long}分钟',
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
            title: Text('超长休息时间个数',
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${_break_long_delay}个番茄时间',
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
            title: Text('允许后台推送提醒',
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_setting_notification == 0 ? "开" : '关',
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
    TimerPicker().show(context, _pomodoro_hours, _pomodoro_minutes, (duration) {
      _change_pomodoro_time(duration, false);
    }).then((durationTime) {
      if (durationTime != null) {
        _change_pomodoro_time(durationTime, true);
      }
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
    CustomPicker().show(context, ['开', '关'], _setting_notification, (position) {
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
}
