import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final pickupDeliveryTABLE = 'pickupDeliveryTable';
String colpickupId = 'id';
String colProd_store_name = 'store';
String colProd_postition = 'pos';
String colProd_quantity = 'qnty';
String colProd_date = 'date';


class PickupDeliveryProvider {
  static final PickupDeliveryProvider pickupdbProvider = PickupDeliveryProvider();

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
    await database.execute('CREATE TABLE $pickupDeliveryTABLE($colpickupId INTEGER PRIMARY KEY AUTOINCREMENT, $colProd_store_name TEXT, '
        '$colProd_postition TEXT, $colProd_quantity INTEGER, $colProd_date TEXT)');
  }
}
