import 'package:flutter/cupertino.dart';
import 'package:iPomodoro/common/utils/database_utils.dart';
import 'package:iPomodoro/common/utils/time_utils.dart';
import 'package:iPomodoro/generated/l10n.dart';

const String K_Pomodoro_Database = 'pomodoro.db';
const String K_Countdown_DB_Table = 'countdown_tasks';

enum QueryType {
  shard, //占位用
  idAsc,
  idDesc,
  dateAsc,
  dateDesc,
  modifyAsc,
  modifyDesc,
}

extension QueryTypeExt on QueryType {

  static const Map<QueryType, String> values = {
    QueryType.idAsc: 'id asc',
    QueryType.idDesc: 'id desc',
    QueryType.dateAsc: 'date asc',
    QueryType.dateDesc: 'date desc',
    QueryType.modifyAsc: 'modify_date asc',
    QueryType.modifyDesc: 'modify_date desc',
  };

  static const Map<int, QueryType> types = {
    0: QueryType.idAsc,
    1: QueryType.idDesc,
    2: QueryType.dateAsc,
    3: QueryType.dateDesc,
    4: QueryType.modifyAsc,
    5: QueryType.modifyDesc,
  };

  String get value => values[this];

  List<String> get getValues => values.values.toList();

  Map<int, QueryType> get getTypes => types;
}

class CountdownModel {
  int itemId;
  String title;
  DateTime date;
  DateTime modify_date; //修改日期
  String notes;
  int push = 0; //是否定时推送通知

  CountdownModel(this.title, this.date, this.notes,
      {this.itemId, this.push, this.modify_date});

  CountdownModel.fromJson(Map<String, dynamic> json) {
    this.itemId = json['id'] ?? 0;
    this.title = json['title'];
    this.date = DateTime.fromMillisecondsSinceEpoch(json['date']);
    this.modify_date = DateTime.fromMillisecondsSinceEpoch(json['modify_date']);
    this.notes = json['notes'];
    this.push = json['push'] ?? 0;
  }

  Map<String, dynamic> toJsonMap() {
    Map<String, dynamic> map = new Map();
    map["title"] = title;
    map["date"] = date.millisecondsSinceEpoch;
    map["notes"] = notes;
    map["push"] = push;
    map["modify_date"] = modify_date.millisecondsSinceEpoch;
    return map;
  }

  String date_string(BuildContext context) {
    String weekday = get_weekday_string(context, date.weekday);
    String formattedDate = S.of(context).date_format('${date.year.toString()}',
        '${date.month.toString().padLeft(2, '0')}',
        '${date.day.toString().padLeft(2, '0')}',
        '${date.hour.toString().padLeft(2, '0')}',
        '${date.minute.toString().padLeft(2, '0')}',
        '${weekday}');
    return formattedDate;
  }

  int countdown_day() {
    return TimeUtils.get_difference_day(date);
  }

  static String get_weekday_string(BuildContext context, int weekday) {
    String day = S.of(context).tips_unknown;
    switch (weekday) {
      case 1:
        day = S.of(context).tips_monday;
        break;
      case 2:
        day = S.of(context).tips_tuesday;
        break;
      case 3:
        day = S.of(context).tips_wednesday;
        break;
      case 4:
        day = S.of(context).tips_thursday;
        break;
      case 5:
        day = S.of(context).tips_friday;
        break;
      case 6:
        day = S.of(context).tips_saturday;
        break;
      case 7:
        day = S.of(context).tips_sunday;
        break;
    }
    return day;
  }

  /// 数据库相关操作

  static init_database() {
    DataBaseUtils.db_createDb(K_Pomodoro_Database, 1,
        'CREATE TABLE ${K_Countdown_DB_Table}(id INTEGER PRIMARY KEY, title TEXT, date INTEGER, notes TEXT, push INTEGER, modify_date INTEGER)');
  }

  static Future<List<Map>> query_all_data(QueryType queryType) async {
    String order_query = queryType.value;
    List data = await DataBaseUtils.db_query(K_Pomodoro_Database,
        'SELECT * FROM ${K_Countdown_DB_Table} order by ${order_query}');
    return data;
  }

  static Future<int> insert_data(CountdownModel model) async {
    int id = await DataBaseUtils.db_insert(
        K_Pomodoro_Database, K_Countdown_DB_Table, model.toJsonMap());
    return id;
    //DataBaseUtils.db_add(K_Pomodoro_Database, "INSERT INTO ${K_Countdown_DB_Table}(title, date, notes, push) VALUES('${model.title}', ${model.date.millisecondsSinceEpoch}, '${model.notes}', ${model.push})");
  }

  static Future<int> update_data(CountdownModel model) async {

    //返回受影响的的数量
    int count = await DataBaseUtils.db_update(
        K_Pomodoro_Database,
        'UPDATE ${K_Countdown_DB_Table} SET title = ?, date = ?, notes = ?, push = ?, modify_date = ? WHERE id = ?',
        [
          model.title,
          model.date.millisecondsSinceEpoch,
          model.notes,
          model.push,
          model.modify_date.millisecondsSinceEpoch,
          model.itemId
        ]);
    return count;
  }

  static Future<int> delete_data(CountdownModel model) async {
    //返回受影响的的数量，即删除的条目数量
    int count = await DataBaseUtils.db_delete(K_Pomodoro_Database,
        'DELETE FROM ${K_Countdown_DB_Table} WHERE id = ?', [model.itemId]);
    return count;
  }
}
