import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/DataAcquisition_model.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Model/unit_model.dart';
import 'package:app/UI/PackageMaterial.dart';
import 'package:app/database/Category_database.dart';
import 'package:app/database/DataAcquisition_database.dart';
import 'package:app/database/Delivery_database.dart';
import 'package:app/database/Manufac_database.dart';
import 'package:app/database/Masterdata_database.dart';
import 'package:app/database/Masterdata_databaseV2.dart';
import 'package:app/database/PackagingMaterial_database.dart';
import 'package:app/database/Pickup_database.dart';
import 'package:app/database/SubCategory_database.dart';
import 'package:app/database/Unit_database.dart';


class ProductDB {
  final dbProvider = DatabaseProvider_delivery.dbProvider; //delivery db
  final pickupDBprovider  = DatabaseProvider_pickup.dbProvider; //pickup db
  final masterdataDBprovider  = DatabaseProvider_Masterdata.dbProvider;//master db v1
  final masterdataDBproviderV2  = DatabaseProvider_MasterdataV2.dbProvider_MasterDataV2;//master db v2

  final manufacDBprovider  = DatabaseProvider_manufac.dbProvider_manufac;//manufac db
  final catDBprovider  = DatabaseProvider_category.dbProvider_category;//cat db
  final subcatDBprovider  = DatabaseProvider_subcat.dbProvider_subcat;//subcat db
  final unitDBprovider  = DatabaseProvider_unit.dbProvider_unit;//unit db
  final packmatDBprovider  = DatabaseProvider_packmaterial.dbProvider_packegingMat;//packmat db
  final dataAcquiDBprovider  = DatabaseProvider_dataAcquisition.dbProvider_dataAcqui;//data acquisition db


  String newStatus = "true";
  String updateStatus = "true";

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


  Future<int> insertMasterdataV2(MasterDataModelV2 productinfo) async {
    print("FORM DBPROVIDER: " + productinfo.gtin.toString());

    var db = await masterdataDBproviderV2.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(
        masterTABLEV2, productinfo.toMap(), nullColumnHack: master_IdV2);
    print("2");
    return result;
  }



  Future deleteAllMasterdataTable() async {
    final db = await masterdataDBprovider.database;
    var result = await db.delete(
      masterTABLE,
    );

    return result;
  }

