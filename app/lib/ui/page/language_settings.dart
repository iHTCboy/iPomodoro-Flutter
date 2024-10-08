import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/generated/l10n.dart';

class LanguageSettings extends StatefulWidget {
  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  String groupValue = 'en';

  @override
  void initState() {
    super.initState();
    _init_storage();
  }

  void _init_storage() {
    AppStorage.getString(AppStorage.K_STRING_LANGUAGE_SETTINGS).then((value) {
      setState(() {
        //String languageCode = DeviceUtils.languageCode();
        groupValue = value ?? 'en';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).set_localizetion, style: TextStyle(color: Colors.white)),
        foregroundColor: Colors.white,
        backgroundColor: AppColors.ME_MAIN_COLOR, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: ListView(
        children: [
          RadioListTile<String>(
            title: Text('中文'),
            value: 'zh',
            groupValue: groupValue,
            onChanged: _changed,
          ),
          Divider(height: 1),
          RadioListTile<String>(
              title: Text('English'),
              value: 'en',
              groupValue: groupValue,
              onChanged: _changed),
        ],
      ),
    );
  }

  void _changed(value) {
    if (value != null) {
      AppStorage.setString(AppStorage.K_STRING_LANGUAGE_SETTINGS, value);
      setState(() {
        groupValue = value;
        if (value == "zh") S.load(Locale('zh', ''));
        if (value == "en") S.load(Locale('en', 'US'));
      });
    }
  }
}
