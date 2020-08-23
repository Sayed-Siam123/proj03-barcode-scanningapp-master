import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final manufacTABLE = 'ManufactureTable';
String manufac_Id = 'id';
String manufac_name = 'manufacturerName';
String manufac_desc = 'manufacturerDescription';
String manufac_isView = 'isView';
String manufac_isAdd = 'isAdd';
String manufac_isEdit = 'isEdit';
String manufac_isDelete = 'isDelete';
String manufac_isDeactivate = 'isDeactivate';
String manufac_updateFlag = 'updateFlag';


class DatabaseProvider_manufac {
  static final DatabaseProvider_manufac dbProvider_manufac = DatabaseProvider_manufac();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "Manufac.db");

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
    await database.execute('CREATE TABLE $manufacTABLE($manufac_Id TEXT, $manufac_name TEXT, '
        '$manufac_desc TEXT, $manufac_isView TEXT, $manufac_isAdd TEXT, $manufac_isEdit TEXT,$manufac_isDelete TEXT,$manufac_isDeactivate TEXT,$manufac_updateFlag TEXT)');
  }
}
