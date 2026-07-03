import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iPomodoro/common/channel/native_method_channel.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/config/app_config.dart';
import 'package:iPomodoro/ui/page/app_about_page.dart';
import 'package:iPomodoro/ui/page/brightness_settings.dart';
import 'package:iPomodoro/ui/page/countdown_page.dart';
import 'package:iPomodoro/ui/page/countdown_settings.dart';
import 'package:iPomodoro/ui/page/language_settings.dart';
import 'package:iPomodoro/ui/page/me_page.dart';
import 'package:iPomodoro/ui/page/pomodoro_page.dart';
import 'package:iPomodoro/ui/page/pomodoro_settings.dart';
import 'package:iPomodoro/ui/page/theme_style.dart';
import 'package:iPomodoro/ui/page/timer_page.dart';
import 'package:iPomodoro/ui/page/timer_settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'common/utils/config_storage.dart';
import 'generated/l10n.dart';


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
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY_MAIN_COLOR,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyRootPage(),
        '/pomodoro_settings': (BuildContext context) => PomodoroSettingsPage(),
        '/timer_settings': (BuildContext context) => TimerSettingsPage(),
        '/countdown_settings': (BuildContext context) =>
            CountdownSettingsPage(),
        '/app_about': (BuildContext context) => AppAbout(),
        '/brightness_settings': (BuildContext context) => BrightnessSettings(),
        '/language_settings': (BuildContext context) => LanguageSettings(),
        '/theme_style': (BuildContext context) => ThemeStyleSettingsPage(),
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

  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    //push
    _initLanguageSettings();
    _initNotificationsPlugin();
    _requestPermissions();
    _configureLocalTimeZone();
    NativeChannel.idleTimerDisabled(true);

    // 初始化状态栏颜色
    if (Platform.isAndroid) {
      _updateStatusBarColor(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = item_colors[_currentIndex];

    // 使用透明状态栏，避免触发弃用的API
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _getStatusBarIconBrightness(currentColor),
      systemNavigationBarColor: AppColors.isDarkMode(context) ? Colors.black : Colors.white,
      systemNavigationBarIconBrightness: AppColors.isDarkMode(context) ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      // 添加Container作为状态栏背景色
      body: Column(
        children: [
          // 状态栏背景色
          Container(
            height: MediaQuery.of(context).padding.top,
            color: currentColor,
          ),
          // 原有的body内容
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                PomodoroPage(),
                TimerPage(),
                CountdownPagee(),
                MePage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: item_colors[_currentIndex],
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_on),
            activeIcon: Icon(Icons.alarm),
            label: S.of(context).pomodoro,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            activeIcon: Icon(Icons.timelapse),
            label: S.of(context).countdown,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            activeIcon: Icon(Icons.date_range),
            label: S.of(context).tasks,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: S.of(context).about_me,
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // 在Android平台上调用原生方法设置状态栏颜色
          if (Platform.isAndroid) {
            _updateStatusBarColor(index);
          }
        },
      ),
    );
  }

  // 更新状态栏颜色的辅助方法
  void _updateStatusBarColor(int index) {
    final currentColor = item_colors[index];
    final colorValue = (currentColor.a * 255).round() << 24 |
                      (currentColor.r * 255).round() << 16 |
                      (currentColor.g * 255).round() << 8 |
                      (currentColor.b * 255).round();

    try {
      NativeChannel.setStatusBarColor(colorValue);
    } catch (e) {
      print('Failed to set status bar color: $e');
    }
  }

  // 根据背景颜色判断状态栏图标应该使用亮色还是暗色
  Brightness _getStatusBarIconBrightness(Color backgroundColor) {
    // 计算颜色亮度 (使用相对亮度公式)
    double luminance = (0.299 * (backgroundColor.r * 255).round() +
                       0.587 * (backgroundColor.g * 255).round() +
                       0.114 * (backgroundColor.b * 255).round()) / 255;

    // 如果背景较暗，使用亮色图标；如果背景较亮，使用暗色图标
    return luminance > 0.5 ? Brightness.dark : Brightness.light;
  }

  void _initLanguageSettings() {
    AppStorage.getString(AppStorage.K_STRING_LANGUAGE_SETTINGS).then((value) {
      setState(() {
        if (value == "zh") S.load(Locale('zh', ''));
        if (value == "en") S.load(Locale('en', 'US'));
      });
        });
  }

  void _initNotificationsPlugin() {
    final List<DarwinNotificationCategory> darwinNotificationCategories =
    <DarwinNotificationCategory>[];
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    // final DarwinInitializationSettings initializationSettingsDarwin =
    // DarwinInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: darwinNotificationCategories,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    _isAndroidPermissionGranted();
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    debugPrint('notification payload: $payload');
      // showDialog(
    //   context: context,
    //   builder: (_) => new AlertDialog(
    //     title: new Text('Notification'),
    //     content: new Text('$payload'),
    //   ),
    // );
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }

  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      setState(() {
        _notificationsEnabled = grantedNotificationPermission ?? false;
      });
    }
  }


  Future<String> _configADBC() async {
    var string = "iProma";
    print(string);
    return "Push New Message";
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await NativeChannel.timeZone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}
