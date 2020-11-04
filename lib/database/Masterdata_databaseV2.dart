import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final masterTABLEV2 = 'masterTable_v2';
String master_IdV2 = 'id';
String masterProd_gtinV2 = 'gtin';
String masterproductDescriptionV2 = 'productDescription';
String masterlistPriceV2 = 'listPrice';
String masterproductPictureV2 = 'productPicture';
String masterlistbarcode_typeV2 = 'type';
String masterproductbarcode_digitsV2 = 'digits';
String masterupdateFlagV2 = 'updateFlag';
String masternewFlagV2 = 'newFlag';

class DatabaseProvider_MasterdataV2 {
  static final DatabaseProvider_MasterdataV2 dbProvider_MasterDataV2 = DatabaseProvider_MasterdataV2();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "MasterdataV2.db");

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
    await database.execute('CREATE TABLE $masterTABLEV2($master_IdV2 TEXT,$masterproductDescriptionV2 TEXT, $masterlistPriceV2 TEXT,'
        '$masterproductPictureV2 TEXT,$masterProd_gtinV2 TEXT,$masterlistbarcode_typeV2 TEXT,'
        '$masterproductbarcode_digitsV2 TEXT,$masterupdateFlagV2 TEXT,$masternewFlagV2 TEXT)');
  }
}
