import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/database/database.dart';
import 'package:app/database/pickupdelivery_db.dart';

class ProductDB {
  final dbProvider = DatabaseProvider.dbProvider;
  final pickupDeliveryDBProvider = PickupDeliveryProvider.pickupdbProvider;

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


  Future<List<PickupDeliveryModel>> getAllPickupProduct(
      {List<String> columns, String query}) async {
    var db = await pickupDeliveryDBProvider.database;
    print("Eikhane");
    var result = await db.query(
        pickupDeliveryTABLE, orderBy: '$colpickupId ASC');


    List<PickupDeliveryModel> products = result.isNotEmpty
        ? result.map((item) => PickupDeliveryModel.fromMapObject(item)).toList()
        : [];
    return products;
  }


  Future<int> createPickupList(PickupDeliveryModel productinfo) async {
    //print("FORM DBPROVIDER: "+productinfo.barcode.toString());

    var db = await pickupDeliveryDBProvider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        pickupDeliveryTABLE, productinfo.toMap(), nullColumnHack: colpickupId);
    print("2");
    return result;


//Pickup delivery END

  }
}