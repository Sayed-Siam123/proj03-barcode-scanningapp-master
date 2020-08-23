import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final catTABLE = 'catTable';
String cat_Id = 'id';
String cat_name = 'categoryName';
String cat_desc = 'categoryDescription';
String cat_isView = 'isView';
String cat_isAdd = 'isAdd';
String cat_isEdit = 'isEdit';
String cat_isDelete = 'isDelete';
String cat_isDeactivate = 'isDeactivate';
String cat_updateFlag = 'updateFlag';


class DatabaseProvider_category {
  static final DatabaseProvider_category dbProvider_category = DatabaseProvider_category();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "Category.db");

    print("DB PATH IS "+path);

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute('CREATE TABLE $catTABLE($cat_Id TEXT, $cat_name TEXT, '
        '$cat_desc TEXT, $cat_isView TEXT, $cat_isAdd TEXT, $cat_isEdit TEXT,$cat_isDelete TEXT,$cat_isDeactivate TEXT,$cat_updateFlag TEXT)');
  }
}
