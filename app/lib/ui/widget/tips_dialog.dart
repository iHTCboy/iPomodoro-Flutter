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
               '玩手机？\n不好好学习？\n对得起自己吗！\n对得起家人吗！',
               '再坚持一会儿！\n你可以的！\n加油！',
               '不积跬步，\n无以至千里；\n不积小流，\n无以成江海。\n\n荀子《劝学》',
               '锲而舍之，\n朽木不折；\n锲而不舍，\n金石可镂。\n\n荀子《劝学》',
               '不登高山，\n不知天之高也；\n不临深溪，\n不知地之厚也。\n\n荀子《劝学》',
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
               '少年易学老难成，\n一寸光阴不可轻。\n\n—— 朱熹',
               '敏而好学，\n不耻下问。\n\n—— 孔子',
               '莫愁前路无知已，\n天下谁人不识君。\n\n—— 高适',
               '天生我材必有用。\n\n—— 李白',
               '穷则独善其身，\n达则兼济天下。\n\n—— 孟子',
               '一年之计在于春，\n一日之计在于晨。\n\n—— 萧绎',
               '三更灯火五更鸡，\n正是男儿读书时，\n黑发不知勤学早，\n白首方悔读书迟。\n\n—— 颜真卿',
               '有志者，事竟成，\n破釜沉舟，\n百二秦关终属楚；\n苦心人，天不负，\n卧薪尝胆，\n三千越甲可吞吴。\n\n—— 范晔\n《后汉书·耿弇传》',
               '学无止境。\n\n—— 荀子',
               '天将降大任于斯人也，必先苦其心志，\n劳其筋骨，饿其体肤，空乏其身，\n行拂乱其所为，\n所以动心忍性，\n曾益其所不能。\n\n—— 孟子',
               '居安思危，\n思则有备，\n有备无患。\n\n—— 《左传》',
               '若要功夫深，\n铁杵磨成针。\n\n—— 曹学\n《蜀中广记·上川南道彭山县》',
               '仁者见仁，\n智者见智。\n\n—— 《易经·系辞上》',
               '人无远虑，\n必有近忧。\n\n—— 孔子',
               '与有肝胆人共事，\n从无字句处读书。\n\n—— 周恩来',
               '为中华之崛起而读书。\n\n—— 周恩来',
               '千淘万浪虽辛苦，\n吹尽黄沙始到金。\n\n—— 刘禹锡',
               '勿以恶小而为之，\n勿以善小而不为。\n\n—— 刘备',
               '一日无书，\n百事荒废。\n\n—— 陈寿',
               '读书如饭，\n善吃饭者长精神，\n不善吃者生疾病。\n\n—— 章学诚',
               '人不可有傲气，\n但不可无傲骨。\n\n—— 徐悲鸿',
               '路漫漫其修远兮，\n吾将上下而求索。\n\n—— 屈原',
               '静以修身，\n俭以养德，\n非淡泊无以明志，\n非宁静无以致远。\n\n—— 诸葛亮',
               '吾生也有涯，\n而知也无涯。\n\n—— 庄子',
               '欲穷千里目，\n更上一层楼。\n\n—— 王之焕',
               '天时不如地利，\n地利不如人和。\n\n—— 《孟子·公孙丑》',
               '人谁无过？\n过而能改，\n善莫大焉。\n\n—— 《论语》',
               '满招损，\n谦受益。\n\n—— 《尚书·大禹谟》',
               '由俭入奢易，\n由奢入俭难。\n\n—— 司马光',
               '读书有三到，\n谓心到，\n眼到，\n口到。\n\n—— 朱熹',
               '近朱者赤，\n近墨者黑。\n\n—— 付玄',
               '君子爱财，\n取之有道。\n\n—— 孔子',
               '三人行，\n必有我师焉，\n择其善者而从之，\n其不善者而改之。\n\n—— 孔子',
               '问渠哪得清如许，\n为有源头活水来。\n\n—— 朱熹',
               '长风破浪会有时，\n直挂云帆济沧海。\n\n—— 李白',
               '鸟欲高飞先振翅，\n人求上进先读书。\n\n—— 李若禅',
               '少而好学，\n如日出之阳；\n壮而好学，\n如日中之光；\n志而好学，\n如炳烛之光。\n\n—— 刘向',
               '古之立大志者，\n不惟有超世之才，\n亦必有坚韧不拔之志。\n\n—— 苏轼',
               '旧书不厌百回读，\n熟读精思子自知。\n\n—— 苏轼',
               '博观而约取，\n厚积而薄发。\n\n—— 苏轼',
               '非学无以广才，\n非志无以成学。\n\n—— 诸葛亮',
               '君子坦荡荡，\n小人长戚戚。\n\n—— 孔子',
               '时间就是生命，\n时间就是速度，\n时间就是力量。\n\n—— 郭沫若',
               '读过一本好书，\n像交了一个益友。\n\n—— 臧克家',
               '天行健，\n君子以自强不息。地势坤，\n君子以厚德载物。\n\n—— 《周易》',
               '盛年不重来，\n一日难再晨。及时当勉励，\n岁月不待人。\n\n—— 陶渊明',
               '三军可夺帅也，\n匹夫不可夺志也。\n\n—— 孔子',
               '书读百遍，\n其义自见。\n\n—— 陈寿',
               '人生在勤，\n不索何获。\n\n—— 张衡',
               '天下事以难而废者十之一，\n以惰而废者十之九。\n\n—— 颜之推',
               '学必求其心得，\n业必贵其专精。\n\n—— 章学诚',
               '知之者不如好之者，\n好之者不如乐之者。\n\n—— 《论语·雍也》',
               '时间就像海绵里的水，\n只要愿挤，\n总还是有的。\n\n—— 鲁迅',
               '时间就是生命，\n无端地空耗别人的时间，\n无异于谋财害命。\n\n—— 鲁迅',
               '哪里有天才，\n我是把别人喝咖啡的工夫都用在工作上了。\n\n—— 鲁迅',
               '一滴水，\n用显微镜看，\n也是一个大世界。\n\n—— 鲁迅',
               '生活的理想，\n就是为了理想的生活。\n\n—— 张闻天',
               '十年树木，\n百年树人。\n\n—— 《管子·权修》',
               '青，\n取之于蓝而青于蓝；\n冰，\n水为之而寒于水。\n\n—— 《荀子·劝学》',
               '尺有所短；\n寸有所长。物有所不足；\n智有所不明。\n\n—— 屈原\n《卜居》',
               '言必信，\n行必果。\n\n—— 《论语·子路》',
               '骐骥一跃，\n不能十步；\n驽马十驾，\n功在不舍。\n\n—— 荀子',
               '虚心使人进步，\n骄傲使人落后。\n\n—— 毛泽东',
               '世上无难事，\n只要肯登攀。\n\n—— 毛泽东',
               '世上本没有路，\n走的人多了，\n也便成了路。\n\n—— 鲁迅',
               '哀其不幸，\n怒其不争。\n\n—— 鲁迅',
               '我好像是一只牛，\n吃的是草，\n挤出的是牛奶。\n\n—— 鲁迅',
               '天可补，\n海可填，\n南山可移。日月既往，\n不可复追。\n\n—— 曾国藩',
               '山不让尘，\n川不辞盈。\n\n—— 张华\n《励志诗》',
               '只有流过血的手指，\n才能弹出世间的绝唱。\n\n—— 泰戈尔',
               '当我们真正热爱这世界时，\n我们才真正生活在这世上。\n\n—— 泰戈尔',
               '幸福比傲慢更容易蒙住人的眼睛。\n\n—— 大仲马',
               '不傲才以骄人，\n不以宠而作威。\n\n—— 诸葛亮',
               '老年人常思既往，\n少年人常思将来。惟思既往也，\n故生留恋心；\n惟思将来也，\n故生希望心。\n\n—— 梁启超\n《少年中国说》',
               '追逐影子的人，\n自己就是影子。\n\n—— 荷马',
               '月缺不改光，\n剑折不改刚。\n\n—— 梅尧臣',
               '人生有两出悲剧：\n一是万念俱灰，\n另一是踌躇满志。\n\n—— 萧伯纳',
               '好运总是要先捉弄一番，\n然后才向着坚忍不拔者微笑的。\n\n—— 法布尔\n《昆虫记》',
               '不必行色匆匆，\n不必光芒四射，\n不必成为别人，\n只需做自己。\n\n—— 伍尔夫',
               '立志欲坚不欲锐，\n成功在久不在速。\n\n—— 张孝祥',
               '既然今天，\n没人识得星星一颗，\n那么明日，\n何妨做皓月一轮。\n\n—— 汪国真\n《倘若才华得不到承认》',
               '接受每一个人的批评，\n可是保留你自己的判断。\n\n—— 莎士比亚',
               '在各种孤独中间，\n人最怕精神上的孤独。\n\n—— 巴尔扎克',
               '聪明人只要能认识自己，\n便什么也不会失去。\n\n—— 尼采',
               '我的确时时刻刻解剖别人，\n然而更多的是更无情面对地解剖我自己。\n\n—— 鲁迅',
               '君子慎独。\n\n—— 《礼记》',
               '孤独是所有杰出人物的命运。\n\n—— 叔本华',
               '君子欲讷于言而敏于行。\n\n—— 孔子',
               '永远年轻，\n永远热泪盈眶，\n永远在路上。\n\n—— 凯鲁亚克',
               '既然选择了远方，\n便只顾风雨兼程。\n\n—— 汪国真\n《热爱生命》',
               '我微笑着走向生活，\n无论生活以什么方式回敬我。\n\n—— 汪国真\n《如果生活不够慷慨》 ',
               '没有比脚更长的路，\n没有比人更高的山。\n\n—— 汪国真\n《只要明天还在》',
               '未来不足惧，\n过往不须泣。\n\n—— 雪莱',
               '古之有立大事者，\n不惟有超世之才，\n亦必有坚韧不拔之志。\n\n—— 苏轼',
               '黑夜无论怎样悠长，\n白昼总会到来。\n\n―― 威廉·莎士比亚',
               '我们日复一日做的事情，\n决定了我们是怎样的人。\n因此所谓卓越，\n并非指行为，\n而是习惯。\n\n—— 亚里士多德',
               '每一个不曾起舞的日子，\n都是对生命的辜负。\n\n—— 尼采',
               '如果你不能飞，\n那就跑吧。如果你不能跑，\n那就走吧。如果你不能走，\n那就爬吧。\n但无论怎样，\n都要继续前行。\n\n—— 马丁·路德·金',
               '人生的路，\n靠自己一步步走去，\n真正能保护你的，\n是你自己的人格选择和文化选择。\n那么反过来，\n真正能伤害你的，\n也是一样，\n自己的选择。\n\n—— 余秋雨',
               '每个人都睁着眼睛，\n但不等于每个人都在看世界，\n许多人几乎不用自己的眼睛看，\n他们只听别人说，\n他们看到的世界永远是别人说的样子。\n\n—— 周国平',
               '我和谁都不争，\n和谁争我都不屑。\n\n—— 兰德',
               '人生需要准备的，\n不是昂贵的茶，\n而是喝茶的心情。\n\n—— 林清玄',
               '让自己的内心藏着一条巨龙，\n既是一种苦刑，\n也是一种乐趣。\n\n—— 雨果',
               '通过自己的努力即使知道一半真理，\n也比人云亦云地知道全部真理要好得多。\n\n── 罗曼.罗兰',
               '通向荣誉的路上，\n并不铺满鲜花。\n\n── 但丁',
               '最聪明的人是最不愿浪费时间的人。\n\n── 但丁',
               '最好不要在西下的时候去幻想什么，\n而要在旭日初升的时候即投入工作。\n\n── 谢觉哉',
               '先相信你自己，\n然后别人才会相信你。\n\n── 屠格涅夫',
               '想一下子全知道，\n就意味着什么也不知道。\n\n── 巴甫洛夫',
               '辛苦是获得一切的定律。\n\n── 牛顿',
               '天才出于勤奋。\n\n──高尔基',
               '天才的十分之一是灵感，\n十分之九是血汗。\n\n── 列夫.托尔斯泰',
               '伟大的事业，\n需要决心，\n能力，\n组织和责任感。\n\n── 易卜生',
               '我从来不把安逸和享乐看作是生活目的本身。\n\n── 爱因斯坦',
               '耐心是一切聪明才智的基础。\n\n── 柏拉图',
               '平静的湖面，\n炼不出精悍的水手；\n安逸的环境，\n造不出时代的伟人。\n\n── 列别捷夫',
               '奇迹多在厄运中出现。\n\n── 培根',
               '完成工作的方法，\n是爱惜每一分钟。\n\n── 达尔文',
               '理想的书籍是智慧的钥匙。\n\n── 托尔斯泰',
               '立志、工作、成功，\n是人类活动的三大要素。\n\n── 巴斯德',
               '立志是事业的大门，\n工作是登门入室的旅途。\n\n── 巴斯德',
               '没有不可认识的东西，\n我们只能说还有尚未被认识的东西。\n\n── 高尔基',
               '应该让别人的生活因为有了你的生存而更加美好。\n\n── 茨巴尔',
               '越学习，\n越发现自己的无知。\n\n── 笛卡尔',
               '在观察的领域中，\n机遇只偏爱那种有准备的头脑。\n\n── 巴斯德',
               '在天才和勤奋两者之间，\n我毫不迟疑地选择勤奋，\n她是几乎世界上一切成就的催产婆。\n\n── 爱因斯坦',
               '幸福永远存在于人类不安的追求中，\n而不存在于和谐与稳定之中。\n\n── 鲁迅',
               '幸运并非没有许多的恐惧与烦恼；\n厄运也并非没有许多的安慰与希望。\n\n── 培根',
               '真的猛士，\n敢于直面惨淡的人生，\n敢于正视淋漓的鲜血。\n\n── 鲁迅\n《纪念刘和珍君》',
               '不在沉默中爆发，\n就在沉默中灭亡。\n\n── 鲁迅\n《记念刘和珍君》',
               '其实地上本没有路，\n走的人多了，\n也便成了路。\n\n── 鲁迅\n《故乡》',
               '人的言行，\n在白天和在深夜，\n在日下和在灯前，\n常常显得两样。\n\n──鲁迅 \n《夜颂》',
               '怀疑并不是缺点。总是疑，\n而并不下断语，\n这才是缺点。\n\n──鲁迅\n《鲁迅全集》',
               '贪安稳就没有自由，\n要自由就总要历些危险。\n\n── 鲁迅\n《二月十九日在香港青年会讲》',
               '勇者愤怒，\n抽刃向更强者；\n怯者愤怒，\n却抽刃向更弱者。\n\n── 鲁迅\n《华盖集·杂感》',
               '才不足则多谋。识不足则多虑。\n威不足则多怒。信不足则多言。\n勇不足则多劳。明不足则多察。\n理不足则多辩。情不足则多仪。\n\n—— 李叔同',
               '不乱于心，\n不困于情。不畏将来，\n不念过往。如此，\n安好。\n\n—— 丰子恺',
               '假话全不说，\n真话不全说。\n\n—— 季羡林',
               '一个人至少拥有一个梦想，\n有一个理由去坚强。\n心若没有栖息的地方，\n到哪里都是在流浪。\n\n—— 三毛',
               '人生不过如此，\n且行且珍惜。自己永远是自己的主角，\n不要总在别人的戏剧里充当着配角。\n\n—— 林语堂',
               '走好选择的路，\n别选择好走的路，\n你才能拥有真正的自己。\n\n—— 杨绛',
               '一个人的行走范围，\n就是他的世界。\n\n—— 北岛',
               '成功就是从失败到失败，\n也依然不改热情。\n\n—— 丘吉尔',
               '优于别人，\n并不高贵，\n真正的高贵应该是优于过去的自己。\n\n—— 海明威',
               '做有用的事，\n说勇敢的话，\n渴望美好的事，\n一生足以。\n\n—— 托马斯·斯特恩斯·艾略特',
               '我笑，\n是因为生活不值得用泪水去面对。\n\n—— 亨利克·显克维支',
               '时间以同样的方式流经每个人，\n而每个人却以不同的方式度过时间。\n\n—— 川端康成',
               '你担心什么，\n什么就控制你。\n\n—— 约翰·洛克',
               '愚者之所以成为愚者，\n在于固守己见而兴奋莫名。\n\n—— 蒙田',
               '我只知道一件事，\n就是我什么都不知道。\n\n—— 苏格拉底',
               '智者说话，\n是因为他们有话要说；\n愚者说话，\n则是因为他们想说。\n\n—— 柏拉图',
               '每天反复做的事情造就了我们，\n然后你会发现，\n优秀不是一种行为，\n而是一种习惯。\n\n—— 亚里士多德',
               '当一个人一心一意做好事情的时候，\n他最终是必然会成功的。\n\n—— 卢梭',
               '自由不是让你想做什么就做什么，\n自由是教你不想做什么，\n就可以不做什么。\n\n—— 康德',
               '存在即合理。\n\n—— 黑格尔',
               '人性一个最特别的弱点就是：\n在意别人如何看待自己。\n\n—— 叔本华',
               '其实人跟树是一样的，\n越是向往高处的阳光，\n它的根就越要伸向黑暗的地底。\n\n—— 尼采',
               '一个能思想的人，\n才真是一个力量无边的人。\n\n—— 巴尔扎克',
               '生气的时候，\n开口前先数到十，\n如果非常愤怒，\n先数到一百。\n\n—— 杰弗逊',
               '不知道并不可怕和有害。\n任何人都不可能什么都知道，\n可怕的和有害的是不知道而伪装知道。\n\n—— 托尔斯泰',
               '几个苍蝇咬几口，\n决不能羁留一匹英勇的奔马。\n\n—— 伏尔泰',
               '社会犹如一条船，\n每个人都要有掌舵的准备。\n\n—— 易卜生',
               '对别人的意见要表示尊重。千万别说：\n＂你错了。＂\n\n—— 卡耐基',
               '读书是易事，\n思索是难事，\n但两者缺一，\n便全无用处。\n\n—— 富兰克林',
               '宁要好梨一个，\n不要烂梨一筐。\n积极肯干和忠心耿耿的人即使只有两三个，\n也比十个朝气沉沉的人强。\n\n—— 列宁',
               '我们是国家的主人，\n应该处处为国家着想。\n\n—— 雷锋',
               '一个人追求的目标越高，\n他的才力就发展得越快，\n对社会就越有益。\n\n—— 高尔基',
               '书籍是造就灵魂的工具。\n\n—— 雨果',
               '不要对一切人都以不信任的眼光看待，\n但要谨慎而坚定。\n\n—— 德谟克里特',
               '读一本好书，\n就是和许多高尚的人谈话。\n\n—— 歌德',
               '人生是没有毕业的学校。\n\n—— 黎凯',
               '一个人应养成信赖自己的习惯，\n即使在最危急的时候，\n也要相信自己的勇敢与毅力。\n\n—— 拿破仑',
               '书不仅是生活，\n而且是现在、过去和未来文化生活的源泉。\n\n—— 库法耶夫',
               '成功＝艰苦的劳动＋正确的方法＋少谈空话。\n\n—— 爱因斯坦',
               '走自己的路，\n让别人说去！\n\n—— 但丁',
               '勇于求知的人决不至于空闲无事。\n\n—— 孟德斯鸠',
               '最可怕的敌人，\n就是没有坚强的信念。\n\n—— 罗曼·罗兰',
               '失败乃成功之母。\n\n—— 牛顿',
               '卓越的人一大优点是：\n在不利与艰难的遭遇里百折不饶。\n\n—— 贝多芬',
               '事业常成于坚忍，\n毁于急躁。\n\n—— 萨迪',
               '要成就一件大事业，\n必须从小事做起。\n\n—— 列宁',
               '尺有所短；\n寸有所长。物有所不足；\n智有所不明。\n\n—— 屈原\n《卜居》',
               '利用时间是一个极其高级的规律。\n\n—— 恩格斯',
               '辛勤的蜜蜂永没有时间悲哀。\n\n—— 布莱克',
               '我这个人走得很慢，\n但是我从不后退。\n\n—— 亚伯拉罕·林肯',
               '任何问题都有解决的办法，\n无法可想的事是没有的。\n\n—— 爱迪生',
               '如果是玫瑰，\n它总会开花的。\n\n—— 歌德',
               '善于利用零星时间的人，\n才会做出更大的成绩来。\n\n—— 华罗庚',
               '时间是伟大的作者，\n她能写出未来的结局。\n\n—— 卓别林',
               '冬天已经到来，\n春天还会远吗? \n\n——  雪莱',
               '故立志者，\n为学之心也；\n为学者，\n立志之事也。 \n\n——  王阳明',
               '人的天才只是火花，\n要想使它成熊熊火焰，\n哪就只有学习！学习！\n\n—— 高尔基',
               '有教养的头脑的第一个标志就是善于提问。\n\n—— 普列汉诺夫',
               '当你还不能对自己说今天学到了什么东西时，\n你就不要去睡觉。\n\n—— 利希顿堡',
               '游手好闲的学习并不比学习游手好闲好。\n\n—— 约·贝勒斯',
               '求学的三个条件是：\n多观察、多吃苦、多研究。\n\n—— 加菲劳',
               '学到很多东西的诀窍，\n就是一下子不要学很多。\n\n—— 洛克',
               '没有人事先了解自己到底有多大的力量，\n直到他试过以后才知道。\n\n—— 歌德',
               '多则价谦，\n万物皆然，\n唯独知识例外。知识越丰富，\n则价值就越昂贵。\n\n—— 马戈',
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
                        foregroundColor: Colors.white, minimumSize: Size(155, 46),
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
