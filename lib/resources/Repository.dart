import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/DataAcquisition_model.dart';
import 'package:app/Model/DeliveriesListModel.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/UserLogin_Success_Model.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Model/unit_model.dart';

import 'ApiProvider.dart';
import 'DBProvider.dart';

class Repository {
  final apiprovider = ApiProvider();
  final dbprovider = ProductDB();

  Future<List<MasterDataModel>> fetchAllMasterData() =>
      apiprovider.fetchMasterData();

  Future<List<SingleMasterDataModel>> getsinglemasterdata(String id) =>
      apiprovider.fetchsinglemasterdata(id);

  Future<sublist_getsuccess_model> getMaxIDData() => apiprovider.getMaxIDData();

  //unit
  Future<List<UnitModel>> getAllUnitData() => apiprovider.getUnitData();

  //category
  Future<List<CategoryModel>> getAllCatagoryData() =>
      apiprovider.getCatagoryData();

  //subcategory
  Future<List<SubCategoryModel>> getAllSubCategoryData() =>
      apiprovider.getSubCategoryData();

  //materialpack
  Future<List<MaterialPackModel>> getAllMaterialPackData() =>
      apiprovider.getMaterialPackData();

  //manufactureData
  Future<List<ManufactureModel>> getAllmanufacData() =>
      apiprovider.getmanufacData();

  Future<sublist_getsuccess_model> createUnit(String unit, String unitshort) =>
      apiprovider.createUnit(unit, unitshort);

  Future<sublist_getsuccess_model> createManufacturer(String manufacturer) => apiprovider.createManufacturer(manufacturer);

  Future<sublist_getsuccess_model> updateManufacturerAPI(String id,String manufacturer) => apiprovider.updateManufacturerAPI(id,manufacturer);
  Future<sublist_getsuccess_model> updateUnitAPI(String id,String unit,String unitShort) => apiprovider.updateUnitAPI(id,unit,unitShort);
  Future<sublist_getsuccess_model> updateSubCatAPI(String id,String catID,String subcat) => apiprovider.updateSubCatAPI(id,catID,subcat);
  Future<sublist_getsuccess_model> updateCatAPI(String id,String cat) => apiprovider.updateCatAPI(id,cat);
  Future<sublist_getsuccess_model> updatePackMatAPI(String id,String material) => apiprovider.updatePackMatAPI(id,material);





  Future<sublist_getsuccess_model> createPackagingMaterial(
          String packagingmaterial) =>
      apiprovider.createPackagingMaterial(packagingmaterial);

  Future<sublist_getsuccess_model> createCategory(String category) =>
      apiprovider.createCategory(category);

  Future<sublist_getsuccess_model> createSubCategory(
          String categoryid, String subcategory) =>
      apiprovider.createSubCategory(categoryid, subcategory);

  Future<UserLogin_Success_Model> userLogin(String email, String password) =>
      apiprovider.userLogin(email, password);

  Future<sublist_getsuccess_model> createProductMasterData(
          String name,
          String desc,
          String category,
          String subcat,
          String unit,
          String manufac,
          String manu_pn,
          String gtin,
          String listprice) =>
      apiprovider.createProductMasterData(name, desc, category, subcat, unit,
          manufac, manu_pn, gtin, listprice);

  Future<sublist_getsuccess_model> updateProductMasterData(
          String id,
          String name,
          String desc,
          String category,
          String subcat,
          String unit,
          String manufac,
          String manu_pn,
          String gtin,
          String listprice) =>
      apiprovider.updateProductMasterData(id, name, desc, category, subcat,
          unit, manufac, manu_pn, gtin, listprice);

//SQLITE DB BLOC HANDLING RESPOSITORY LINK

//TODO:: START


  Future insertTodo(NewDeliveryModel productinfo) => dbprovider.createTodo(productinfo);

  Future<List<NewDeliveryModel>> fetchProductData() => dbprovider.getProduct();

  Future<List<NewDeliveryModel>> fetchAllProductData() => dbprovider.getAllProduct();

  Future deleteAllProductsTable() => dbprovider.deleteAllProducts();

  Future deleteProductById(int id) => dbprovider.deleteProduct(id);

  Future updateProduct(NewDeliveryModel product) => dbprovider.updateProduct(product);







  Future insertPickupData(PickupDeliveryModel pickupdata) => dbprovider.createPickup(pickupdata);

  Future<List<PickupDeliveryModel>> fetchallpickupData() => dbprovider.getAllPickupProduct();

  Future deleteAllPickupProductsTable() => dbprovider.deleteAllPickupProducts();

//TODO:: END

  Future<List<DeliveriesListModel>> fetchDelivereisData() => apiprovider.fetchDelivereisData();

  Future<List<PickupListModel>> fetchPickupData() => apiprovider.fetchPickupData();


  Future createDeliverypost(String data) => apiprovider.createDeliverypost(data);


  Future<SinglePickupDataModel> fetchSinglePickupData(String deliveryID) => apiprovider.fetchsinglePickupdata(deliveryID);


  //TODO:: MASTER DATA DB CONFIG AND OPERATION :: START

  Future insertMasterdata(MasterDataModel productinfo) => dbprovider.insertMasterdata(productinfo);
  Future insertMasterdataV2(MasterDataModelV2 productinfo) => dbprovider.insertMasterdataV2(productinfo);


  Future<List<MasterDataModel>> getAllMAsterProduct() => dbprovider.getAllMAsterProduct();
  Future<List<MasterDataModelV2>> getAllMasterProductV2() => dbprovider.getAllMAsterProductV2();

  Future<List<SingleMasterDataModel>> getsinglemasterdatafromDB(String id) => dbprovider.getsinglemasterdatafromDB(id);
  Future<List<SingleMasterDataModelV2>> getsinglemasterdatafromDBV2(String id) => dbprovider.getsinglemasterdatafromDBV2(id);

