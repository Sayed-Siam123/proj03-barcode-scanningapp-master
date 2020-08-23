import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final masterTABLE = 'masterTable';
String master_Id = 'id';
String masterProd_name = 'productName';
String masterProd_manufacturerName = 'manufacturerName';
String masterProd_gtin = 'gtin';
String mastercategoryName = 'categoryName';
String mastersubCategoryName = 'subCategoryName';
String masterproductDescription = 'productDescription';
String masterreferenceNo = 'referenceNo';
String masterpackagingUnit = 'packagingUnit';
String masterlistPrice = 'listPrice';
String masterproductPicture = 'productPicture';
String masterproductWeight = 'productWeight';
String masterupdateFlag = 'updateFlag';
String masternewFlag = 'newFlag';
String mastermanufacturerId = 'manufacturerId';
String mastermanufacturerPN = 'manufacturerPN';
String masterunitId = 'unitId';
String mastercategoryNameId = 'categoryNameId';
String mastersubCategoryNameId = 'subCategoryNameId';
String masterisTransferToApp = 'isTransferToApp';
String masterisOrderableViaApp = 'isOrderableViaApp';
String masterproductLength = 'productLength';
String masterproductHeight = 'productHeight';
String masterproductWidth = 'productWidth';
String masterunitName = 'unitName';


class DatabaseProvider_Masterdata {
  static final DatabaseProvider_Masterdata dbProvider = DatabaseProvider_Masterdata();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"ReactiveTodo.db is our database instance name
    String path = join(documentsDirectory.path, "Masterdata.db");

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
    await database.execute('CREATE TABLE $masterTABLE($master_Id TEXT, '
        '$masterProd_name TEXT, $masterProd_manufacturerName TEXT,$mastermanufacturerId TEXT,$mastermanufacturerPN TEXT, $mastercategoryName TEXT,$mastercategoryNameId TEXT,$mastersubCategoryName TEXT,$mastersubCategoryNameId TEXT,$masterproductDescription TEXT,'
        '$masterpackagingUnit TEXT,$masterlistPrice TEXT,$masterproductPicture TEXT,$masterreferenceNo TEXT,$masterproductWeight TEXT,$masterProd_gtin TEXT,$masterupdateFlag TEXT,$masternewFlag TEXT,'
    '$masterunitId TEXT,$masterunitName TEXT,$masterisTransferToApp TEXT,$masterisOrderableViaApp TEXT,$masterproductHeight TEXT,$masterproductWidth TEXT,$masterproductLength TEXT)');
  }
}
