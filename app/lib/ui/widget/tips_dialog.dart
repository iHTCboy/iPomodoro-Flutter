import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iPomodoro/common/utils/device_utils.dart';


class TipsDialog extends Dialog {
  final Color backgroundColor;

  TipsDialog({this.backgroundColor=const Color(0xFFD74A49)});

  static const notifications = ['请自重！', '回去学习！', '亲，不要玩手机~', '童鞋，请不要分心。',
  '你在玩手机，别人在学习。', ' 好好学习，你还有救！', '坚持一会儿！你可以的！', '为了自己，请好好学习！',
  '有事者，事竟成！', '苦心人，天不负！', '再试一次，一定会比刚才更好！', '别害怕！番茄支持你！', '别把你的聪明藏起来！',
  '我们这个世界，从不会给一个伤心的落伍者颁发奖牌！', '为今天的表现感到骄傲？', '学习如逆水行舟，不进则退！',
    '一切困难都是前进的动力！', '可以望见远的目标，却不能代替你走半步~', '再好的种子，不播种下去，也结不出丰硕的果实。',
    '有种快乐叫，不放弃！', '不用害怕，年轻叫你勇敢！', '生活其实很简单，过了今天就是明天', '年轻不是你玩的理由，而是你奋斗的资本。',
  '只要努力，你也会拥有!', '状态是干出来的，而不是等出来的!', '要随波逐浪，不可随波逐流', '每个人最终和自己越长越像',
  '一个人害怕的事，往往是他应该做的事。', '据测算，还可以退五十步，但生活只有五步', '接受鄙视？'];

  static String get_tips() {
    return notifications[Random().nextInt(notifications.length)];
  }

  /*
  请自重！
  滚去学习！
  亲，不要玩手机~
  童鞋，请不要分心。
  你在玩手机，别人在学习。
  */
  List tips = ['请不要\n放弃治疗！\n好好学习\n你还有救！',
               '为了梦想，\n为了自己，\n请好好学习。',
               '不好好学习，\n一辈子单身！',
               '下次请好好学习，\n不要玩手机！',
               '玩手机？\n不好好学习？\n对得起父母吗！\n对得起自己吗！',
               '再坚持一会儿！\n你可以的！\n加油！',
               '不积跬步，\n无以至千里；\n不积小流，\n无以成江海。\n\n荀子《劝学》',
               '锲而舍之，\n朽木不折；\n锲而不舍，\n金石可镂。\n\n荀子《劝学》',
               '不登高山，\n不知天之高也；\n不临深溪，\n不知地之厚也。\n\n荀子《劝学》',
               '不积跬步，\n无以至千里；\n不积小流，\n无以成江海。\n\n荀子《劝学》',
               '问渠那得清如许，\n为有源头活水来。\n\n—— 朱熹',
               '读书有三到，\n谓心到，\n眼到，\n口到。\n\n—— 朱熹',
               '业精于勤，\n荒于嬉；\n行成于思，\n毁于随。\n\n—— 韩愈',
               '书山有路勤为径，\n学海无涯苦作舟。\n\n—— 韩愈',
               '盛年不重来，\n一日难再晨。\n及时当勉励，\n岁月不待人。\n\n—— 陶渊明',
               '莫等闲，\n白了少年头，\n空悲切。\n\n—— 岳飞',
               '千里之行，\n始于足下。\n\n—— 老子',
               '读万卷书，\n行万里路。\n\n—— 刘彝',
               '读书破万卷，\n下笔如有神。\n\n—— 杜甫',
               '学而不思则罔，\n思而不学则殆。\n\n—— 孔子',
               '发奋识遍天下字，\n立志读尽人间书。\n\n—— 苏轼',
               '书到用时方恨少，\n事非经过不知难。\n\n—— 陆游',
               '纸上得来终觉浅，\n绝知此事要躬行。\n\n—— 陆游',
               '黑发不知勤学早，\n白发方悔读书迟。\n\n—— 颜真卿',
               '立身以立学为先，\n立学以读书为本。\n\n—— 欧阳修',
               '路漫漫其修道远，\n吾将上下而求索。\n\n—— 屈原',
               '玉不琢，\n不成器，\n人不学，\n不知道。\n\n《礼记·学记》',
               '熟读唐诗三百首，\n不会作诗也会吟。\n\n孙洙\n《唐诗三百首序》',
               '少壮不努力，\n老大徒伤悲。\n\n《汉乐府·长歌行》',
               '勿以恶小而为之，\n勿以善小而不为。\n\n陈寿《三国志》',
               '一寸光阴一寸金，\n寸金难买寸光阴。\n\n《增广贤文》',
               '宝剑锋从磨砺出，\n梅花香自苦寒来。\n\n《警世贤文·勤奋篇》',
               '吃得苦中苦，\n方为人上人。\n\n—— 《官场现形记》',
              ];

  List btnTexts = ['知道了', '明白了', '放飞梦想', '勇于开拓', '青春无悔',
    '继续加油', '重新开始', '接受挑战', '奋发图强', '悬梁刺股', '夕寐宵兴', '文韬武略', '笑傲群芳',
    '整旅厉卒', '学无止境', '鸡鸣而起', '搦朽磨钝', '全力以赴', '立志成材', '突破极限', '矢志不渝',
    '斗志昂扬', '勤能补拙', '勤学好问', '手不释书', '发愤忘食', '孜孜不倦', '笃志好学', '闻鸡起舞',
    '手不释卷', '坚持不懈', '马到成功', '勇往直前', '再接再厉', '愚公移山', '磨杵作针', '披荆斩棘',
    '意气风发', '斗志昂扬', '壮志凌云', '自律自强', '青春无畏', '超越自我', '努力拼搏', '飞跃梦想',
  ];
  
  List fonts = [
    'Noto_Sans_TC',
    'Ma_Shan_Zheng',
    'ChakraPetch',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: backgroundColor,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    tips[Random().nextInt(tips.length)],
                    style: TextStyle(
                      fontSize: DeviceUtils.get_size(context, 35, 45, 65),
                      height: 1.3,
                      letterSpacing: 5,
                      fontFamily: fonts[Random().nextInt(fonts.length)],
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size(155, 46),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        side: BorderSide(width: 1.5, color: Colors.white),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(23)),
                        ),
                      ),
                      child: Text(
                        btnTexts[Random().nextInt(btnTexts.length)],
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
              ),
            ],
          )),
    );
  }
}
