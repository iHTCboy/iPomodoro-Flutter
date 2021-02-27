import 'package:flutter/material.dart';
import 'dart:io';
import 'package:iPomodoro/common/channel/native_method_channel.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';
import 'package:iPomodoro/config/app_config.dart';
import 'package:url_launcher/url_launcher.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        //頂
        SliverAppBar(
          backgroundColor: AppColors.ME_SUB_COLOR,
          pinned: true,
          expandedHeight: DeviceUtils.get_size(context, 200, 220, 300),
          flexibleSpace: FlexibleSpaceBar(
            title: Text("爱番茄",
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
            _builder,
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

  List _list = [
    {
      'title': '设置屏幕亮度',
      'subtitle': '以便番茄时间时节省电量',
      'icon': Icons.wb_sunny_outlined,
      'icon_color': Colors.deepOrangeAccent
    },
    {
      'title': '应用内评分',
      'subtitle': '欢迎给${AppConfig.AppName}打评分!',
      'icon': Icons.star,
      'icon_color': Colors.orangeAccent
    },
    {
      'title': '去商店评分',
      'subtitle': '欢迎给${AppConfig.AppName}写评论!',
      'icon': Icons.storefront,
      'icon_color': Colors.blue
    },
    {
      'title': '分享给好友',
      'subtitle': '与身边的好友一起学习！',
      'icon': Icons.share_outlined,
      'icon_color': Colors.greenAccent
    },
    {
      'title': '反馈和建议',
      'subtitle': '欢迎提需求或bug问题',
      'icon': Icons.app_registration,
      'icon_color': Colors.amberAccent
    },
    {
      'title': '邮件联系',
      'subtitle': '如有问题欢迎来信',
      'icon': Icons.email_outlined,
      'icon_color': Colors.blueAccent
    },
    {
      'title': '隐私条款',
      'subtitle': '用户使用服务协议',
      'icon': Icons.privacy_tip_outlined,
      'icon_color': Colors.redAccent
    },
    {
      'title': '开源地址',
      'subtitle': '现已开放代码，欢迎关注',
      'icon': Icons.public,
      'icon_color': Colors.green
    },
    {
      'title': '更多关注',
      'subtitle': '欢迎访问作者博客',
      'icon': Icons.leak_add_outlined,
      'icon_color': Colors.lightBlue
    },
    {
      'title': '更多推荐',
      'subtitle': '更多开发者内容推荐',
      'icon': Icons.apps,
      'icon_color': Colors.deepPurpleAccent
    },
    {
      'title': '关于应用',
      'subtitle': '${AppConfig.AppName}',
      'icon': Icons.bookmark_border,
      'icon_color': Colors.teal
    },
  ];

  Widget _builder(BuildContext context, index) {
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
        NativeChannel.requestReview();
        break;
      case 2:
        if (is_iOS(context)) {
          openURL(AppConfig.AppAppStoreUrl);
        } else {
          NativeChannel.gotoStoreReview();
        }
        break;
      case 3:
        NativeChannel.shareApp();
        break;
      case 4:
        if (is_iOS(context)) {
          openURL(AppConfig.AppAppStoreUrl + AppConfig.AppAppStoreReviewAction);
        } else {
          NativeChannel.gotoStoreReview();
        }
        break;
      case 5:
        NativeChannel.emailConnect();
        break;
      case 6:
        openURL(AppConfig.AppLicenseUrl);
        break;
      case 7:
        openURL(AppConfig.AppGitHubUrl);
        break;
      case 8:
        openURL(AppConfig.kiHTCboyUrl);
        break;
      case 9:
        if (is_iOS(context)) {
          NativeChannel.moreLearn();
        } else {
          openURL(AppConfig.kiHTCboyer);
        }
        break;
      case 10:
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