  Future updateMaster(MasterDataModel product) => dbprovider.updateMaster(product);
  Future updateMasterV2(MasterDataModelV2 product) => dbprovider.updateMasterV2(product);

  Future deleteMasterV2(int id) => dbprovider.deleteMaterdataV2(id);

//deleteLastDataAcqui

  Future deleteAllMasterdataTable() => dbprovider.deleteAllMasterdataTable();
  Future<List<MasterDataModel>> getAllMAsterNewProduct() => dbprovider.getAllMAsterNewProduct();
  Future<List<MasterDataModel>> getAllMAsterUpdateProduct() => dbprovider.getAllMAsterUpdateProduct();

 //TODO:: MASTER DATA DB CONFIG AND OPERATION :: END


//TODO:: CATEGORY DB CONFIG AND OPERATION :: START

  Future insertCatdata(CategoryModel productinfo) => dbprovider.insertCatdata(productinfo);
  Future<List<CategoryModel>> getAllCatDatafromDB() => dbprovider.getAllCatDatafromDB();
  Future updateCat(CategoryModel product) => dbprovider.updateCat(product);
  Future deleteAllCategoryTable() => dbprovider.deleteAllCategoryTable();
  Future<List<CategoryModel>> getAllCategoryNewProduct() => dbprovider.getAllCategoryNewProduct();
  Future<List<CategoryModel>> getAllCategoryUpdateProduct() => dbprovider.getAllCategoryUpdateProduct();

  //TODO:: CATEGORY DB CONFIG AND OPERATION :: END


//TODO:: SUBCATEGORY DB CONFIG AND OPERATION :: START

  Future insertsubCatdata(SubCategoryModel productinfo) => dbprovider.insertsubCatdata(productinfo);
  Future<List<SubCategoryModel>> getAllsubCatDatafromDB() => dbprovider.getAllsubCatDatafromDB();
  Future updateSubCat(SubCategoryModel product) => dbprovider.updateSubcat(product);
  Future deleteAllSubCategoryTable() => dbprovider.deleteAllSubCategoryTable();
  Future<List<SubCategoryModel>> getAllSubCategoryNewProduct() => dbprovider.getAllSubCategoryNewProduct();
  Future<List<SubCategoryModel>> getAllSubCategoryUpdateProduct() => dbprovider.getAllSubCategoryUpdateProduct();

  //TODO:: SUBCATEGORY DB CONFIG AND OPERATION :: END


//TODO:: MANUFAC DB CONFIG AND OPERATION :: START

  Future insertManufacdata (ManufactureModel productinfo) => dbprovider.insertManufacdata(productinfo);
  Future<List<ManufactureModel>> getAllManufacDatafromDB() => dbprovider.getAllManufacDatafromDB();
  Future updateManufac(ManufactureModel product) => dbprovider.updateManufac(product);
  Future deleteAllManufacTable() => dbprovider.deleteAllManufacTable();
  Future<List<ManufactureModel>> getAllManufacNewProduct() => dbprovider.getAllManufacNewProduct();
  Future<List<ManufactureModel>> getAllManufacUpdateProduct() => dbprovider.getAllManufacUpdateProduct();


  //TODO:: MANUFAC DB CONFIG AND OPERATION :: END


//TODO:: UNIT DB CONFIG AND OPERATION :: START

  Future insertUnitdata(UnitModel productinfo) => dbprovider.insertUnitdata(productinfo);
  Future<List<UnitModel>> getAllUnitDatafromDB() => dbprovider.getAllUnitDatafromDB();
  Future updateUnit(UnitModel product) => dbprovider.updateUnit(product);
  Future deleteAllUnitTable() => dbprovider.deleteAllUnitTable();
  Future<List<UnitModel>> getAllUnitNewProduct() => dbprovider.getAllUnitNewProduct();
  Future<List<UnitModel>> getAllUnitUpdateProduct() => dbprovider.getAllUnitUpdateProduct();

  //TODO:: UNIT DB CONFIG AND OPERATION :: END


//TODO:: PACKAGING MATERIAL DB CONFIG AND OPERATION :: START

  Future insertPackMatdata(MaterialPackModel productinfo) => dbprovider.insertPackMatdata(productinfo);
  Future<List<MaterialPackModel>> getAllPackMatDatafromDB() => dbprovider.getAllPackMatDatafromDB();
  Future updatepackMat(MaterialPackModel product) => dbprovider.updatePackMat(product);
  Future deleteAllPackMatTable() => dbprovider.deleteAllPackMatTable();
  Future<List<MaterialPackModel>> getAllPackMatNewProduct() => dbprovider.getAllPackMatNewProduct();
  Future<List<MaterialPackModel>> getAllPackMatUpdateProduct() => dbprovider.getAllPackMatUpdateProduct();

  //TODO:: PACKAGING MATERIAL DB CONFIG AND OPERATION :: END


//TODO:: DATA ACQUISITION DB CONFIG AND OPERATION :: START
  Future insertDataAcquisitiondata(DataAcquisition_model productinfo) => dbprovider.insertDataAcquisitiondata(productinfo);
  Future<List<DataAcquisition_model>> getAllDataAcqui() => dbprovider.getAllDataAcqui();
  Future<List<DataAcquisition_model>> getSingleDataAcquisition() => dbprovider.getSingleDataAcquisition();
  Future deleteLastDataAcqui(int id) => dbprovider.deleteLastDataAcqui(id);
  Future deleteAllDataAcqui() => dbprovider.deleteAllDataAcqui();

  //deleteAllDataAcqui


//TODO:: DATA ACQUISITION DB CONFIG AND OPERATION :: END

}
