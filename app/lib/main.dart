import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    //push
    _initLanguageSettings();
    _initNotificationsPlugin();
    _requestPermissions();
    _configureLocalTimeZone();
    NativeChannel.idleTimerDisabled(true);
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
        },
      ),
    );
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
