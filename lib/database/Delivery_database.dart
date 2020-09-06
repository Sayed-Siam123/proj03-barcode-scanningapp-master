import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final productTABLE = 'ProductTable';
String colId = 'id';
String colProd_name = 'product_name';
String colProd_barcode = 'barcode';
String colProd_quantity = 'quantity';
String colProd_note = 'note';
String colProd_id = 'product_id';
String colProd_handling_unit = 'handling_unit';


class DatabaseProvider_delivery {
  static final DatabaseProvider_delivery dbProvider = DatabaseProvider_delivery();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "Product.db");

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
    await database.execute('CREATE TABLE $productTABLE($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colProd_name TEXT, '
        '$colProd_barcode TEXT UNIQUE, $colProd_quantity INTEGER, $colProd_handling_unit TEXT, $colProd_note TEXT,$colProd_id TEXT)');
  }
}