  Future<int> deleteMaterdataV2(int id) async {
    final db = await masterdataDBproviderV2.database;
    var result = await db.delete(
        masterTABLEV2, where: 'id = ?', whereArgs: [id]);

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

  Future<List<MasterDataModelV2>> getAllMAsterProductV2(
      {List<String> columns, String query}) async {
    var db = await masterdataDBproviderV2.database;
    print("Eikhane");
    var result = await db.query(masterTABLEV2, orderBy: '$master_IdV2 ASC');


    List<MasterDataModelV2> product = result.isNotEmpty
        ? result.map((item) => MasterDataModelV2.fromJson(item)).toList()
        : [];
    return product;
  }

  Future<List<SingleMasterDataModel>> getsinglemasterdatafromDB(String id,
      {List<String> columns, String query}) async {

    print("ProductID is: "+id.toString());

    var db = await masterdataDBprovider.database;
    print("Eikhane");
    var result = await db.query(masterTABLE, where: "id = ?", whereArgs: [id.toString()], orderBy: '$master_Id ASC');


    List<SingleMasterDataModel> product = result.isNotEmpty
        ? result.map((item) => SingleMasterDataModel.fromJson(item)).toList()
        : [];
    return product;
  }

  Future<List<SingleMasterDataModelV2>> getsinglemasterdatafromDBV2(String id,
      {List<String> columns, String query}) async {

    print("ProductID is: "+id.toString());

    var db = await masterdataDBproviderV2.database;
    print("Eikhane");
    var result = await db.query(masterTABLEV2, where: "id = ?", whereArgs: [id.toString()], orderBy: '$master_IdV2 ASC');


    List<SingleMasterDataModelV2> product = result.isNotEmpty
        ? result.map((item) => SingleMasterDataModelV2.fromJson(item)).toList()
        : [];
    return product;
  }


  Future<List<MasterDataModel>> getAllMAsterNewProduct({List<String> columns, String query}) async {

    var db = await masterdataDBprovider.database;
    print("Eikhane");
    var result = await db.query(masterTABLE, where: "newFlag = ?", whereArgs: [newStatus], orderBy: '$master_Id ASC');


    List<MasterDataModel> product = result.isNotEmpty
        ? result.map((item) => MasterDataModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new added master data list

  Future<List<MasterDataModel>> getAllMAsterUpdateProduct({List<String> columns, String query}) async {

    var db = await masterdataDBprovider.database;
    print("Eikhane");
    var result = await db.query(masterTABLE, where: "updateFlag = ?", whereArgs: [updateStatus], orderBy: '$master_Id ASC');


    List<MasterDataModel> product = result.isNotEmpty
        ? result.map((item) => MasterDataModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking updated master data list

  Future<int> updateMaster(MasterDataModel product) async {

    //print("New Flag is :: "+ product.newFlag.toString());

    final db = await masterdataDBprovider.database;

    var result = await db.update(masterTABLE, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<int> updateMasterV2(MasterDataModelV2 product) async {

    //print("New Flag is :: "+ product.newFlag.toString());

    final db = await masterdataDBproviderV2.database;

    var result = await db.update(masterTABLEV2, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
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

  Future<int> updateCat(CategoryModel product) async {
    final db = await catDBprovider.database;

    var result = await db.update(catTABLE, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<List<CategoryModel>> getAllCategoryNewProduct({List<String> columns, String query}) async {

    var db = await catDBprovider.database;
    print("Eikhane");
    var result = await db.query(catTABLE, where: "newFlag = ?", whereArgs: [newStatus], orderBy: '$cat_Id ASC');


    List<CategoryModel> product = result.isNotEmpty
        ? result.map((item) => CategoryModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new added category data list


  Future<List<CategoryModel>> getAllCategoryUpdateProduct({List<String> columns, String query}) async {

    var db = await catDBprovider.database;
    print("Eikhane");
    var result = await db.query(catTABLE, where: "updateFlag = ?", whereArgs: [updateStatus], orderBy: '$cat_Id ASC');


    List<CategoryModel> product = result.isNotEmpty
        ? result.map((item) => CategoryModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new updated category data list


  Future deleteAllCategoryTable() async {
    final db = await catDBprovider.database;
    var result = await db.delete(
      catTABLE,
    );

    return result;
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

  Future<int> updateSubcat(SubCategoryModel product) async {
    final db = await subcatDBprovider.database;

    var result = await db.update(subcatTABLE, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<List<SubCategoryModel>> getAllSubCategoryNewProduct({List<String> columns, String query}) async {

    var db = await subcatDBprovider.database;
    print("Eikhane");
    var result = await db.query(subcatTABLE, where: "newFlag = ?", whereArgs: [newStatus], orderBy: '$subcat_Id ASC');


    List<SubCategoryModel> product = result.isNotEmpty
        ? result.map((item) => SubCategoryModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new added sub category data list

  Future<List<SubCategoryModel>> getAllSubCategoryUpdateProduct({List<String> columns, String query}) async {

    var db = await subcatDBprovider.database;
    print("Eikhane");
    var result = await db.query(subcatTABLE, where: "updateFlag = ?", whereArgs: [updateStatus], orderBy: '$subcat_Id ASC');


    List<SubCategoryModel> product = result.isNotEmpty
        ? result.map((item) => SubCategoryModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new updated sub category data list

  Future deleteAllSubCategoryTable() async {
    final db = await subcatDBprovider.database;
    var result = await db.delete(
      subcatTABLE,
    );

    return result;
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

  Future<int> updateManufac(ManufactureModel product) async {
    final db = await manufacDBprovider.database;

    var result = await db.update(manufacTABLE, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<List<ManufactureModel>> getAllManufacNewProduct({List<String> columns, String query}) async {

    var db = await manufacDBprovider.database;
    print("Eikhane");
    var result = await db.query(manufacTABLE, where: "newFlag = ?", whereArgs: [newStatus], orderBy: '$manufac_Id ASC');


    List<ManufactureModel> product = result.isNotEmpty
        ? result.map((item) => ManufactureModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new added Manufac data list

  Future<List<ManufactureModel>> getAllManufacUpdateProduct({List<String> columns, String query}) async {

    var db = await manufacDBprovider.database;
    print("Eikhane");
    var result = await db.query(manufacTABLE, where: "updateFlag = ?", whereArgs: [updateStatus], orderBy: '$manufac_Id ASC');


    List<ManufactureModel> product = result.isNotEmpty
        ? result.map((item) => ManufactureModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new updated Manufac data list


  Future deleteAllManufacTable() async {
    final db = await manufacDBprovider.database;
    var result = await db.delete(
      manufacTABLE,
    );

    return result;
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

  Future<int> updateUnit(UnitModel product) async {
    final db = await unitDBprovider.database;

    var result = await db.update(unitTABLE, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<List<UnitModel>> getAllUnitNewProduct({List<String> columns, String query}) async {

    var db = await unitDBprovider.database;
    print("Eikhane");
    var result = await db.query(unitTABLE, where: "newFlag = ?", whereArgs: [newStatus], orderBy: '$unit_Id ASC');


    List<UnitModel> product = result.isNotEmpty
        ? result.map((item) => UnitModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new added Unit data list

  Future<List<UnitModel>> getAllUnitUpdateProduct({List<String> columns, String query}) async {

    var db = await unitDBprovider.database;
    print("Eikhane");
    var result = await db.query(unitTABLE, where: "updateFlag = ?", whereArgs: [updateStatus], orderBy: '$unit_Id ASC');


    List<UnitModel> product = result.isNotEmpty
        ? result.map((item) => UnitModel.fromJson(item)).toList()
        : [];
    return product;
  }  // for checking new update Unit data list

  Future deleteAllUnitTable() async {
    final db = await unitDBprovider.database;
    var result = await db.delete(
      unitTABLE,
    );

    return result;
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

  Future<int> updatePackMat(MaterialPackModel product) async {
    final db = await packmatDBprovider.database;

    var result = await db.update(packmatTABLE, product.toMap(),
        where: "id = ?", whereArgs: [product.id]);

    return result;
  }

  Future<List<MaterialPackModel>> getAllPackMatNewProduct({List<String> columns, String query}) async {

    var db = await packmatDBprovider.database;
    print("Eikhane");
    var result = await db.query(packmatTABLE, where: "newFlag = ?", whereArgs: [newStatus], orderBy: '$packmat_Id ASC');


    List<MaterialPackModel> product = result.isNotEmpty
        ? result.map((item) => MaterialPackModel.fromJson(item)).toList()
        : [];
    return product;
  }// for checking new Pack Mat data list

  Future<List<MaterialPackModel>> getAllPackMatUpdateProduct({List<String> columns, String query}) async {

    var db = await packmatDBprovider.database;
    print("Eikhane");
    var result = await db.query(packmatTABLE, where: "updateFlag = ?", whereArgs: [updateStatus], orderBy: '$packmat_Id ASC');


    List<MaterialPackModel> product = result.isNotEmpty
        ? result.map((item) => MaterialPackModel.fromJson(item)).toList()
        : [];
    return product;
  }// for checking new Pack Mat data list

  Future deleteAllPackMatTable() async {
    final db = await packmatDBprovider.database;
    var result = await db.delete(
      packmatTABLE,
    );

    return result;
  }
//PACKEGING_MATERIAL DB END


//Data Acquisition DB START

  Future<int> insertDataAcquisitiondata(DataAcquisition_model data) async {
    print("FORM DBPROVIDER: " + data.description.toString());

    var db = await dataAcquiDBprovider.database;
    print("ebar eikhane");
    print("1");
    var result = db.insert(dataAcquiTABLE, data.toMap(), nullColumnHack: dataAcqui_Id);
    print("2");
    return result;
  }

  Future<List<DataAcquisition_model>> getAllDataAcqui({List<String> columns, String query}) async {

    var db = await dataAcquiDBprovider.database;
    print("Eikhane");
    var result = await db.query(dataAcquiTABLE, where: "newFlag = ?", whereArgs: [newStatus], orderBy: '$packmat_Id ASC');


    List<DataAcquisition_model> product = result.isNotEmpty
        ? result.map((item) => DataAcquisition_model.fromJson(item)).toList()
        : [];
    return product;
  }// for checking new Pack Mat data list

  Future<List<DataAcquisition_model>> getSingleDataAcquisition(
      {List<String> columns, String query}) async {
    var db = await dataAcquiDBprovider.database;
    print("Eikhane");
    var result = await db.query(dataAcquiTABLE, orderBy: '$dataAcqui_Id DESC', limit: 1);


    List<DataAcquisition_model> products = result.isNotEmpty
        ? result.map((item) => DataAcquisition_model.fromJson(item)).toList()
        : [];
    return products;
  }

  Future<int> deleteLastDataAcqui(int id) async {
    final db = await dataAcquiDBprovider.database;
    var result = await db.delete(
        dataAcquiTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future deleteAllDataAcqui() async {
    final db = await dataAcquiDBprovider.database;
    var result = await db.delete(
      dataAcquiTABLE,
    );

    return result;
  }

//Data Acquisition DB END

}