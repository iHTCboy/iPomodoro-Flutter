import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseUtils {
  static Database _database;

  ///创建数据库db
  static db_createDb(String dbName, int vers, String dbTables) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    debugPrint("数据库路径：$path数据库版本$vers");
    //打开数据库
    _database = await openDatabase(path,
        version: vers,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          //数据库升级,只回调一次
          debugPrint("数据库需要升级！旧版：$oldVersion，新版：$newVersion");
        }, onCreate: (Database db, int vers) async {
          // print('创建数据库表');
          //创建表，只回调一次
          await db.execute(dbTables);
          await db.close();
        });
  }

  static Future<Database> getCurrentDatabase(String dbName) async {
    if (_database == null || !_database.isOpen) {
      _database = null;
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, dbName);
      _database = await openDatabase(path);
    }
    return _database;
  }

  ///增(事务方式)
  static db_add(String dbName, String sql) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);

    await db.transaction((txn) async {
      int count = await txn.rawInsert(sql);
    });
    await db.close();
  }

  /// 插入
  static Future<int> db_insert(String dbName, String table, Map<String, dynamic> values) async {
    //获取数据库路径
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);

    int id = await db.insert(table, values);
    await db.close();
    return id; //返回最后插入的记录ID
  }
  /*
  int id0 = await db.insert('Test', {'name': 'another', 'value': '18', 'num': '456.7'});
  int id1 = await db.rawInsert('INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
  int id2 = await db.rawInsert('INSERT INTO Test(name, value, num) VALUES(?, ?, ?)', ['another', 12345678, 3.1416]);
   */

  ///删
  static Future<int> db_delete(String dbName, String sql, List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);

    int count = await db.rawDelete(sql, arg);
    await db.close();
    return count; //返回受影响的的数量，即删除的条目数量
  }

  ///改
  static Future<int> db_update(String dbName, String sql, List arg) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);

    int count = await db.rawUpdate(sql, arg); //修改条件，对应参数值
    await db.close();
    return count; //返回受影响的的数量
  }

  ///查条数
  static Future<int> db_getQueryNum(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);

    int count = Sqflite.firstIntValue(await db.rawQuery(sql));
    await db.close();
    return count;
  }

  ///查全部
  static Future<List<Map>> db_query(String dbName, String sql) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    Database db = await openDatabase(path);
    List<Map> list = await db.rawQuery(sql);

    await db.close();
    return list;
  }
}
