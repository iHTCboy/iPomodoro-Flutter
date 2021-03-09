// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `iPomodoro`
  String get iPomodoro {
    return Intl.message(
      'iPomodoro',
      name: 'iPomodoro',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro`
  String get pomodoro {
    return Intl.message(
      'Pomodoro',
      name: 'pomodoro',
      desc: '',
      args: [],
    );
  }

  /// `Countdown`
  String get countdown {
    return Intl.message(
      'Countdown',
      name: 'countdown',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get tasks {
    return Intl.message(
      'Task',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_me {
    return Intl.message(
      'About',
      name: 'about_me',
      desc: '',
      args: [],
    );
  }

  /// `H`
  String get hours {
    return Intl.message(
      'H',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get minutes {
    return Intl.message(
      'M',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `iPomodoro reminder 🍅！`
  String get pomodoro_push_tips {
    return Intl.message(
      'iPomodoro reminder 🍅！',
      name: 'pomodoro_push_tips',
      desc: '',
      args: [],
    );
  }

  /// `🍌 Break time..`
  String get break_time {
    return Intl.message(
      '🍌 Break time..',
      name: 'break_time',
      desc: '',
      args: [],
    );
  }

  /// `🍅 Studing..`
  String get learn_time {
    return Intl.message(
      '🍅 Studing..',
      name: 'learn_time',
      desc: '',
      args: [],
    );
  }

  /// `🍅 Pomodoro learning`
  String get pomodoro_time {
    return Intl.message(
      '🍅 Pomodoro learning',
      name: 'pomodoro_time',
      desc: '',
      args: [],
    );
  }

  /// `give up`
  String get give_up_button {
    return Intl.message(
      'give up',
      name: 'give_up_button',
      desc: '',
      args: [],
    );
  }

  /// `start`
  String get start_button {
    return Intl.message(
      'start',
      name: 'start_button',
      desc: '',
      args: [],
    );
  }

  /// `pause`
  String get pause_button {
    return Intl.message(
      'pause',
      name: 'pause_button',
      desc: '',
      args: [],
    );
  }

  /// `continue`
  String get continue_button {
    return Intl.message(
      'continue',
      name: 'continue_button',
      desc: '',
      args: [],
    );
  }

  /// `Prompt`
  String get tips_text {
    return Intl.message(
      'Prompt',
      name: 'tips_text',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to give up 🍅 Pomodoro time?`
  String get pomodoro_give_up_tips {
    return Intl.message(
      'Are you sure you want to give up 🍅 Pomodoro time?',
      name: 'pomodoro_give_up_tips',
      desc: '',
      args: [],
    );
  }

  /// `No(💪)`
  String get pomodoro_no {
    return Intl.message(
      'No(💪)',
      name: 'pomodoro_no',
      desc: '',
      args: [],
    );
  }

  /// `Yes(😭)`
  String get pomodoro_yes {
    return Intl.message(
      'Yes(😭)',
      name: 'pomodoro_yes',
      desc: '',
      args: [],
    );
  }

  /// `Keep on fighting!`
  String get tips_come_on {
    return Intl.message(
      'Keep on fighting!',
      name: 'tips_come_on',
      desc: '',
      args: [],
    );
  }

  /// `Congratulation`
  String get tips_congratulation {
    return Intl.message(
      'Congratulation',
      name: 'tips_congratulation',
      desc: '',
      args: [],
    );
  }

  /// `Start the {x_pomodoro} 🍅 Pomodoro time!`
  String pomodoro_next_times(Object x_pomodoro) {
    return Intl.message(
      'Start the $x_pomodoro 🍅 Pomodoro time!',
      name: 'pomodoro_next_times',
      desc: '',
      args: [x_pomodoro],
    );
  }

  /// `The {x_pomodoro} Pomodoro clock has been completed, take a break, ☕️ add energy!`
  String pomodoro_next_break(Object x_pomodoro) {
    return Intl.message(
      'The $x_pomodoro Pomodoro clock has been completed, take a break, ☕️ add energy!',
      name: 'pomodoro_next_break',
      desc: '',
      args: [x_pomodoro],
    );
  }

  /// `Well✊`
  String get pomodoro_ok {
    return Intl.message(
      'Well✊',
      name: 'pomodoro_ok',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro settings`
  String get pomodoro_settings {
    return Intl.message(
      'Pomodoro settings',
      name: 'pomodoro_settings',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro duration`
  String get pomodoro_duration {
    return Intl.message(
      'Pomodoro duration',
      name: 'pomodoro_duration',
      desc: '',
      args: [],
    );
  }

  /// `Short break duration`
  String get pomodoro_short_break_duration {
    return Intl.message(
      'Short break duration',
      name: 'pomodoro_short_break_duration',
      desc: '',
      args: [],
    );
  }

  /// `Long break duration`
  String get pomodoro_long_break_duration {
    return Intl.message(
      'Long break duration',
      name: 'pomodoro_long_break_duration',
      desc: '',
      args: [],
    );
  }

  /// `Long break delay`
  String get pomodoro_logn_break_delay {
    return Intl.message(
      'Long break delay',
      name: 'pomodoro_logn_break_delay',
      desc: '',
      args: [],
    );
  }

  /// `{pomodoro_time} minutes`
  String pomodoro_minutes(Object pomodoro_time) {
    return Intl.message(
      '$pomodoro_time minutes',
      name: 'pomodoro_minutes',
      desc: '',
      args: [pomodoro_time],
    );
  }

  /// `{pomodoro_hours} hours {pomodoro_minutes} minutes`
  String pomodoro_hours_minutes(Object pomodoro_hours, Object pomodoro_minutes) {
    return Intl.message(
      '$pomodoro_hours hours $pomodoro_minutes minutes',
      name: 'pomodoro_hours_minutes',
      desc: '',
      args: [pomodoro_hours, pomodoro_minutes],
    );
  }

  /// `{pomodoro_times} Pomodoro times`
  String pomodoro_times(Object pomodoro_times) {
    return Intl.message(
      '$pomodoro_times Pomodoro times',
      name: 'pomodoro_times',
      desc: '',
      args: [pomodoro_times],
    );
  }

  /// `Allows background push notifications`
  String get background_push_tips {
    return Intl.message(
      'Allows background push notifications',
      name: 'background_push_tips',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get switch_on {
    return Intl.message(
      'On',
      name: 'switch_on',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get switch_off {
    return Intl.message(
      'Off',
      name: 'switch_off',
      desc: '',
      args: [],
    );
  }

  /// `Timer reminder⏳！`
  String get timer_push_tips {
    return Intl.message(
      'Timer reminder⏳！',
      name: 'timer_push_tips',
      desc: '',
      args: [],
    );
  }

  /// `Time learning`
  String get timer_learn {
    return Intl.message(
      'Time learning',
      name: 'timer_learn',
      desc: '',
      args: [],
    );
  }

  /// `⏳ Studing..`
  String get timer_learning {
    return Intl.message(
      '⏳ Studing..',
      name: 'timer_learning',
      desc: '',
      args: [],
    );
  }

  /// `⌛ Countdown learning`
  String get timer_learn_tips {
    return Intl.message(
      '⌛ Countdown learning',
      name: 'timer_learn_tips',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to give up ⏳ Countdown time?`
  String get timer_give_up_tips {
    return Intl.message(
      'Are you sure you want to give up ⏳ Countdown time?',
      name: 'timer_give_up_tips',
      desc: '',
      args: [],
    );
  }

  /// `Current ⏳ countdown has been completed! Do you continue the next?`
  String get timer_congratulation_next {
    return Intl.message(
      'Current ⏳ countdown has been completed! Do you continue the next?',
      name: 'timer_congratulation_next',
      desc: '',
      args: [],
    );
  }

  /// `No(😂)`
  String get timer_no {
    return Intl.message(
      'No(😂)',
      name: 'timer_no',
      desc: '',
      args: [],
    );
  }

  /// `Continue(👊)`
  String get timer_continue {
    return Intl.message(
      'Continue(👊)',
      name: 'timer_continue',
      desc: '',
      args: [],
    );
  }

  /// `Countdown settings`
  String get timer_settings {
    return Intl.message(
      'Countdown settings',
      name: 'timer_settings',
      desc: '',
      args: [],
    );
  }

  /// `Countdown duration`
  String get timer_duration {
    return Intl.message(
      'Countdown duration',
      name: 'timer_duration',
      desc: '',
      args: [],
    );
  }

  /// `Timing task`
  String get countdown_tasks {
    return Intl.message(
      'Timing task',
      name: 'countdown_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Add a new task`
  String get countdown_add {
    return Intl.message(
      'Add a new task',
      name: 'countdown_add',
      desc: '',
      args: [],
    );
  }

  /// `No task`
  String get countdown_empty {
    return Intl.message(
      'No task',
      name: 'countdown_empty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm that you want to delete this task of "{title}"?`
  String countdown_delete_tips(Object title) {
    return Intl.message(
      'Confirm that you want to delete this task of "$title"?',
      name: 'countdown_delete_tips',
      desc: '',
      args: [title],
    );
  }

  /// `Timing task settings`
  String get countdown_settings {
    return Intl.message(
      'Timing task settings',
      name: 'countdown_settings',
      desc: '',
      args: [],
    );
  }

  /// `Sort by the list of tasks`
  String get countdown_tasks_sort {
    return Intl.message(
      'Sort by the list of tasks',
      name: 'countdown_tasks_sort',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get tips_no {
    return Intl.message(
      'No',
      name: 'tips_no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get tips_yes {
    return Intl.message(
      'Yes',
      name: 'tips_yes',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get tips_modify {
    return Intl.message(
      'Modify',
      name: 'tips_modify',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get tips_delete {
    return Intl.message(
      'Delete',
      name: 'tips_delete',
      desc: '',
      args: [],
    );
  }

  /// `null`
  String get tips_empty {
    return Intl.message(
      'null',
      name: 'tips_empty',
      desc: '',
      args: [],
    );
  }

  /// `{year}-{month}-{day} {hour}:{minute} {weekday}`
  String date_format(Object year, Object month, Object day, Object hour, Object minute, Object weekday) {
    return Intl.message(
      '$year-$month-$day $hour:$minute $weekday',
      name: 'date_format',
      desc: '',
      args: [year, month, day, hour, minute, weekday],
    );
  }

  /// `Asc by add date`
  String get tips_sort_id_asc {
    return Intl.message(
      'Asc by add date',
      name: 'tips_sort_id_asc',
      desc: '',
      args: [],
    );
  }

  /// `Desc order by add date`
  String get tips_sort_id_desc {
    return Intl.message(
      'Desc order by add date',
      name: 'tips_sort_id_desc',
      desc: '',
      args: [],
    );
  }

  /// `Asc by task date`
  String get tips_sort_date_asc {
    return Intl.message(
      'Asc by task date',
      name: 'tips_sort_date_asc',
      desc: '',
      args: [],
    );
  }

  /// `Desc by task date`
  String get tips_sort_date_desc {
    return Intl.message(
      'Desc by task date',
      name: 'tips_sort_date_desc',
      desc: '',
      args: [],
    );
  }

  /// `Asc by date of modify`
  String get tips_sort_modify_asc {
    return Intl.message(
      'Asc by date of modify',
      name: 'tips_sort_modify_asc',
      desc: '',
      args: [],
    );
  }

  /// `Desc by date of modify`
  String get tips_sort_modify_desc {
    return Intl.message(
      'Desc by date of modify',
      name: 'tips_sort_modify_desc',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get tips_unknown {
    return Intl.message(
      'Unknown',
      name: 'tips_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get tips_monday {
    return Intl.message(
      'Monday',
      name: 'tips_monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tips_tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tips_tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get tips_wednesday {
    return Intl.message(
      'Wednesday',
      name: 'tips_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get tips_thursday {
    return Intl.message(
      'Thursday',
      name: 'tips_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get tips_friday {
    return Intl.message(
      'Friday',
      name: 'tips_friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get tips_saturday {
    return Intl.message(
      'Saturday',
      name: 'tips_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get tips_sunday {
    return Intl.message(
      'Sunday',
      name: 'tips_sunday',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get tips_app_about {
    return Intl.message(
      'About App',
      name: 'tips_app_about',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro management and study planning, mom no longer has to worry about my study! No more distractions! No more delay! Efficient! Focus! , So that everyone can be more focused when studying, and learn quickly and easily get!\n \n1. Pomodoro learning mode, using the Pomodoro Technique for learning, allowing you to combine work and rest!\n2. Timed learning mode, learn according to the set time, learn as long as you want!\n3. Timed task mode, countdown days, task records, daily learning tasks! Put an end to learning without goals! Satisfy your thirst for learning!`
  String get tips_app_desc {
    return Intl.message(
      'Pomodoro management and study planning, mom no longer has to worry about my study! No more distractions! No more delay! Efficient! Focus! , So that everyone can be more focused when studying, and learn quickly and easily get!\n \n1. Pomodoro learning mode, using the Pomodoro Technique for learning, allowing you to combine work and rest!\n2. Timed learning mode, learn according to the set time, learn as long as you want!\n3. Timed task mode, countdown days, task records, daily learning tasks! Put an end to learning without goals! Satisfy your thirst for learning!',
      name: 'tips_app_desc',
      desc: '',
      args: [],
    );
  }

  /// `Hello, iPomodoro! This is a Pomodoro time management and planning App, no longer distracted! No more delay! Efficient! Focus! A good tool for learning! iOS download: {AppStoreUrl}，Android download：Google Play Store`
  String tips_app_share_textd(Object AppStoreUrl) {
    return Intl.message(
      'Hello, iPomodoro! This is a Pomodoro time management and planning App, no longer distracted! No more delay! Efficient! Focus! A good tool for learning! iOS download: $AppStoreUrl，Android download：Google Play Store',
      name: 'tips_app_share_textd',
      desc: '',
      args: [AppStoreUrl],
    );
  }

  /// `Task`
  String get tips_task {
    return Intl.message(
      'Task',
      name: 'tips_task',
      desc: '',
      args: [],
    );
  }

  /// `Task name`
  String get tips_task_name {
    return Intl.message(
      'Task name',
      name: 'tips_task_name',
      desc: '',
      args: [],
    );
  }

  /// `Task time`
  String get tips_task_time {
    return Intl.message(
      'Task time',
      name: 'tips_task_time',
      desc: '',
      args: [],
    );
  }

  /// `Task tags`
  String get tips_task_tags {
    return Intl.message(
      'Task tags',
      name: 'tips_task_tags',
      desc: '',
      args: [],
    );
  }

  /// `'Task names and time cannot be empty!'`
  String get tips_task_empty {
    return Intl.message(
      '\'Task names and time cannot be empty!\'',
      name: 'tips_task_empty',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get tips_save {
    return Intl.message(
      'Save',
      name: 'tips_save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get tips_cancel {
    return Intl.message(
      'Cancel',
      name: 'tips_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get tips_confirm {
    return Intl.message(
      'Confirm',
      name: 'tips_confirm',
      desc: '',
      args: [],
    );
  }

  /// `To choose time`
  String get tips_select_time {
    return Intl.message(
      'To choose time',
      name: 'tips_select_time',
      desc: '',
      args: [],
    );
  }

  /// `Set brightness`
  String get set_screen_brightness {
    return Intl.message(
      'Set brightness',
      name: 'set_screen_brightness',
      desc: '',
      args: [],
    );
  }

  /// `In order to save power`
  String get set_screen_brightness_desc {
    return Intl.message(
      'In order to save power',
      name: 'set_screen_brightness_desc',
      desc: '',
      args: [],
    );
  }

  /// `In-app review`
  String get set_app_review {
    return Intl.message(
      'In-app review',
      name: 'set_app_review',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to rate {AppName}!`
  String set_app_review_desc(Object AppName) {
    return Intl.message(
      'Welcome to rate $AppName!',
      name: 'set_app_review_desc',
      desc: '',
      args: [AppName],
    );
  }

  /// `Store to review`
  String get set_appstore_review {
    return Intl.message(
      'Store to review',
      name: 'set_appstore_review',
      desc: '',
      args: [],
    );
  }

  /// `Write a review {AppName}`
  String set_appstore_review_desc(Object AppName) {
    return Intl.message(
      'Write a review $AppName',
      name: 'set_appstore_review_desc',
      desc: '',
      args: [AppName],
    );
  }

  /// `Share`
  String get set_share_friend {
    return Intl.message(
      'Share',
      name: 'set_share_friend',
      desc: '',
      args: [],
    );
  }

  /// `Learn with friends around you!`
  String get set_share_friend_desc {
    return Intl.message(
      'Learn with friends around you!',
      name: 'set_share_friend_desc',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get set_feedback {
    return Intl.message(
      'Feedback',
      name: 'set_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Needs or bugs are welcome`
  String get set_feedback_desc {
    return Intl.message(
      'Needs or bugs are welcome',
      name: 'set_feedback_desc',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get set_email_connect {
    return Intl.message(
      'Email',
      name: 'set_email_connect',
      desc: '',
      args: [],
    );
  }

  /// `Any questions, please to us`
  String get set_email_connect_desc {
    return Intl.message(
      'Any questions, please to us',
      name: 'set_email_connect_desc',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get set_privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'set_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `User Use Service Agreement`
  String get set_privacy_policy_desc {
    return Intl.message(
      'User Use Service Agreement',
      name: 'set_privacy_policy_desc',
      desc: '',
      args: [],
    );
  }

  /// `Open source`
  String get set_open_source {
    return Intl.message(
      'Open source',
      name: 'set_open_source',
      desc: '',
      args: [],
    );
  }

  /// `Open source, welcome to follow`
  String get set_open_source_desc {
    return Intl.message(
      'Open source, welcome to follow',
      name: 'set_open_source_desc',
      desc: '',
      args: [],
    );
  }

  /// `Focus more`
  String get set_focus {
    return Intl.message(
      'Focus more',
      name: 'set_focus',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to author's blog`
  String get set_focus_desc {
    return Intl.message(
      'Welcome to author\'s blog',
      name: 'set_focus_desc',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get set_recommend {
    return Intl.message(
      'More',
      name: 'set_recommend',
      desc: '',
      args: [],
    );
  }

  /// `More developer recommendations`
  String get set_recommend_desc {
    return Intl.message(
      'More developer recommendations',
      name: 'set_recommend_desc',
      desc: '',
      args: [],
    );
  }

  /// `Set Language`
  String get set_localizetion {
    return Intl.message(
      'Set Language',
      name: 'set_localizetion',
      desc: '',
      args: [],
    );
  }

  /// `Change app language`
  String get set_localizetion_desc {
    return Intl.message(
      'Change app language',
      name: 'set_localizetion_desc',
      desc: '',
      args: [],
    );
  }

  /// `You need to agree to the user privacy policy agreement to use this application, click 'agree', to continue using, if you do not agree, please exit the application.`
  String get privacy_policy_tips {
    return Intl.message(
      'You need to agree to the user privacy policy agreement to use this application, click \'agree\', to continue using, if you do not agree, please exit the application.',
      name: 'privacy_policy_tips',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get privacy_policy_agree {
    return Intl.message(
      'Agree',
      name: 'privacy_policy_agree',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Agreement`
  String get privacy_policy_show {
    return Intl.message(
      'Privacy Agreement',
      name: 'privacy_policy_show',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}