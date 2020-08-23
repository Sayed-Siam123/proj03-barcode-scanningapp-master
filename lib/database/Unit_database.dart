import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final unitTABLE = 'unitTable';
String unit_Id = 'id';
String unit_name = 'unitName';
String unit_short = 'unitShort';
String unit_desc = 'unitDescription';
String unit_isView = 'isView';
String unit_isAdd = 'isAdd';
String unit_isEdit = 'isEdit';
String unit_isDelete = 'isDelete';
String unit_isDeactivate = 'isDeactivate';
String unit_updateFlag = 'updateFlag';


class DatabaseProvider_unit {
  static final DatabaseProvider_unit dbProvider_unit = DatabaseProvider_unit();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "unit.db");

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
    await database.execute('CREATE TABLE $unitTABLE($unit_Id TEXT, $unit_name TEXT, $unit_short TEXT,'
        '$unit_desc TEXT, $unit_isView TEXT, $unit_isAdd TEXT, $unit_isEdit TEXT,$unit_isDelete TEXT,$unit_isDeactivate TEXT,$unit_updateFlag TEXT)');
  }
}
