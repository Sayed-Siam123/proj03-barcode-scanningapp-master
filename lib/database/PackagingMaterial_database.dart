import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final packmatTABLE = 'packmatTable';
String packmat_Id = 'id';
String packmat_name = 'materialName';
String packmat_desc = 'materialDescription';
String packmat_isView = 'isView';
String packmat_isAdd = 'isAdd';
String packmat_isEdit = 'isEdit';
String packmat_isDelete = 'isDelete';
String packmat_isDeactivate = 'isDeactivate';
String packmat_updateFlag = 'updateFlag';


class DatabaseProvider_packmaterial {
  static final DatabaseProvider_packmaterial dbProvider_packegingMat = DatabaseProvider_packmaterial();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "packmat.db");

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
    await database.execute('CREATE TABLE $packmatTABLE($packmat_Id TEXT, $packmat_name TEXT, '
        '$packmat_desc TEXT, $packmat_isView TEXT, $packmat_isAdd TEXT, $packmat_isEdit TEXT,$packmat_isDelete TEXT,$packmat_isDeactivate TEXT,$packmat_updateFlag TEXT)');
  }
}
