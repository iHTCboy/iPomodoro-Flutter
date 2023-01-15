import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/audio_utils.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/common/utils/notification_utils.dart';
import 'package:iPomodoro/common/utils/time_utils.dart';
import 'package:iPomodoro/config/app_config.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/ui/widget/cupertino_alert.dart';
import 'package:iPomodoro/ui/widget/privacy_policy_dialog.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';
import 'package:iPomodoro/ui/widget/tips_dialog.dart';
import 'package:iPomodoro/common/channel/native_method_channel.dart';

class PomodoroPage extends StatefulWidget {
  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> with WidgetsBindingObserver {
  Timer _timer;
  int _hours = 0;
  String _minutes = '25';
  String _seconds = '00';
  int _countdown = 0;
  bool _show_tpis = true;
  bool _show_edit_button = true;
  bool _show_seconds_text = false;
  TimerStateMode _timer_mode = TimerStateMode.start;
  // 番茄钟参数
  int _pomodoro_times = 0; //判断当前时番茄时间还是休息时间。偶数是番茄钟，奇数是休息时间
  PomodoroMode _pomodoro_mode = PomodoroMode.stop;
  // 设置的默认值
  int _pomodoro_hours = 0;
  String _pomodoro_minutes = '25';
  String _break_short = '05';
  String _break_long = '15';
  int _break_long_delay = 2;
  int _enable_notification = 0;//0是允许推送

  bool _is_audio_sound = true;
  bool _is_ticking_sound = true;
  AudioPlayerUtil audioPlayer = AudioPlayerUtil();
  AudioPlayerUtil tickingPlayer = AudioPlayerUtil();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pomodoro_set_time();
    _pomodoro_set_sounds();
    tickingPlayer.setCache("musics/Ticking.mp3");
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_show_tpis) {
      _show_tpis = false;
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showTips();
        // 华为渠道必须有隐私弹窗
        show_privacy_policy();
      });
    };
  }

  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // app当前可见，并且能响应用户的输入
        NativeChannel.changeBadgeNumber(0);
        NotificationUtils.cancelNotification(10);
        NotificationUtils.cancelNotification(11);
        break;
      case AppLifecycleState.inactive:
        //app当前在前台，但是不可响应用户的输入，即失去焦点
        break;
      case AppLifecycleState.paused:
        //app当前在后台，不可响应用户的输入
        if (_enable_notification == 0 && _timer_mode == TimerStateMode.timing) {
          NotificationUtils.showNotification(0, S.of(context).pomodoro_push_tips, TipsDialog.get_tips());
          NotificationUtils.addScheduleNotification(10, S.of(context).pomodoro_push_tips, TipsDialog.get_tips(), 10);
          NotificationUtils.addScheduleNotification(11, S.of(context).pomodoro_push_tips, TipsDialog.get_tips(), 30);
        }
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(AppConfig.AppName),
        backgroundColor: AppColors.PRIMARY_MAIN_COLOR,
        actions: [
          _timer_mode == TimerStateMode.start
              ? TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/pomodoro_settings').then((value) {
                      _pomodoro_set_time();
                      _pomodoro_set_sounds();
                    });
                  },
                  icon: Icon(Icons.settings),
                  label: Text(""),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                )
              : TextButton(
                  onPressed: _pressed_stop_button,
                  child: Text(S.of(context).give_up_button),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: AppColors.PRIMARY_SUB_COLOR,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(height: DeviceUtils.get_size(context, 18, 20, 25)),
                    Text(_timer_mode == TimerStateMode.timing ?
                    (_pomodoro_mode == PomodoroMode.breaktime ? S.of(context).break_time : S.of(context).learn_time ) : S.of(context).pomodoro_time,
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
                            fontSize: DeviceUtils.get_size(context, 100, 120, 200),
                            fontFamily: 'ChakraPetch',
                            color: Colors.white,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: DeviceUtils.get_size(context, 23, 25, 45)),
                          Text(S.of(context).hours,
                              style: TextStyle(
                                fontSize: DeviceUtils.get_size(context, 18, 20, 40),
                                color: Colors.white,
                              ))
                        ],
                      ),
                      Text(_minutes,
                          style: TextStyle(
                            fontSize: DeviceUtils.get_size(context, 100, 120, 200),
                            fontFamily: 'ChakraPetch',
                            color: Colors.white,
                          )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: DeviceUtils.get_size(context, 23, 25, 45)),
                          Text(S.of(context).minutes,
                              style: TextStyle(
                                fontSize: DeviceUtils.get_size(context, 18, 20, 40),
                                color: Colors.white,
                              )),
                          SizedBox(height: _show_edit_button ? DeviceUtils.get_size(context, 20, 38, 50) : DeviceUtils.get_size(context, 20, 28, 28)),
                          Visibility(
                            visible: _show_edit_button,
                            child: TextButton.icon(
                              onPressed: _pressed_edit_button,
                              icon: Icon(Icons.edit, size: DeviceUtils.get_size(context, 22, 25, 40)),
                              label: Text(''),
                              style: ButtonStyle(
                                alignment: Alignment.centerLeft,
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
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
                                    fontSize: DeviceUtils.get_size(context, 35, 50, 65),
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
                      primary: Colors.white,
                      minimumSize: Size(DeviceUtils.get_size(context, 135, 155, 200), DeviceUtils.get_size(context, 40, 44, 65)),
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

  void _pomodoro_set_time() {
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_BREAK_SHORT).then((value) {
      _break_short = value == null ? '05' : value > 9 ? value.toString() : '0$value';
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_BREAK_LONG).then((value) {
      _break_long = value == null ? '15' : value > 9 ? value.toString() : '0$value';
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_BREAK_LONG_DELAY)
        .then((value) {
      _break_long_delay = value ?? 2;
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_NOTIFICATION).then((value) {
      _enable_notification = value ?? 0;
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_HOURS).then((value) {
      _hours = value ?? 0;
      _pomodoro_hours = _hours;
    });
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_MINUTES).then((value) {
      setState(() {
         _minutes = value == null ? '25' : value > 9 ? value.toString() : '0$value';
        _pomodoro_minutes = _minutes;
      });
    });
  }

  void _pomodoro_set_sounds() {
    AppStorage.getInt(AppStorage.K_STRING_POMODORO_TICKING_SOUND).then((value) {
      _is_ticking_sound = value == 1 ? false : true;
    });
    AppStorage.getString(AppStorage.K_STRING_POMODORO_ALARM_SOUND).then((value) {
      var sound = value ?? "Cowbell";
      if (sound != 'None') {
        _is_audio_sound = true;
        audioPlayer.setCache("musics/${sound}.mp3");
      } else {
        _is_audio_sound = false;
      }
    });
  }

  void _pressed_edit_button() async {
    TimerPicker().show(context, _hours, int.parse(_minutes), (duration) {
      change_time(duration);
    }).then((durationTime) {
      if (durationTime != null) {
        change_time(durationTime);
      }
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
      _pomodoro_hours = _hours;
      _pomodoro_minutes = _minutes;
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
          _hours = _pomodoro_hours;
          _minutes = _pomodoro_minutes;
          _seconds = '00';
          showTips();
          break;
      }
    });
  }

  void _pressed_stop_button() async {
    bool ans = await AlertView.show(
        context, S.of(context).tips_text, S.of(context).pomodoro_give_up_tips,
        cancelText: S.of(context).pomodoro_no,
        confirmText: S.of(context).pomodoro_yes);
    if (ans) {
      setState(() {
        _pomodoro_times = 0;
        _timer_mode = TimerStateMode.stop;
        _pomodoro_mode = PomodoroMode.stop;
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
        pageBuilder: (BuildContext context, _, __) => TipsDialog()));
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
      tickingPlayer.stop();
    }
  }

  void tickingPlay() {
    if (_is_ticking_sound) {
      tickingPlayer.seek(Duration(seconds: 0));
      tickingPlayer.play(null);
    }
  }

  void countdownFinish() {
    setState(() {
      _pomodoro_times++;
    });
    if (_is_audio_sound) {
      audioPlayer.play(null);
    }
    bool is_pomodoro = (_pomodoro_times % 2) == 0; // 等于0就是番茄时间
    int x_pomodoro = ((_pomodoro_times + 1) / 2).floor();
    String title = is_pomodoro ? S.of(context).tips_come_on : S.of(context).tips_congratulation;
    String content = is_pomodoro ? S.of(context).pomodoro_next_times('${x_pomodoro +1}') : S.of(context).pomodoro_next_break('${x_pomodoro}') ;

    AlertView.show(context, title, content, cancelText: '', confirmText: S.of(context).pomodoro_ok).then((bool ans) {
      setState(() {
        _timer_mode = TimerStateMode.start;
        _pomodoro_mode = is_pomodoro ? PomodoroMode.timing : PomodoroMode.breaktime;
        if (is_pomodoro) {
          _hours = _pomodoro_hours;
          _minutes = _pomodoro_minutes;
          _seconds = '00';
        } else {
          _hours = 0;
          _seconds = '00';
          if(x_pomodoro > _break_long_delay) {
            _minutes = _break_long;
          } else {
            _minutes = _break_short;
          }
        }
      });

      if(ans) {
        _pressed_start_button();
      }
    });
  }
  
  void show_privacy_policy() {
    if(Platform.isAndroid) {
      AppStorage.getInt(AppStorage.K_STRING_PRIVACY_SHOW_TIPS).then((value) {
        if (value == null) {
          PrivacyPolicyDialog().showCustomDialog(context,
              textClickedFunction: () {
                AppStorage.getString(AppStorage.K_STRING_LANGUAGE_SETTINGS).then((value) {
                  String languageCode = DeviceUtils.languageCode();
                  // 首次安装没有语言记录，则用系统语言匹配，非中文都默认用默认
                  if(value != null) {
                    languageCode = value;
                  } else {
                    languageCode = languageCode == 'zh' ? languageCode : 'en';
                  }
                  NativeChannel.openPrivacyView(languageCode);
                });
              },
              cancelBtnFunction: () {
                //退出应用
                exit(404);
              },
              agreeBtnFunction: () {
                AppStorage.setInt(AppStorage.K_STRING_PRIVACY_SHOW_TIPS, 1);
              });
        }
      });
    }
  }

}


