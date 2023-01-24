// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static m0(title) => "确认要删除“${title}”这个任务吗？";

  static m1(year, month, day, hour, minute, weekday) => "${year}年${month}月${day}日 ${hour}:${minute} ${weekday}";

  static m2(pomodoro_hours, pomodoro_minutes) => "${pomodoro_hours}小时${pomodoro_minutes}分钟";

  static m3(pomodoro_time) => "${pomodoro_time}分钟";

  static m4(x_pomodoro) => "已经完成第${x_pomodoro}个番茄钟，休息一会，☕️补充能量吧️！";

  static m5(x_pomodoro) => "开始第${x_pomodoro}个🍅番茄时间啦!";

  static m6(pomodoro_times) => "${pomodoro_times}个番茄时间";

  static m7(AppName) => "欢迎给${AppName}打评分!";

  static m8(AppName) => "欢迎给${AppName}写评论!";

  static m9(AppStoreUrl) => "Hello, 爱番茄(iPomodoro)! 这是一款番茄时间管理规划的App，不再分心！不再拖延！高效！专注！学习必备的好工具哦！iOS下载：${AppStoreUrl}，Android 下载：Google Play Store";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "about_me" : MessageLookupByLibrary.simpleMessage("关于我"),
    "alarm_sound" : MessageLookupByLibrary.simpleMessage("倒计时结束铃声"),
    "background_push_tips" : MessageLookupByLibrary.simpleMessage("允许后台推送提醒"),
    "break_time" : MessageLookupByLibrary.simpleMessage("🍌 休息时间.."),
    "continue_button" : MessageLookupByLibrary.simpleMessage("继续"),
    "countdown" : MessageLookupByLibrary.simpleMessage("倒计时"),
    "countdown_add" : MessageLookupByLibrary.simpleMessage("添加新任务"),
    "countdown_delete_tips" : m0,
    "countdown_empty" : MessageLookupByLibrary.simpleMessage("无任务"),
    "countdown_settings" : MessageLookupByLibrary.simpleMessage("定时任务设置"),
    "countdown_tasks" : MessageLookupByLibrary.simpleMessage("定时任务"),
    "countdown_tasks_sort" : MessageLookupByLibrary.simpleMessage("任务列表的排序"),
    "date_format" : m1,
    "days" : MessageLookupByLibrary.simpleMessage("天"),
    "give_up_button" : MessageLookupByLibrary.simpleMessage("放弃"),
    "hours" : MessageLookupByLibrary.simpleMessage("时"),
    "iPomodoro" : MessageLookupByLibrary.simpleMessage("爱番茄"),
    "learn_time" : MessageLookupByLibrary.simpleMessage("🍅 学习中.."),
    "minutes" : MessageLookupByLibrary.simpleMessage("分"),
    "pause_button" : MessageLookupByLibrary.simpleMessage("暂停"),
    "play_clock_ticking_sound" : MessageLookupByLibrary.simpleMessage("倒计时背景声"),
    "pomodoro" : MessageLookupByLibrary.simpleMessage("番茄钟"),
    "pomodoro_duration" : MessageLookupByLibrary.simpleMessage("每个番茄学习时间"),
    "pomodoro_give_up_tips" : MessageLookupByLibrary.simpleMessage("确认要放弃当前🍅番茄时间吗？"),
    "pomodoro_hours_minutes" : m2,
    "pomodoro_logn_break_delay" : MessageLookupByLibrary.simpleMessage("超长休息时间个数"),
    "pomodoro_long_break_duration" : MessageLookupByLibrary.simpleMessage("每个番茄休息时间(长)"),
    "pomodoro_minutes" : m3,
    "pomodoro_next_break" : m4,
    "pomodoro_next_times" : m5,
    "pomodoro_no" : MessageLookupByLibrary.simpleMessage("否(💪)"),
    "pomodoro_ok" : MessageLookupByLibrary.simpleMessage("好✊"),
    "pomodoro_push_tips" : MessageLookupByLibrary.simpleMessage("番茄君提醒🍅！"),
    "pomodoro_settings" : MessageLookupByLibrary.simpleMessage("番茄设置"),
    "pomodoro_short_break_duration" : MessageLookupByLibrary.simpleMessage("每个番茄休息时间(短)"),
    "pomodoro_time" : MessageLookupByLibrary.simpleMessage("🍅 番茄学习"),
    "pomodoro_times" : m6,
    "pomodoro_yes" : MessageLookupByLibrary.simpleMessage("是(😭)"),
    "privacy_policy_agree" : MessageLookupByLibrary.simpleMessage("同意"),
    "privacy_policy_reject" : MessageLookupByLibrary.simpleMessage("拒绝"),
    "privacy_policy_tips" : MessageLookupByLibrary.simpleMessage("需要同意《用户隐私政策协议》才能继续使用，点击可查看协议内容；点击“同意”按钮表示同意隐私协议继续使用；如不同意，请点击“拒绝”退出应用。"),
    "set_app_review" : MessageLookupByLibrary.simpleMessage("应用内评分"),
    "set_app_review_desc" : m7,
    "set_appstore_review" : MessageLookupByLibrary.simpleMessage("去商店评分"),
    "set_appstore_review_desc" : m8,
    "set_email_connect" : MessageLookupByLibrary.simpleMessage("邮件联系"),
    "set_email_connect_desc" : MessageLookupByLibrary.simpleMessage("如有问题欢迎来信"),
    "set_feedback" : MessageLookupByLibrary.simpleMessage("反馈和建议"),
    "set_feedback_desc" : MessageLookupByLibrary.simpleMessage("欢迎提需求或bug问题"),
    "set_focus" : MessageLookupByLibrary.simpleMessage("更多关注"),
    "set_focus_desc" : MessageLookupByLibrary.simpleMessage("欢迎访问作者博客"),
    "set_localizetion" : MessageLookupByLibrary.simpleMessage("设置显示语言"),
    "set_localizetion_desc" : MessageLookupByLibrary.simpleMessage("更改App的语言"),
    "set_open_source" : MessageLookupByLibrary.simpleMessage("开源地址"),
    "set_open_source_desc" : MessageLookupByLibrary.simpleMessage("现已开放代码，欢迎关注"),
    "set_privacy_policy" : MessageLookupByLibrary.simpleMessage("隐私条款"),
    "set_privacy_policy_desc" : MessageLookupByLibrary.simpleMessage("用户使用服务协议"),
    "set_recommend" : MessageLookupByLibrary.simpleMessage("更多推荐"),
    "set_recommend_desc" : MessageLookupByLibrary.simpleMessage("更多开发者内容推荐"),
    "set_screen_brightness" : MessageLookupByLibrary.simpleMessage("设置屏幕亮度"),
    "set_screen_brightness_desc" : MessageLookupByLibrary.simpleMessage("以便番茄时间时节省电量"),
    "set_share_friend" : MessageLookupByLibrary.simpleMessage("分享给好友"),
    "set_share_friend_desc" : MessageLookupByLibrary.simpleMessage("与身边的好友一起学习！"),
    "start_button" : MessageLookupByLibrary.simpleMessage("开始"),
    "switch_off" : MessageLookupByLibrary.simpleMessage("关"),
    "switch_on" : MessageLookupByLibrary.simpleMessage("开"),
    "tasks" : MessageLookupByLibrary.simpleMessage("定任务"),
    "timer_congratulation_next" : MessageLookupByLibrary.simpleMessage("当前⏳倒计时已经完成！是否继续下一个？"),
    "timer_continue" : MessageLookupByLibrary.simpleMessage("继续(👊)"),
    "timer_duration" : MessageLookupByLibrary.simpleMessage("每个倒计时的时长"),
    "timer_give_up_tips" : MessageLookupByLibrary.simpleMessage("确认要放弃当前⏳倒计时吗？"),
    "timer_learn" : MessageLookupByLibrary.simpleMessage("计时学习"),
    "timer_learn_tips" : MessageLookupByLibrary.simpleMessage("⌛ 倒计时学习"),
    "timer_learning" : MessageLookupByLibrary.simpleMessage("⏳ 学习中.."),
    "timer_no" : MessageLookupByLibrary.simpleMessage("否(😂)"),
    "timer_push_tips" : MessageLookupByLibrary.simpleMessage("计时君提醒⏳！"),
    "timer_settings" : MessageLookupByLibrary.simpleMessage("倒计时设置"),
    "tips_app_about" : MessageLookupByLibrary.simpleMessage("关于应用"),
    "tips_app_desc" : MessageLookupByLibrary.simpleMessage("番茄时间管理和学习规划，妈妈再也不用担心我的学习啦！不再分心！不再拖延！高效！专注！，让大家在学习时可以更加专注也可以快速和简单的学习get! \n \n1、番茄学习模式，使用番茄工作法学习，让你劳逸结合！\n2、计时学习模式，按照设定的时长学习，想学多久就学多久！\n3、定时任务模式，倒数日、任务记录，每日学习任务！杜绝学习没有目标！满足你对学习的求知欲望！"),
    "tips_app_share_textd" : m9,
    "tips_cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "tips_come_on" : MessageLookupByLibrary.simpleMessage("加油"),
    "tips_confirm" : MessageLookupByLibrary.simpleMessage("确认"),
    "tips_congratulation" : MessageLookupByLibrary.simpleMessage("恭喜"),
    "tips_delete" : MessageLookupByLibrary.simpleMessage("删除"),
    "tips_empty" : MessageLookupByLibrary.simpleMessage("无"),
    "tips_friday" : MessageLookupByLibrary.simpleMessage("周五"),
    "tips_modify" : MessageLookupByLibrary.simpleMessage("修改"),
    "tips_monday" : MessageLookupByLibrary.simpleMessage("周一"),
    "tips_no" : MessageLookupByLibrary.simpleMessage("否"),
    "tips_saturday" : MessageLookupByLibrary.simpleMessage("周六"),
    "tips_save" : MessageLookupByLibrary.simpleMessage("保存"),
    "tips_select_time" : MessageLookupByLibrary.simpleMessage("选择时间"),
    "tips_sort_date_asc" : MessageLookupByLibrary.simpleMessage("按任务日期升序"),
    "tips_sort_date_desc" : MessageLookupByLibrary.simpleMessage("按任务日期降序"),
    "tips_sort_id_asc" : MessageLookupByLibrary.simpleMessage("按新增日期升序"),
    "tips_sort_id_desc" : MessageLookupByLibrary.simpleMessage("按新增日期降序"),
    "tips_sort_modify_asc" : MessageLookupByLibrary.simpleMessage("按修改日期升序"),
    "tips_sort_modify_desc" : MessageLookupByLibrary.simpleMessage("按修改日期降序"),
    "tips_sunday" : MessageLookupByLibrary.simpleMessage("周日"),
    "tips_task" : MessageLookupByLibrary.simpleMessage("任务"),
    "tips_task_empty" : MessageLookupByLibrary.simpleMessage("\'任务名字和时间不能为空！\'"),
    "tips_task_name" : MessageLookupByLibrary.simpleMessage("任务名称"),
    "tips_task_tags" : MessageLookupByLibrary.simpleMessage("任务备注"),
    "tips_task_time" : MessageLookupByLibrary.simpleMessage("任务时间"),
    "tips_text" : MessageLookupByLibrary.simpleMessage("提示"),
    "tips_thursday" : MessageLookupByLibrary.simpleMessage("周四"),
    "tips_tuesday" : MessageLookupByLibrary.simpleMessage("周二"),
    "tips_unknown" : MessageLookupByLibrary.simpleMessage("未知"),
    "tips_wednesday" : MessageLookupByLibrary.simpleMessage("周三"),
    "tips_yes" : MessageLookupByLibrary.simpleMessage("是")
  };
}
