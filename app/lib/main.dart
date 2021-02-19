import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/config/app_config.dart';
import 'package:iPomodoro/ui/page/countdown_page.dart';
import 'package:iPomodoro/ui/page/me_page.dart';
import 'package:iPomodoro/ui/page/pomodoro_page.dart';
import 'package:iPomodoro/ui/page/pomodoro_settings.dart';
import 'package:iPomodoro/ui/page/timer_page.dart';
import 'package:iPomodoro/ui/page/timer_settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.AppName,
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY_MAIN_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyRootPage(),
        '/pomodoro_settings': (BuildContext context) => PomodoroSettingsPage(),
        '/timer_settings': (BuildContext context) => TimerSettingsPage(),
      },
    );
  }
}

class MyRootPage extends StatefulWidget {
  @override
  _MyRootPageState createState() => _MyRootPageState();
}

class _MyRootPageState extends State<MyRootPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          PomodoroPage(),
          TimerPage(),
          CountdownPagee(),
          MePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_on),
            activeIcon: Icon(Icons.alarm),
            label: '番茄钟',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            activeIcon: Icon(Icons.timelapse),
            label: '倒计时',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            activeIcon: Icon(Icons.date_range),
            label: '定任务',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: '关于我',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
