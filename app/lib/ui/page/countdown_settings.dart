import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/ui/page/theme_style.dart';
import 'package:iPomodoro/ui/widget/custom_picker.dart';

class CountdownSettingsPage extends StatefulWidget {
  @override
  _CountdownSettingsPageState createState() => _CountdownSettingsPageState();
}

class _CountdownSettingsPageState extends State<CountdownSettingsPage> {
  int _order_index = 0;
  String _order_key = '';
  List<String> sort_list = [];
  late Color titleBarColor = AppColors.COUNTDOWN_MAIN_COLOR;

  @override
  void initState() {
    super.initState();
    _init_storage();
    _set_color();
  }

  void _init_storage() {

    AppStorage.getInt(AppStorage.K_STRING_COUNTDOWN_ORDER_INDEX).then((value) {
      setState(() {
        sort_list = [
          S.of(context).tips_sort_id_asc,
          S.of(context).tips_sort_id_desc,
          S.of(context).tips_sort_date_asc,
          S.of(context).tips_sort_date_desc,
          S.of(context).tips_sort_modify_asc,
          S.of(context).tips_sort_modify_desc
        ];

        _order_index = value ?? 0;
        _order_key = sort_list[_order_index];
      });
    });
  }

  void _set_color() {
    AppStorage.getInt(AppStorage.K_STRING_COUNTDOWN_TITLE_BAR_COLOR)
        .then((value) {
      setState(() {
        titleBarColor =
        value != null ? Color(value) : AppColors.COUNTDOWN_MAIN_COLOR;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).countdown_settings, style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        backgroundColor: titleBarColor, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              '⛓',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).countdown_tasks_sort,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 130, 140, 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${_order_key}',
                        style: TextStyle(
                            color: AppColors.TIMER_SUB_COLOR,
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
              '⚙️',
              style: TextStyle(
                  fontSize: DeviceUtils.get_size(context, 25, 30, 35)),
            ),
            title: Text(S.of(context).theme_style_title,
                style: TextStyle(
                    fontSize: DeviceUtils.get_size(context, 17, 19, 22))),
            trailing: Container(
                height: double.infinity,
                width: DeviceUtils.get_size(context, 120, 120, 180),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                )),
            onTap: _pressed_theme_style,
          ),
          Divider(height: 1),
        ],
      ),
    );
  }

  void _pressed_pomodoro_item() {
    CustomPicker().show(context, sort_list, _order_index, (position) {
      setState(() {
        _order_index = position;
        _order_key = sort_list[position];
      });
    }, looping: false).then((value) {
      setState(() {
        _order_index = value;
        _order_key = sort_list[value];
      });
      AppStorage.setInt(AppStorage.K_STRING_COUNTDOWN_ORDER_INDEX, value);
    });
  }

  void _pressed_theme_style() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThemeStyleSettingsPage(pageType: ThemeStylePageType.Countdown),
      ),
    ).then((value) {
      _set_color();
    });
  }

}
