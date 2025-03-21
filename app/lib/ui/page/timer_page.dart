import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iPomodoro/common/channel/native_method_channel.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/audio_utils.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/common/utils/notification_utils.dart';
import 'package:iPomodoro/common/utils/time_utils.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/ui/widget/cupertino_alert.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';
import 'package:iPomodoro/ui/widget/tips_dialog.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  late Timer _timer;
  int _hours = 1;
  String _minutes = '30';
  String _seconds = '00';
  int _countdown = 0;
  bool _show_seconds_text = false;
  bool _show_edit_button = true;
  TimerStateMode _timer_mode = TimerStateMode.start;
  int _enable_notification = 0;//0是允许推送
  // 设置的时间
  int _timer_hours = 1;
  String _timer_minutes = '30';

  bool _is_audio_sound = true;
  bool _is_ticking_sound = true;
  AudioPlayerUtil audioPlayer = AudioPlayerUtil();
  AudioPlayerUtil tickingPlayer = AudioPlayerUtil();

  late Color titleBarColor = AppColors.TIMER_MAIN_COLOR;
  late Color backgroundColor = AppColors.TIMER_SUB_COLOR;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _timer_set_time();
    _timer_set_sounds();
    _set_color();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // app当前可见，并且能响应用户的输入
        NativeChannel.changeBadgeNumber(0);
        NotificationUtils.cancelNotification(100);
        NotificationUtils.cancelNotification(101);
        NotificationUtils.cancelNotification(102);
        break;
      case AppLifecycleState.inactive:
      //app当前在前台，但是不可响应用户的输入，即失去焦点
        break;
      case AppLifecycleState.paused:
      //app当前在后台，不可响应用户的输入
        if (_enable_notification == 0 && _timer_mode == TimerStateMode.timing) {
          NotificationUtils.showNotification(1, S.of(context).timer_push_tips, TipsDialog.get_tips());
          NotificationUtils.addScheduleNotification(100, S.of(context).timer_push_tips, TipsDialog.get_tips(), 10);
          NotificationUtils.addScheduleNotification(101, S.of(context).timer_push_tips, TipsDialog.get_tips(), 30);
          NotificationUtils.addScheduleNotification(102, S.of(context).timer_push_tips, TipsDialog.get_tips(), 300);
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: titleBarColor,
        title: Text(S.of(context).timer_learn, style: TextStyle(color: Colors.white)),
        actions: [
          _timer_mode == TimerStateMode.start
              ? TextButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/timer_settings')
                        .then((value) {
                      _timer_set_time();
                      _timer_set_sounds();
                      _set_color();
                    });
                  },
                  icon: Icon(Icons.settings),
                  label: Text(""),
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ),
                )
              : TextButton(
                  onPressed: _pressed_stop_button,
                  child: Text(S.of(context).give_up_button),
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  ))
        ], systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Container(
        alignment: Alignment.center,
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(height: DeviceUtils.get_size(context, 18, 20, 25)),
                    Text(
                        _timer_mode == TimerStateMode.timing
                            ? S.of(context).timer_learning
                            : S.of(context).timer_learn_tips,
                        style: TextStyle(
                          fontSize: DeviceUtils.get_size(context, 20, 22, 35),
                          color: Colors.white,
                        )),
                  ],
                )),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 45),
                      Text(_hours.toString(),
                          style: TextStyle(
                            fontSize:
                                DeviceUtils.get_size(context, 100, 120, 200),
                            fontFamily: 'ChakraPetch',
                            color: Colors.white,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height:
                                  DeviceUtils.get_size(context, 23, 25, 45)),
                          Text(S.of(context).hours,
                              style: TextStyle(
                                fontSize:
                                    DeviceUtils.get_size(context, 18, 20, 40),
                                color: Colors.white,
                              ))
                        ],
                      ),
                      Text(_minutes,
                          style: TextStyle(
                            fontSize:
                                DeviceUtils.get_size(context, 100, 120, 200),
                            fontFamily: 'ChakraPetch',
                            color: Colors.white,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                              height:
                                  DeviceUtils.get_size(context, 23, 25, 45)),
                          Text(S.of(context).minutes,
                              style: TextStyle(
                                fontSize:
                                    DeviceUtils.get_size(context, 18, 20, 40),
                                color: Colors.white,
                              )),
                          SizedBox(
                              height: _show_edit_button
                                  ? DeviceUtils.get_size(context, 20, 38, 50)
                                  : DeviceUtils.get_size(context, 20, 28, 28)),
                          Visibility(
                            visible: _show_edit_button,
                            child: TextButton.icon(
                              onPressed: _pressed_edit_button,
                              icon: Icon(Icons.edit,
                                  size: DeviceUtils.get_size(
                                      context, 22, 25, 40)),
                              label: Text(''),
                              style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _show_seconds_text,
                            child: Container(
                              width: DeviceUtils.get_size(context, 55, 70, 85),
                              child: Text(_seconds,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: DeviceUtils.get_size(
                                        context, 35, 50, 65),
                                    fontFamily: 'ChakraPetch',
                                    color: Colors.grey[300],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: DeviceUtils.get_size(context, 5, 10, 60)),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, minimumSize: Size(
                          DeviceUtils.get_size(context, 135, 155, 200),
                          DeviceUtils.get_size(context, 40, 44, 65)),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      side: BorderSide(width: 1.5, color: Colors.white),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                    ),
                    child: Text(
                      _timer_mode == TimerStateMode.start
                          ? S.of(context).start_button
                          : (_timer_mode == TimerStateMode.timing
                              ? S.of(context).pause_button
                              : (_timer_mode == TimerStateMode.pause
                                  ? S.of(context).continue_button
                                  : S.of(context).start_button)),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: _pressed_start_button,
                  ),
                  SizedBox(height: DeviceUtils.get_size(context, 0, 8, 10)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _timer_set_time() {
    AppStorage.getInt(AppStorage.K_STRING_TIMER_NOTIFICATION).then((value) {
      _enable_notification = value ?? 0;
    });
    AppStorage.getInt(AppStorage.K_STRING_TIMER_HOURS).then((value) {
      _hours = value ?? 1;
      _timer_hours = _hours;
    });
    AppStorage.getInt(AppStorage.K_STRING_TIMER_MINUTES).then((value) {
      setState(() {
        _minutes = value == null ? '30' : value > 9 ? value.toString() : '0$value';
        _timer_minutes = _minutes;
      });
    });
  }

  void _timer_set_sounds() {
    AppStorage.getString(AppStorage.K_STRING_TIMER_TICKING_SOUND).then((value) {
      var sound = value ?? "Ticking";
      if (sound != 'None') {
        _is_ticking_sound = true;
        tickingPlayer.setCache("musics/${sound}.mp3");
      } else {
        _is_ticking_sound = false;
      }
    });

    AppStorage.getString(AppStorage.K_STRING_TIMER_ALARM_SOUND).then((value) {
      var sound = value ?? "Cowbell";
      if (sound != 'None') {
        _is_audio_sound = true;
        audioPlayer.setCache("musics/${sound}.mp3");
      } else {
        _is_audio_sound = false;
      }
    });
  }

  void _set_color() {
    AppStorage.getInt(AppStorage.K_STRING_TIMER_TITLE_BAR_COLOR)
        .then((value) {
      setState(() {
        titleBarColor =
        value != null ? Color(value) : AppColors.TIMER_MAIN_COLOR;
      });
    });
    AppStorage.getInt(AppStorage.K_STRING_TIMER_BACKGROUND_COLOR)
        .then((value) {
      setState(() {
        backgroundColor =
        value != null ? Color(value) : AppColors.TIMER_SUB_COLOR;
      });
    });
  }

  void _pressed_edit_button() async {
    TimerPicker().show(context, _hours, int.parse(_minutes), (duration) {
      change_time(duration);
    }).then((durationTime) {
      change_time(durationTime);
        });
  }

  void change_time(Duration duration) {
    setState(() {
      _hours = duration.inHours;
      int minutes = duration.inMinutes;
      if (minutes >= 60) {
        minutes = minutes % 60;
      }
      _minutes = minutes > 9 ? minutes.toString() : '0$minutes';
      _timer_hours = _hours;
      _timer_minutes = _minutes;
    });
  }

  void _pressed_start_button() {
    setState(() {
      switch (_timer_mode) {
        case TimerStateMode.start:
          _timer_mode = TimerStateMode.timing;
          _show_seconds_text = true;
          _show_edit_button = false;
          startTimer();
          break;
        case TimerStateMode.timing:
          _timer_mode = TimerStateMode.pause;
          _timer.cancel();
          tickingStop();
          break;
        case TimerStateMode.pause:
          _timer_mode = TimerStateMode.timing;
          startTimer();
          break;
        case TimerStateMode.stop:
          _timer_mode = TimerStateMode.start;
          _timer.cancel();
          _show_seconds_text = false;
          _show_edit_button = true;
          _hours = _timer_hours;
          _minutes = _timer_minutes;
          _seconds = '00';
          showTips();
          break;
      }
    });
  }

  void _pressed_stop_button() async {
    bool ans = await AlertView.show(context, S.of(context).tips_text, S.of(context).timer_give_up_tips,
        cancelText: S.of(context).pomodoro_no, confirmText: S.of(context).pomodoro_yes);
    if (ans) {
      setState(() {
        _timer_mode = TimerStateMode.stop;
        tickingStop();
      });
      _pressed_start_button();
    }
  }

  void showTips() {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return TipsDialog();
    //     });
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) =>
            TipsDialog(backgroundColor: AppColors.TIMER_MAIN_COLOR)));
  }

  void startTimer() {
    _countdown =
        _hours * 60 * 60 + int.parse(_minutes) * 60 + int.parse(_seconds);
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countdown == 0) {
          tickingStop();
          timer.cancel();
          countdownFinish();
        } else {
          setState(() {
            tickingPlay();
            _countdown--;
            List time = TimeUtils.calculateDate(_countdown);
            _hours = time[0];
            _minutes = time[1];
            _seconds = time[2];
          });
        }
      },
    );
  }

  void tickingStop() {
    if (_is_ticking_sound) {
      tickingPlayer.loop(false);
      tickingPlayer.stop();
    }
  }

  void tickingPlay() {
    if (_is_ticking_sound) {
      tickingPlayer.loop(true);
      tickingPlayer.play(null);
    }
  }

  void countdownFinish() {
    if (_is_audio_sound) {
      audioPlayer.play(null);
    }
    AlertView.show(context, S.of(context).tips_congratulation, S.of(context).timer_congratulation_next,
            cancelText: S.of(context).timer_no, confirmText: S.of(context).timer_continue)
        .then((bool ans) {
      setState(() {
        _timer_mode = TimerStateMode.start;
        _show_seconds_text = false;
        _show_edit_button = true;
        _hours = _timer_hours;
        _minutes = _timer_minutes;
        _seconds = '00';
      });

      if (ans) {
        _pressed_start_button();
      }
    });
  }
}
