import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/DeliveriesListModel.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/NewDeliveryModel.dart';
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

  Future<sublist_getsuccess_model> updateManufacturer(String id,String manufacturer) => apiprovider.updateManufacturer(id,manufacturer);

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


//TODO:: END

  Future<List<DeliveriesListModel>> fetchDelivereisData() => apiprovider.fetchDelivereisData();

  Future<List<PickupListModel>> fetchPickupData() => apiprovider.fetchPickupData();



}
