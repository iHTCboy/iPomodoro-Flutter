import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/common/utils/time_utils.dart';
import 'package:iPomodoro/ui/widget/cupertino_alert.dart';
import 'package:iPomodoro/ui/widget/time_dialog.dart';
import 'package:iPomodoro/ui/widget/tips_dialog.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer _timer;
  int _hours = 1;
  String _minutes = '30';
  String _seconds = '00';
  int _countdown = 0;
  bool _show_seconds_text = false;
  bool _show_edit_button = true;
  TimerStateMode _timer_mode = TimerStateMode.start;

  // 设置的时间
  int _timer_hours = 1;
  String _timer_minutes = '30';

  @override
  void initState() {
    super.initState();
    _timer_set_time();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColors.TIMER_MAIN_COLOR,
        title: Text('计时学习'),
        actions: [
          _timer_mode == TimerStateMode.start
              ? TextButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/timer_settings')
                        .then((value) {
                      _timer_set_time();
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
                  child: Text('放弃'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: AppColors.TIMER_SUB_COLOR,
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(height: DeviceUtils.get_size(context, 18, 20, 25)),
                    Text(
                        _timer_mode == TimerStateMode.timing
                            ? '️⏳ 倒计时学习'
                            : '⌛ 倒计时学习',
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
                          Text('时',
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
                          Text('分',
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
                      primary: Colors.white,
                      minimumSize: Size(
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
                          ? '开始'
                          : (_timer_mode == TimerStateMode.timing
                              ? '暂停'
                              : (_timer_mode == TimerStateMode.pause
                                  ? '继续'
                                  : '开始')),
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
    bool ans = await AlertView.show(context, '提示', '确认要放弃当前⏳倒计时吗？',
        cancelText: '否(💪)', confirmText: '是(😭)');
    if (ans) {
      setState(() {
        _timer_mode = TimerStateMode.stop;
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
          timer.cancel();
          countdownFinish();
        } else {
          setState(() {
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

  void countdownFinish() {
    AlertView.show(context, '恭喜', '当前⏳倒计时已经完成！是否继续下一个？',
            cancelText: '否(😂)', confirmText: '继续(👊)')
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
