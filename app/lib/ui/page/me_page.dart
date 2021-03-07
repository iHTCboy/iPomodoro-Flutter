import 'package:flutter/material.dart';
import 'dart:io';
import 'package:iPomodoro/common/channel/native_method_channel.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/config/app_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iPomodoro/generated/l10n.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List _list = [
      {
        'title': S.of(context).set_screen_brightness,
        'subtitle': S.of(context).set_screen_brightness_desc,
        'icon': Icons.wb_sunny_outlined,
        'icon_color': Colors.deepOrangeAccent
      },
      {
        'title': S.of(context).set_localizetion,
        'subtitle': S.of(context).set_localizetion_desc,
        'icon': Icons.language,
        'icon_color': Colors.indigo
      },
      {
        'title': S.of(context).set_app_review,
        'subtitle': S.of(context).set_app_review_desc('${AppConfig.AppName}'),
        'icon': Icons.star,
        'icon_color': Colors.orangeAccent
      },
      {
        'title': S.of(context).set_appstore_review,
        'subtitle': S.of(context).set_appstore_review_desc('${AppConfig.AppName}'),
        'icon': Icons.storefront,
        'icon_color': Colors.blue
      },
      {
        'title': S.of(context).set_share_friend,
        'subtitle': S.of(context).set_share_friend_desc,
        'icon': Icons.share_outlined,
        'icon_color': Colors.greenAccent
      },
      {
        'title': S.of(context).set_feedback,
        'subtitle': S.of(context).set_feedback_desc,
        'icon': Icons.app_registration,
        'icon_color': Colors.amberAccent
      },
      {
        'title': S.of(context).set_email_connect,
        'subtitle': S.of(context).set_email_connect_desc,
        'icon': Icons.email_outlined,
        'icon_color': Colors.blueAccent
      },
      {
        'title': S.of(context).set_privacy_policy,
        'subtitle': S.of(context).set_privacy_policy_desc,
        'icon': Icons.privacy_tip_outlined,
        'icon_color': Colors.redAccent
      },
      {
        'title': S.of(context).set_open_source,
        'subtitle': S.of(context).set_open_source_desc,
        'icon': Icons.public,
        'icon_color': Colors.green
      },
      {
        'title': S.of(context).set_focus,
        'subtitle': S.of(context).set_focus_desc,
        'icon': Icons.leak_add_outlined,
        'icon_color': Colors.lightBlue
      },
      {
        'title': S.of(context).set_recommend,
        'subtitle': S.of(context).set_recommend_desc,
        'icon': Icons.apps,
        'icon_color': Colors.deepPurpleAccent
      },
      {
        'title': S.of(context).tips_app_about,
        'subtitle': '${AppConfig.AppName}',
        'icon': Icons.bookmark_border,
        'icon_color': Colors.teal
      },
    ];

    return CustomScrollView(
      slivers: [
        //頂
        SliverAppBar(
          pinned: true,
          centerTitle: true,
          brightness: Brightness.dark,
          backgroundColor: AppColors.ME_SUB_COLOR,
          expandedHeight: DeviceUtils.get_size(context, 200, 220, 300),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(S.of(context).iPomodoro,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            background: Container(
              padding: EdgeInsets.all(60),
              child: Image.asset("assets/images/app_logo.png",
                  fit: BoxFit.contain),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _builder(context, index, _list);
            },
            childCount: _list.length,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return new Container(height: 80.0);
            },
            childCount: 1,
          ),
        )
      ],
    );
  }

  Widget _builder(BuildContext context, index, List _list) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: AppColors.isDarkMode(context)
                    ? Colors.white10
                    : Colors.black12,
                width: 1)),
      ),
      child: ListTile(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(_list[index]['icon'], color: _list[index]['icon_color']),
              SizedBox(width: 10),
              Text(_list[index]['title'],
                  style: TextStyle(
                      fontSize: DeviceUtils.get_size(context, 16, 18, 22))),
            ]),
        trailing: Container(
            height: double.infinity,
            width: DeviceUtils.get_size(context, 200, 220, 250),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(_list[index]['subtitle'],
                    style: TextStyle(
                        color: AppColors.isDarkMode(context) ? Colors.white24 : Colors.black54,
                        fontSize: DeviceUtils.get_size(context, 12, 14, 18))),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            )),
        onTap: () {
          _pressed_row_item(context, index);
        },
      ),
    );
  }

  void _pressed_row_item(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamed('/brightness_settings');
        break;
      case 1:
        Navigator.of(context).pushNamed('/language_settings');
        break;
      case 2:
        NativeChannel.requestReview();
        break;
      case 3:
        if (is_iOS(context)) {
          openURL(AppConfig.AppAppStoreUrl);
        } else {
          NativeChannel.gotoStoreReview();
        }
        break;
      case 4:
        NativeChannel.shareApp(AppConfig.AppAppStoreUrl, S.of(context).tips_app_share_textd(AppConfig.AppAppStoreUrl));
        break;
      case 5:
        if (is_iOS(context)) {
          openURL(AppConfig.AppAppStoreUrl + AppConfig.AppAppStoreReviewAction);
        } else {
          NativeChannel.gotoStoreReview();
        }
        break;
      case 6:
        NativeChannel.emailConnect(AppConfig.AppName, AppConfig.kEmail);
        break;
      case 7:
        if (is_iOS(context)) {
          openURL(AppConfig.AppLicenseUrl);
        } else {
          NativeChannel.invokeMethod('privacy_policy');
        }
        break;
      case 8:
        openURL(AppConfig.AppGitHubUrl);
        break;
      case 9:
        openURL(AppConfig.kiHTCboyUrl);
        break;
      case 10:
        if (is_iOS(context)) {
          NativeChannel.moreLearn();
        } else {
          openURL(AppConfig.kiHTCboyer);
        }
        break;
      case 11:
        Navigator.of(context).pushNamed('/app_about');
        break;
    }
  }

  bool is_iOS(BuildContext context) {
    return Platform.isIOS;
  }

  void openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
