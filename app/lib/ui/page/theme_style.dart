import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';

enum ThemeStylePageType {
  Pomodoro,
  Timer,
  Countdown,
}

class ThemeStyleSettingsPage extends StatefulWidget {
  final ThemeStylePageType pageType;

  ThemeStyleSettingsPage(
      {Key key = const Key('ThemeStyleSettingsPage'),
      this.pageType = ThemeStylePageType.Pomodoro})
      : super(key: key);

  @override
  _ThemeStyleSettingsPageState createState() => _ThemeStyleSettingsPageState();
}

class _ThemeStyleSettingsPageState extends State<ThemeStyleSettingsPage> {
  late ThemeStylePageType pageType;
  late Color titleBarColor = Colors.white10;
  late Color backgroundColor = Colors.white10;

  @override
  void initState() {
    super.initState();
    pageType = widget.pageType;
    _init_storage();
  }

  void _init_storage() {
    switch (pageType) {
      case ThemeStylePageType.Pomodoro:
        AppStorage.getInt(AppStorage.K_STRING_POMODORO_TITLE_BAR_COLOR)
            .then((value) {
          setState(() {
            titleBarColor =
                value != null ? Color(value) : AppColors.PRIMARY_MAIN_COLOR;
          });
        });
        AppStorage.getInt(AppStorage.K_STRING_POMODORO_BACKGROUND_COLOR)
            .then((value) {
          setState(() {
            backgroundColor =
                value != null ? Color(value) : AppColors.PRIMARY_SUB_COLOR;
          });
        });
      case ThemeStylePageType.Timer:
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
      case ThemeStylePageType.Countdown:
        AppStorage.getInt(AppStorage.K_STRING_COUNTDOWN_TITLE_BAR_COLOR)
            .then((value) {
          setState(() {
            titleBarColor =
                value != null ? Color(value) : AppColors.COUNTDOWN_MAIN_COLOR;
          });
        });
        AppStorage.getInt(AppStorage.K_STRING_COUNTDOWN_BACKGROUND_COLOR)
            .then((value) {
          setState(() {
            backgroundColor =
                value != null ? Color(value) : AppColors.COUNTDOWN_SUB_COLOR;
          });
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).theme_style_title, style: TextStyle(color: Colors.white)),
          foregroundColor: Colors.white,
          backgroundColor: titleBarColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: []),
      body: Container(
        alignment: Alignment.center,
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: _pressed_nave_color,
                child: Text(S.of(context).theme_style_title_bar_color),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(
                      DeviceUtils.get_size(context, 135, 155, 200),
                      DeviceUtils.get_size(context, 40, 44, 65)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  side: BorderSide(width: 1.5, color: Colors.white),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                )),
            SizedBox(height: DeviceUtils.get_size(context, 10, 15, 60)),
            TextButton(
                onPressed: _pressed_bg_color,
                child: Text(S.of(context).theme_style_title_background_color),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(
                      DeviceUtils.get_size(context, 135, 155, 200),
                      DeviceUtils.get_size(context, 40, 44, 65)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  side: BorderSide(width: 1.5, color: Colors.white),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                )),
            SizedBox(height: DeviceUtils.get_size(context, 10, 15, 60)),
            TextButton(
                onPressed: _pressed_default_color,
                child: Text(S.of(context).theme_style_default_color),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(
                      DeviceUtils.get_size(context, 135, 155, 200),
                      DeviceUtils.get_size(context, 40, 44, 65)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  side: BorderSide(width: 1.5, color: Colors.white),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                )),
            SizedBox(height: DeviceUtils.get_size(context, 10, 15, 60)),
            TextButton(
                onPressed: _pressed_save_color,
                child: Text(S.of(context).theme_style_save_color),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(
                      DeviceUtils.get_size(context, 135, 155, 200),
                      DeviceUtils.get_size(context, 40, 44, 65)),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  side: BorderSide(width: 1.5, color: Colors.white),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _pressed_nave_color() async {
    Color newColor = await colorPickerDialog(titleBarColor);
    setState(() {
      titleBarColor = newColor;
    });
  }

  void _pressed_bg_color() async {
    Color newColor = await colorPickerDialog(backgroundColor);
    setState(() {
      backgroundColor = newColor;
    });
  }

  void _pressed_default_color() {
    setState(() {
      switch (pageType) {
        case ThemeStylePageType.Pomodoro:
          titleBarColor = AppColors.PRIMARY_MAIN_COLOR;
          backgroundColor = AppColors.PRIMARY_SUB_COLOR;
        case ThemeStylePageType.Timer:
          titleBarColor = AppColors.TIMER_MAIN_COLOR;
          backgroundColor = AppColors.TIMER_SUB_COLOR;
        case ThemeStylePageType.Countdown:
          titleBarColor = AppColors.COUNTDOWN_MAIN_COLOR;
          backgroundColor = AppColors.COUNTDOWN_SUB_COLOR;
      }
    });
  }

  void _pressed_save_color() async {
    switch (pageType) {
      case ThemeStylePageType.Pomodoro:
        AppStorage.setInt(
            AppStorage.K_STRING_POMODORO_TITLE_BAR_COLOR, titleBarColor.value);
        AppStorage.setInt(AppStorage.K_STRING_POMODORO_BACKGROUND_COLOR,
            backgroundColor.value);
      case ThemeStylePageType.Timer:
        AppStorage.setInt(
            AppStorage.K_STRING_TIMER_TITLE_BAR_COLOR, titleBarColor.value);
        AppStorage.setInt(
            AppStorage.K_STRING_TIMER_BACKGROUND_COLOR, backgroundColor.value);
      case ThemeStylePageType.Countdown:
        AppStorage.setInt(
            AppStorage.K_STRING_COUNTDOWN_TITLE_BAR_COLOR, titleBarColor.value);
        AppStorage.setInt(AppStorage.K_STRING_COUNTDOWN_BACKGROUND_COLOR,
            backgroundColor.value);
    }

    Navigator.pop(context, [titleBarColor, backgroundColor]);
  }

  Future<Color> colorPickerDialog(dialogSelectColor) async {
    // Wait for the dialog to return color selection result.
    Color newColor = await showColorPickerDialog(
      // The dialog needs a context, we pass it in.
      context,
      // We use the dialogSelectColor, as its starting color.
      dialogSelectColor,
      title: Text('ColorPicker', style: Theme.of(context).textTheme.titleLarge),
      width: 40,
      height: 40,
      spacing: 0,
      runSpacing: 0,
      borderRadius: 0,
      wheelDiameter: 165,
      enableOpacity: true,
      showColorCode: true,
      colorCodeHasColor: true,
      pickersEnabled: <ColorPickerType, bool>{
        ColorPickerType.wheel: true,
      },
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        copyButton: false,
        pasteButton: false,
        longPressMenu: true,
      ),
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true,
        dialogActionButtons: false,
      ),
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 320, maxWidth: 380),
    );

    return newColor;
  }
}
