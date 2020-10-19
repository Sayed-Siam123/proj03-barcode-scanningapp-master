import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final dataAcquiTABLE = 'dataAcquiTable';
String dataAcqui_Id = 'id';
String dataAcqui_barcode = 'barcode';
String dataAcqui_description = 'description';
String dataAcqui_quantity = 'quantity';
String dataAcqui_newFlag = 'newFlag';
String dataAcqui_updateFlag = 'updateFlag';


class DatabaseProvider_dataAcquisition {
  static final DatabaseProvider_dataAcquisition dbProvider_dataAcqui = DatabaseProvider_dataAcquisition();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "Data_Acquisition.db");

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
    await database.execute('CREATE TABLE $dataAcquiTABLE($dataAcqui_Id INTEGER PRIMARY KEY AUTOINCREMENT, $dataAcqui_barcode TEXT UNIQUE, '
        '$dataAcqui_description TEXT, $dataAcqui_quantity INTEGER, $dataAcqui_newFlag TEXT, $dataAcqui_updateFlag TEXT)');
  }
}
