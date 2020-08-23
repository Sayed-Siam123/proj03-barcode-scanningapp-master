import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Model/unit_model.dart';
import 'package:app/database/Category_database.dart';
import 'package:app/database/Delivery_database.dart';
import 'package:app/database/Manufac_database.dart';
import 'package:app/database/Masterdata_database.dart';
import 'package:app/database/PackagingMaterial_database.dart';
import 'package:app/database/Pickup_database.dart';
import 'package:app/database/SubCategory_database.dart';
import 'package:app/database/Unit_database.dart';


class ProductDB {
  final dbProvider = DatabaseProvider_delivery.dbProvider; //delivery db
  final pickupDBprovider  = DatabaseProvider_pickup.dbProvider; //pickup db
  final masterdataDBprovider  = DatabaseProvider_Masterdata.dbProvider;//pickup db
  final manufacDBprovider  = DatabaseProvider_manufac.dbProvider_manufac;//manufac db
  final catDBprovider  = DatabaseProvider_category.dbProvider_category;//cat db
  final subcatDBprovider  = DatabaseProvider_subcat.dbProvider_subcat;//subcat db
  final unitDBprovider  = DatabaseProvider_unit.dbProvider_unit;//unit db
  final packmatDBprovider  = DatabaseProvider_packmaterial.dbProvider_packegingMat;//packmat db

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
    var result = await db.query(masterTABLE, orderBy: '$master_Id ASC');


    List<MasterDataModel> product = result.isNotEmpty
        ? result.map((item) => MasterDataModel.fromJson(item)).toList()
        : [];
    return product;
  }

//MASTERDATA DB END

//CATEGORY DB START
  Future<int> insertCatdata(CategoryModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.categoryName.toString());

    var db = await catDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        catTABLE, productinfo.toMap(), nullColumnHack: cat_Id);
    print("2");
    return result;
  }

  Future<List<CategoryModel>> getAllCatDatafromDB(
      {List<String> columns, String query}) async {
    var db = await catDBprovider.database;
    print("Eikhane");
    var result = await db.query(catTABLE, orderBy: '$cat_Id ASC');


    List<CategoryModel> product = result.isNotEmpty
        ? result.map((item) => CategoryModel.fromJson(item)).toList()
        : [];
    return product;
  }
//CATEGORY DB END


//SUBCATEGORY DB START

  Future<int> insertsubCatdata(SubCategoryModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.subCategoryName.toString());

    var db = await subcatDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        subcatTABLE, productinfo.toMap(), nullColumnHack: subcat_Id);
    print("2");
    return result;
  }

  Future<List<SubCategoryModel>> getAllsubCatDatafromDB(
      {List<String> columns, String query}) async {
    var db = await subcatDBprovider.database;
    print("Eikhane");
    var result = await db.query(subcatTABLE, orderBy: '$subcat_Id ASC');


    List<SubCategoryModel> product = result.isNotEmpty
        ? result.map((item) => SubCategoryModel.fromJson(item)).toList()
        : [];
    return product;
  }

//SUBCATEGORY DB END


//MANUFAC DB START

  Future<int> insertManufacdata(ManufactureModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.manufacturerName.toString());

    var db = await manufacDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        manufacTABLE, productinfo.toMap(), nullColumnHack: manufac_Id);
    print("2");
    return result;
  }

  Future<List<ManufactureModel>> getAllManufacDatafromDB(
      {List<String> columns, String query}) async {
    var db = await manufacDBprovider.database;
    print("Eikhane");
    var result = await db.query(manufacTABLE, orderBy: '$manufac_Id ASC');


    List<ManufactureModel> product = result.isNotEmpty
        ? result.map((item) => ManufactureModel.fromJson(item)).toList()
        : [];
    return product;
  }

  //MANUFAC DB END


//UNIT DB START

  Future<int> insertUnitdata(UnitModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.unitName.toString());

    var db = await unitDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        unitTABLE, productinfo.toMap(), nullColumnHack: unit_Id);
    print("2");
    return result;
  }

  Future<List<UnitModel>> getAllUnitDatafromDB(
      {List<String> columns, String query}) async {
    var db = await unitDBprovider.database;
    print("Eikhane");
    var result = await db.query(unitTABLE, orderBy: '$unit_Id ASC');


    List<UnitModel> product = result.isNotEmpty
        ? result.map((item) => UnitModel.fromJson(item)).toList()
        : [];
    return product;
  }

//UNIT DB END


//PACKEGING_MATERIAL DB START

  Future<int> insertPackMatdata(MaterialPackModel productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.materialName.toString());

    var db = await packmatDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        packmatTABLE, productinfo.toMap(), nullColumnHack: packmat_Id);
    print("2");
    return result;
  }

  Future<List<MaterialPackModel>> getAllPackMatDatafromDB(
      {List<String> columns, String query}) async {
    var db = await packmatDBprovider.database;
    print("Eikhane");
    var result = await db.query(packmatTABLE, orderBy: '$packmat_Id ASC');


    List<MaterialPackModel> product = result.isNotEmpty
        ? result.map((item) => MaterialPackModel.fromJson(item)).toList()
        : [];
    return product;
  }

//PACKEGING_MATERIAL DB END

}