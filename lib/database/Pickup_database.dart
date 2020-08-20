import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final pickupTABLE = 'pickupTable';
String Id = 'id';
String Prod_quantity = 'quantity';
String Prod_position = 'position';
String Delivery_id = 'delivery_id';
String Prod_handling_unit = 'handling_unit';


class DatabaseProvider_pickup {
  static final DatabaseProvider_pickup dbProvider = DatabaseProvider_pickup();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "Pickup.db");

    print("Pickup DB PATH IS "+path);

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute('CREATE TABLE $pickupTABLE($Id INTEGER PRIMARY KEY AUTOINCREMENT, $Delivery_id TEXT, '
        '$Prod_position TEXT, $Prod_quantity TEXT, $Prod_handling_unit TEXT)');
  }
}
