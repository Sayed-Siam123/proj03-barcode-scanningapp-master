import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final subcatTABLE = 'subcatTable';
String subcat_Id = 'id';
String subcat_name = 'subCategoryName';
String subcat_desc = 'subcategoryDescription';
String subcat_isView = 'isView';
String subcat_isAdd = 'isAdd';
String subcat_isEdit = 'isEdit';
String subcat_isDelete = 'isDelete';
String subcat_isDeactivate = 'isDeactivate';
String subcat_updateFlag = 'updateFlag';
String subcat_catID = 'categoryId';
String subcat_catName = 'categoryName';


class DatabaseProvider_subcat {
  static final DatabaseProvider_subcat dbProvider_subcat = DatabaseProvider_subcat();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "subcat.db");

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
    await database.execute('CREATE TABLE $subcatTABLE($subcat_Id TEXT, $subcat_name TEXT, '
        '$subcat_desc TEXT, $subcat_isView TEXT, $subcat_isAdd TEXT, $subcat_isEdit TEXT,$subcat_isDelete TEXT,$subcat_isDeactivate TEXT,$subcat_updateFlag TEXT,$subcat_catID TEXT,$subcat_catName TEXT)');
  }
}
