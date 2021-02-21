import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iPomodoro/common/channel/native_method_channel.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/config/app_config.dart';
import 'package:iPomodoro/ui/page/app_about_page.dart';
import 'package:iPomodoro/ui/page/countdown_page.dart';
import 'package:iPomodoro/ui/page/countdown_settings.dart';
import 'package:iPomodoro/ui/page/me_page.dart';
import 'package:iPomodoro/ui/page/pomodoro_page.dart';
import 'package:iPomodoro/ui/page/pomodoro_settings.dart';
import 'package:iPomodoro/ui/page/timer_page.dart';
import 'package:iPomodoro/ui/page/timer_settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.AppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY_MAIN_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyRootPage(),
        '/pomodoro_settings': (BuildContext context) => PomodoroSettingsPage(),
        '/timer_settings': (BuildContext context) => TimerSettingsPage(),
        '/countdown_settings': (BuildContext context) =>
            CountdownSettingsPage(),
        '/app_about': (BuildContext context) => AppAbout(),
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
  final List item_colors = [
    AppColors.PRIMARY_MAIN_COLOR,
    AppColors.TIMER_MAIN_COLOR,
    AppColors.COUNTDOWN_MAIN_COLOR,
    AppColors.ME_MAIN_COLOR
  ];

  @override
  void initState() {
    super.initState();
    //push
    _initNotificationsPlugin();
    _requestPermissions();
    _configureLocalTimeZone();
  }

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
        selectedItemColor: item_colors[_currentIndex],
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

  void _initNotificationsPlugin() {
    const android = AndroidInitializationSettings('app_icon');
    const iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings, onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // showDialog(
    //   context: context,
    //   builder: (_) => new AlertDialog(
    //     title: new Text('Notification'),
    //     content: new Text('$payload'),
    //   ),
    // );
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await NativeChannel.timeZone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}
