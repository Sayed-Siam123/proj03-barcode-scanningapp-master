import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/database/Delivery_database.dart';
import 'package:app/database/Masterdata_database.dart';
import 'package:app/database/Pickup_database.dart';


class ProductDB {
  final dbProvider = DatabaseProvider_delivery.dbProvider; //delivery db
  final pickupDBprovider  = DatabaseProvider_pickup.dbProvider; //pickup db
  final masterdataDBprovider  = DatabaseProvider_Masterdata.dbProvider; //pickup db

  Future<int> createTodo(NewDeliveryModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.barcode.toString());

    var db = await dbProvider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        productTABLE, productinfo.toMap(), nullColumnHack: colId);
    print("2");
    return result;
  }

  Future<List<NewDeliveryModel>> getProduct(
      {List<String> columns, String query}) async {
    var db = await dbProvider.database;
    print("Eikhane");
    var result = await db.query(productTABLE, orderBy: '$colId DESC', limit: 1);


    List<NewDeliveryModel> products = result.isNotEmpty
        ? result.map((item) => NewDeliveryModel.fromMapObject(item)).toList()
        : [];
    return products;
  }

  Future<List<NewDeliveryModel>> getAllProduct(
      {List<String> columns, String query}) async {
    var db = await dbProvider.database;
    print("Eikhane");
    var result = await db.query(productTABLE, orderBy: '$colId ASC');


    List<NewDeliveryModel> products = result.isNotEmpty
        ? result.map((item) => NewDeliveryModel.fromMapObject(item)).toList()
        : [];
    return products;
  }

  Future<int> updateProduct(NewDeliveryModel product) async {
    final db = await dbProvider.database;

    var result = await db.update(productTABLE, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<int> deleteProduct(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(
        productTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future deleteAllProducts() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      productTABLE,
    );

    return result;
  }


  // Delivereies END


//Pickup delivery START

  Future<int> createPickup(PickupDeliveryModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.huID.toString());

    var db = await pickupDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        pickupTABLE, productinfo.toMap(), nullColumnHack: Id);
    print("2");
    return result;
  }


  Future<List<PickupDeliveryModel>> getAllPickupProduct(
      {List<String> columns, String query}) async {
    var db = await pickupDBprovider.database;
    print("Eikhane");
    var result = await db.query(pickupTABLE, orderBy: '$colId ASC');


    List<PickupDeliveryModel> pickproducts = result.isNotEmpty
        ? result.map((item) => PickupDeliveryModel.fromMapObject(item)).toList()
        : [];
    return pickproducts;
  }

  Future deleteAllPickupProducts() async {
    final db = await pickupDBprovider.database;
    var result = await db.delete(
      pickupTABLE,
    );

    return result;
  }

//Pickup delivery END


//MASTERDATA DB START

  Future<int> insertMasterdata(MasterDataModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.product_id.toString());

    var db = await masterdataDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        masterTABLE, productinfo.toMap(), nullColumnHack: master_Id);
    print("2");
    return result;
  }



  Future deleteAllMasterProducts() async {
    final db = await masterdataDBprovider.database;
    var result = await db.delete(
      masterTABLE,
    );

    return result;
  }

  Future<List<MasterDataModel>> getAllMAsterProduct(
      {List<String> columns, String query}) async {
    var db = await masterdataDBprovider.database;
    print("Eikhane");
    var result = await db.query(masterTABLE, orderBy: '$colId ASC');


    List<MasterDataModel> product = result.isNotEmpty
        ? result.map((item) => MasterDataModel.fromJson(item)).toList()
        : [];
    return product;
  }



//MASTERDATA DB END


}