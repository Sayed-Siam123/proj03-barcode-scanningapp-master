// ignore: camel_case_types
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Model/unit_model.dart';
import 'package:app/Resources/Repository.dart';
import 'package:app/UI/PackageMaterial.dart';
import 'package:rxdart/rxdart.dart';

class sublist_Bloc {
  final _repository = Repository();
  MasterDataModel master;
  ManufactureModel manufacdata;
  CategoryModel catdata;
  SubCategoryModel subcatdata;
  UnitModel unitdata;
  MaterialPackModel materialpackdata;

  final _lastID = BehaviorSubject<int>();

  final _unitFetcher = PublishSubject<List<UnitModel>>();
  final _manufacFetcher =
      PublishSubject<List<ManufactureModel>>(); //TODO::MODEL chng kora lagbe
  final _catagoryFetcher = PublishSubject<List<CategoryModel>>();
  final _subcatagoryFetcher = PublishSubject<List<SubCategoryModel>>();
  final _materialpackFetcher = PublishSubject<List<MaterialPackModel>>();

  //unit_get
  final _unit = BehaviorSubject<String>();
  final _unitshort = BehaviorSubject<String>();

  //manufacturer_get
  final _manufacturer = BehaviorSubject<String>();

  //packaging_material
  final _packaging_material = BehaviorSubject<String>();
  final _packaging_materialName = BehaviorSubject<String>();

  //category_get
  final _category = BehaviorSubject<String>();

  //sub-category
  final _sub_category = BehaviorSubject<String>();
  final _category_id = BehaviorSubject<String>();
  final _previous_category_name = BehaviorSubject<String>();
  final _previous_category_id = BehaviorSubject<String>();
  final _previous_sub_category = BehaviorSubject<String>();

  final _sub_category_id = BehaviorSubject<String>();
  final _unit_id = BehaviorSubject<String>();
  final _manufacturer_id = BehaviorSubject<String>();

  final _product_id = BehaviorSubject<String>();

  final _ProductName = BehaviorSubject<String>();
  final _ProductDescription = BehaviorSubject<String>();
  final _Category = BehaviorSubject<String>();
  final _CategoryName = BehaviorSubject<String>();
  final _SubCategory = BehaviorSubject<String>();
  final _SubCategoryName = BehaviorSubject<String>();
  final _UnitList = BehaviorSubject<String>();
  final _UnitName = BehaviorSubject<String>();
  final _Manufacturer = BehaviorSubject<String>();
  final _ManufacturerName = BehaviorSubject<String>();
  final _Manufacturer_Pn = BehaviorSubject<String>();
  final _Gtin = BehaviorSubject<String>();
  final _ListPrice = BehaviorSubject<String>();

  final _previousCategory = BehaviorSubject<String>();
  final _previousSubCategory = BehaviorSubject<String>();
  final _previousUnitList = BehaviorSubject<String>();
  final _previousManufacturer = BehaviorSubject<String>();

  final _previousCategoryName = BehaviorSubject<String>();
  final _previousSubCategoryName = BehaviorSubject<String>();
  final _previousUnitListName = BehaviorSubject<String>();
  final _previousManufacturerName = BehaviorSubject<String>();

  Function(int) get getLastID => _lastID.sink.add;

  Function(String) get getProductName => _ProductName.sink.add;

  Function(String) get getProductDesc => _ProductDescription.sink.add;

  Function(String) get getCategoryID => _Category.sink.add;
  Function(String) get getCategoryName => _CategoryName.sink.add;

  Function(String) get getSubCategoryID => _SubCategory.sink.add;
  Function(String) get getSubCategoryName => _SubCategoryName.sink.add;

  Function(String) get getUnitID => _UnitList.sink.add;
  Function(String) get getUnitName => _UnitName.sink.add;

  Function(String) get getManufacturerID => _Manufacturer.sink.add;
  Function(String) get getManufacturerName => _ManufacturerName.sink.add;

  Function(String) get getManufacturerPn => _Manufacturer_Pn.sink.add;

  Function(String) get getGtin => _Gtin.sink.add;

  Function(String) get getListPrice => _ListPrice.sink.add;

  Function(String) get getProductID => _product_id.sink.add;

  Function(String) get getPreviousCategoryID => _previousCategory.sink.add;

  Function(String) get getPreviousSubCategoryID => _previousSubCategory.sink.add;

  Function(String) get getPreviousUnitID => _previousUnitList.sink.add;

  Function(String) get getPreviousManufacturerID => _previousManufacturer.sink.add;

  Function(String) get getPreviousCategoryName => _previousCategoryName.sink.add;

  Function(String) get getPreviousSubCategoryName => _previousSubCategoryName.sink.add;

  Function(String) get getPreviousUnitName => _previousUnitListName.sink.add;

  Function(String) get getPreviousManufacturerName => _previousManufacturerName.sink.add;

  final _CreatePropductSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>();
  final _UpdatePropductSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>();

  Stream<sublist_getsuccess_model> get CreatePropductSuccessFetcher =>
      _CreatePropductSuccessFetcher.stream;

  Stream<sublist_getsuccess_model> get UpdatePropductSuccessFetcher =>
      _UpdatePropductSuccessFetcher.stream;

  //sublist_Create_get_success_sink
  final _unitSuccessFetcher = PublishSubject<sublist_getsuccess_model>();
  final _manufacSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>(); //TODO::MODEL chng kora lagbe
  final _catagorySuccessFetcher = PublishSubject<sublist_getsuccess_model>();
  final _subcatagorySuccessFetcher = PublishSubject<sublist_getsuccess_model>();
  final _materialpackSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>();

  //sublist_Create_get_success_sink
  final _unitUpdateSuccessFetcher = PublishSubject<sublist_getsuccess_model>();
  final _manufacUpdateSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>(); //TODO::MODEL chng kora lagbe
  final _catagoryUpdateSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>();
  final _subcatagoryUpdateSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>();
  final _materialpackUpdateSuccessFetcher =
      PublishSubject<sublist_getsuccess_model>();

  Stream<List<UnitModel>> get allUnitData => _unitFetcher.stream;

  Stream<List<ManufactureModel>> get allmanufac => _manufacFetcher.stream;

  Stream<List<CategoryModel>> get allcategory => _catagoryFetcher.stream;

  Stream<List<SubCategoryModel>> get allsubcategory =>
      _subcatagoryFetcher.stream;

  Stream<List<MaterialPackModel>> get allmaterialpack =>
      _materialpackFetcher.stream;

  Stream<sublist_getsuccess_model> get allUnitSuccessData =>
      _unitSuccessFetcher.stream;

  Stream<sublist_getsuccess_model> get allmanufacSuccess =>
      _manufacSuccessFetcher.stream;

  Stream<sublist_getsuccess_model> get allcategorySuccess =>
      _catagorySuccessFetcher.stream;

  Stream<sublist_getsuccess_model> get allsubcategorySuccess =>
      _subcatagorySuccessFetcher.stream;

  Stream<sublist_getsuccess_model> get allmaterialpackSuccess =>
      _materialpackSuccessFetcher.stream;

  //unit_get_sink
  Function(String) get getUnit => _unit.sink.add;

  Function(String) get getUnitShort => _unitshort.sink.add;

  //manufacturer_get_sink
  Function(String) get getmanufacturer => _manufacturer.sink.add;

  //packaging_material_get_sink
  Function(String) get getpackaging_material => _packaging_material.sink.add;
  Function(String) get getpackaging_materialName => _packaging_materialName.sink.add;

  //category_get_sink
  Function(String) get getcategory => _category.sink.add;

  //sub_category_get_sink
  Function(String) get get_new_sub_category => _sub_category.sink.add;

  Function(String) get get_previous_sub_category => _previous_sub_category.sink.add;

  Function(String) get getcategory_id => _category_id.sink.add;

  Function(String) get previous_category_id => _previous_category_id.sink.add;

  Function(String) get previous_category_name => _previous_category_name.sink.add;

  //ADD PRODUCT
  Function(String) get getsubcategory_id => _sub_category_id.sink.add;

  Function(String) get getunit_id => _unit_id.sink.add;

  Function(String) get getmanufacturer_id => _manufacturer_id.sink.add;

//getunit_id
//  fetchAllUnitData() async {
//    List<UnitModel> unitdata = await _repository.getAllUnitData();
//    _unitFetcher.sink.add(unitdata);
//  }

  //UNIT START

  fetchAllUnitDatafromDB() async {
    List<UnitModel> catdatafromDB = await _repository.getAllUnitDatafromDB();
    _unitFetcher.sink.add(catdatafromDB);
  }

  fetchAllUnitData() async {
    List<UnitModel> unitapi = await _repository.getAllUnitData();
    List<UnitModel> unitfromDB = await _repository.getAllUnitDatafromDB();
    if(unitfromDB.isEmpty){

      for(int i = 0; i<unitapi.length;i++){
        print ("Length:: "+unitfromDB.length.toString());
        insertUnitDatatoDB(unitapi[i]);

      }
    }

    else{
      print ("Length:: "+unitfromDB.length.toString());
    }
  }


  insertUnitDatatoDB(UnitModel data) async{

    print(_lastID.value.toString());

    unitdata= UnitModel(
      id: data.id==null ? (_lastID.value+1).toString() :data.id.toString(),
      unitName: data.unitName ==null? _unit.value.toString() : data.unitName.toString(),
      unitDescription: data.unitDescription.toString(),
      isView: data.isView.toString(),
      isAdd: data.isAdd.toString(),
      isEdit: data.isEdit.toString(),
      isDelete: data.isDelete.toString(),
      isDeactivate: data.isDeactivate.toString(),
      updateFlag: data.updateFlag == null ? "false" : data.updateFlag.toString(),
      newFlag: data.newFlag == null ? "false" : data.newFlag.toString(),
      unitShort: data.unitShort ==null? _unitshort.value.toString() : data.unitShort.toString(),
    );

    await _repository.insertUnitdata(unitdata);
    print("MANUFAC DATA STORED IN DB");
  }

  updateUnitDatafromDB() async {

    UnitModel product = UnitModel(
      id: _UnitList.value.toString(),
      unitName: _unit.value.toString(),
      unitShort: _unitshort.value.toString(),
      updateFlag: "true",
      newFlag: "false",
    );

    print("Product ID "+ product.id.toString());
    print("Product Name "+ product.unitName.toString());

    await _repository.updateUnit(product);
    fetchAllManufacDatafromDB();
  }

  //UNIT END



  //CAT START

  fetchAllCatDatafromDB() async {
    List<CategoryModel> catdatafromDB = await _repository.getAllCatDatafromDB();
    _catagoryFetcher.sink.add(catdatafromDB);
  }

  fetchAllCatagoryData() async {
    List<CategoryModel> catdataapi = await _repository.getAllCatagoryData();
    List<CategoryModel> catfromDB = await _repository.getAllCatDatafromDB();
    if(catfromDB.isEmpty){

      for(int i = 0; i<catdataapi.length;i++){
        print ("Length:: "+catfromDB.length.toString());
        insertCatDatatoDB(catdataapi[i]);

      }
    }

    else{
      print ("Length:: "+catfromDB.length.toString());
    }
  }


  insertCatDatatoDB(CategoryModel data) async{

    print(_lastID.value.toString());

    catdata = CategoryModel(
      id: data.id==null ? (_lastID.value+1).toString() :data.id.toString(),
      categoryName: data.categoryName ==null? _category.value.toString() : data.categoryName.toString(),
      categoryDescription: data.categoryDescription.toString(),
      isView: data.isView.toString(),
      isAdd: data.isAdd.toString(),
      isEdit: data.isEdit.toString(),
      isDelete: data.isDelete.toString(),
      isDeactivate: data.isDeactivate.toString(),
      updateFlag: data.updateFlag == null ? "false" : data.updateFlag.toString(),
      newFlag: data.newFlag == null ? "false" : data.newFlag.toString(),
    );

    await _repository.insertCatdata(catdata);
    print("MANUFAC DATA STORED IN DB");
  }

  updateCatDatafromDB() async {

    CategoryModel product = CategoryModel(
      id: _Category.value.toString(),
      categoryName: _CategoryName.value.toString(),
      updateFlag: "true",
      newFlag: "false",
    );

    print("Product ID "+ product.id.toString());
    print("Product Name "+ product.categoryName.toString());

    await _repository.updateCat(product);
    fetchAllCatDatafromDB();
  }

  //CAT END

  //SUB CAT START

  fetchAllSubCatDatafromDB() async {
    List<SubCategoryModel> materialpackdatafromDB = await _repository.getAllsubCatDatafromDB();
    _subcatagoryFetcher.sink.add(materialpackdatafromDB);
  }

  fetchAllSubCatagoryData() async {
    List<SubCategoryModel> subcatdataapi = await _repository.getAllSubCategoryData();
    List<SubCategoryModel> subcatfromDB = await _repository.getAllsubCatDatafromDB();
    if(subcatfromDB.isEmpty){

      for(int i = 0; i<subcatdataapi.length;i++){
        print ("Length:: "+subcatfromDB.length.toString());
        insertSubCatDatatoDB(subcatdataapi[i]);

      }
    }

    else{
      print ("Length:: "+subcatfromDB.length.toString());
    }
  }


  insertSubCatDatatoDB(SubCategoryModel data) async{

    print(_lastID.value.toString());

    subcatdata = SubCategoryModel(
      id: data.id==null ? (_lastID.value+1).toString() :data.id.toString(),
      subCategoryName: data.subCategoryName ==null? _sub_category.value.toString() : data.subCategoryName.toString(),
      subcategoryDescription: data.subcategoryDescription.toString(),
      isView: data.isView.toString(),
      isAdd: data.isAdd.toString(),
      isEdit: data.isEdit.toString(),
      isDelete: data.isDelete.toString(),
      isDeactivate: data.isDeactivate.toString(),
      updateFlag: data.updateFlag == null ? "false" : data.updateFlag.toString(),
      newFlag: data.newFlag == null ? "false" : data.newFlag.toString(),
      categoryId: data.categoryId == null? _Category.value.toString() : data.categoryId.toString(),
      categoryName: data.categoryName == null ? _CategoryName.value.toString() : data.categoryName.toString(),
    );

    print(_Category.value.toString()+" : "+_CategoryName.value.toString());

    await _repository.insertsubCatdata(subcatdata);
    print("MANUFAC DATA STORED IN DB");
  }

  updateSubCattoDB(SubCategoryModel products) async{

    SubCategoryModel product = SubCategoryModel(
      id: _sub_category_id.value.toString(),
      subCategoryName: _sub_category.value.toString(),
      categoryId: _Category.value==null ? _previous_category_id.value.toString(): _Category.value.toString(),
      categoryName: _CategoryName.value==null? _previous_category_name.toString(): _CategoryName.value.toString(),
      updateFlag: "true",
      newFlag: products.newFlag == null ? "false" : products.newFlag.toString(),
    );

    print("Product ID "+ product.id.toString());
    print("Product NewFlag "+ product.newFlag.toString());

    await _repository.updateSubCat(product);
    fetchAllManufacDatafromDB();
  }

  //SUB CAT END

  //MAT PACK START

  fetchAllMateralPackDatafromDB() async {
    List<MaterialPackModel> materialpackdatafromDB = await _repository.getAllPackMatDatafromDB();
    _materialpackFetcher.sink.add(materialpackdatafromDB);
  }

  fetchAllMateralPackData() async {
    List<MaterialPackModel> materialpackdataapi = await _repository.getAllMaterialPackData();
    List<MaterialPackModel> materialpackdatafromDB = await _repository.getAllPackMatDatafromDB();
    if(materialpackdatafromDB.isEmpty){

      for(int i = 0; i<materialpackdataapi.length;i++){
        print ("Length:: "+materialpackdatafromDB.length.toString());
        insertMatPackDatatoDB(materialpackdataapi[i]);

      }
    }

    else{
      print ("Length:: "+materialpackdatafromDB.length.toString());
    }
  }


  insertMatPackDatatoDB(MaterialPackModel data) async{

    print(_lastID.value.toString());

    materialpackdata = MaterialPackModel(
      id: data.id==null ? (_lastID.value+1).toString() :data.id.toString(),
      materialName: data.materialName ==null? _packaging_material.value.toString() : data.materialName.toString(),
      materialDescription: data.materialDescription.toString(),
      isView: data.isView.toString(),
      isAdd: data.isAdd.toString(),
      isEdit: data.isEdit.toString(),
      isDelete: data.isDelete.toString(),
      isDeactivate: data.isDeactivate.toString(),
      updateFlag: data.updateFlag == null ? "false" : data.updateFlag.toString(),
      newFlag: data.newFlag == null ? "false" : data.newFlag.toString(),
    );

    await _repository.insertPackMatdata(materialpackdata);
    print("MANUFAC DATA STORED IN DB");
  }

   updatepackMattoDB() async{

    MaterialPackModel product = MaterialPackModel(
       id: _packaging_material.value.toString(),
       materialName: _packaging_materialName.value.toString(),
       updateFlag: "true",
       newFlag: "false",
     );

     print("Product ID "+ product.id.toString());
     print("Product Name "+ product.materialName.toString());

     await _repository.updatepackMat(product);
     fetchAllManufacDatafromDB();
  }


  //MAT PACK END


  //MANUFAC START

  fetchAllManufacDatafromDB() async {
    List<ManufactureModel> manufacDatafromDB = await _repository.getAllManufacDatafromDB();
    _manufacFetcher.sink.add(manufacDatafromDB);
  }

  fetchAllManufacData() async {
    List<ManufactureModel> manufacDataapi = await _repository.getAllmanufacData();
    List<ManufactureModel> manufacDatafromDB = await _repository.getAllManufacDatafromDB();

    if(manufacDatafromDB.isEmpty){

      for(int i = 0; i<manufacDataapi.length;i++){
        print ("Length:: "+manufacDatafromDB.length.toString());
        insertManufacDatatoDB(manufacDataapi[i]);

      }
    }

    else{
      print ("Length:: "+manufacDatafromDB.length.toString());
    }
  }

  insertManufacDatatoDB(ManufactureModel data) async{

    print(_lastID.value.toString());

    manufacdata = ManufactureModel(
      id: data.id==null ? (_lastID.value+1).toString() :data.id.toString(),
      manufacturerName: data.manufacturerName ==null? _manufacturer.value.toString() : data.manufacturerName.toString(),
      manufacturerDescription: data.manufacturerDescription.toString(),
      isView: data.isView.toString(),
      isAdd: data.isAdd.toString(),
      isEdit: data.isEdit.toString(),
      isDelete: data.isDelete.toString(),
      isDeactivate: data.isDeactivate.toString(),
      updateFlag: data.updateFlag == null ? "false" : data.updateFlag.toString(),
      newFlag: data.newFlag == null ? "false" : data.newFlag.toString(),
    );

    await _repository.insertManufacdata(manufacdata);
    print("MANUFAC DATA STORED IN DB");
  }

  updateManufacDatafromDB() async {

    ManufactureModel product = ManufactureModel(
      id: _Manufacturer.value.toString(),
      manufacturerName: _manufacturer.value.toString(),
      updateFlag: "true",
      newFlag: "false",
    );

    print("Product ID "+ product.id.toString());
    print("Product Name "+ product.manufacturerName.toString());

   await _repository.updateManufac(product);
   fetchAllManufacDatafromDB();
  }

//MANUFAC END

  //TODO::ALL GET LIST

  createunit() async {
    print("data:: " + _unit.value + " " + _unitshort.value);
    sublist_getsuccess_model success =
        await _repository.createUnit(_unit.value, _unitshort.value);
    //_repository.createPost(_name.value, _posts.value);
    _unitSuccessFetcher.sink.add(success);
  }

  createmanufacturer() async {
    print("data:: " + _manufacturer.value + " " + _manufacturer.value);
    sublist_getsuccess_model success = await _repository.createManufacturer(_manufacturer.value);
    //_repository.createPost(_name.value, _posts.value);
    _manufacSuccessFetcher.sink.add(success);
  }


  updatemanufacturer() async {
    print("data:: " + _manufacturer.value + " " + _manufacturer.value);
    sublist_getsuccess_model success = await _repository.updateManufacturerAPI(_Manufacturer.value,_manufacturer.value);
    //_repository.createPost(_name.value, _posts.value);
    _manufacSuccessFetcher.sink.add(success);
  }



  createpackagingmaterial() async {
    print("data:: " +
        _packaging_material.value +
        " " +
        _packaging_material.value);
    sublist_getsuccess_model success =
        await _repository.createPackagingMaterial(_packaging_material.value);
    //_repository.createPost(_name.value, _posts.value);
    _materialpackSuccessFetcher.sink.add(success);
  }

  createcategory() async {
    print("data:: " + _category.value + " " + _category.value);
    sublist_getsuccess_model success =
        await _repository.createCategory(_category.value);
    //_repository.createPost(_name.value, _posts.value);
    _catagorySuccessFetcher.sink.add(success);
  }

  createsubcategory() async {
    print("data:: " + _sub_category.value + " " + _category_id.value);
    sublist_getsuccess_model success = await _repository.createSubCategory(
        _category_id.value, _sub_category.value);
    //_repository.createPost(_name.value, _posts.value);
    _subcatagorySuccessFetcher.sink.add(success);
  } //ALL CREATE

  createProductMasterData() async {
    print("CatagoryID: " +
        _Category.value +
        " SubID: " +
        _SubCategory.value +
        " UnitID: " +
        _UnitList.value +
        " ManuID: " +
        _Manufacturer.value +
        "Productname: " +
        _ProductName.value +
        " Description: " +
        _ProductDescription.value +
        " Manu PN: " +
        _Manufacturer_Pn.value +
        " Gtin: " +
        _Gtin.value +
        " ListPrice " +
        _ListPrice.value);
    sublist_getsuccess_model success =
        await _repository.createProductMasterData(
            _ProductName.value,
            _ProductDescription.value,
            _Category.value,
            _SubCategory.value,
            _UnitList.value,
            _Manufacturer.value,
            _Manufacturer_Pn.value,
            _Gtin.value,
            _ListPrice.value);

    _CreatePropductSuccessFetcher.sink.add(success);
  }

  createProductMasterDatatoDB() async {
    print("CatagoryID: " +
        _Category.value +
        " SubID: " +
        _SubCategory.value +
        " UnitID: " +
        _UnitList.value +
        " ManuID: " +
        _Manufacturer.value +
        "Productname: " +
        _ProductName.value +
        " Description: " +
        _ProductDescription.value +
        " Manu PN: " +
        _Manufacturer_Pn.value +
        " Gtin: " +
        _Gtin.value +
        " ListPrice " +
        _ListPrice.value);

    print("Product ID: " +
        _product_id.value);


      master = MasterDataModel(
        id: _product_id.value.toString(),
        productName: _ProductName.value.toString(),
        manufacturerName: _ManufacturerName.value.toString(),
        manufacturerId: _Manufacturer.value.toString(),
        manufacturerPN: _Manufacturer_Pn.value.toString(),
        categoryName: _CategoryName.value.toString(),
        categoryNameId: _Category.value.toString(),
        subCategoryName: _SubCategoryName.value.toString(),
        subCategoryNameId: _SubCategory.value.toString(),
        unitName: _UnitName.value.toString(),
        unitId: _UnitList.value.toString(),
        productDescription: _ProductDescription.value.toString(),
        gtin: _Gtin.value.toString(),
        listPrice: _ListPrice.value.toString(),
        updateFlag: "false",
        newFlag: "true",
      );

      masterdata_bloc.insertProduct(master);


//    _CreatePropductSuccessFetcher.sink.add(success);
  }

  UpdateProductMasterDatatoDB(MasterDataModel data) async {
//    print('id: '+_product_id.value+" CatagoryID: "+_Category.value+" SubID: "+_SubCategory.value+" UnitID: "+_UnitList.value+" ManuID: "+_Manufacturer.value+
//        "Productname: "+_ProductName.value+" Description: "+_ProductDescription.value+" Manu PN: "+_Manufacturer_Pn.value+" Gtin: "+_Gtin.value+" ListPrice "+_ListPrice.value);

//        print("Previous cat"+ _previousCategory.value);
//        print("New Category"+ _Category.value);
//        dispose();

    var cat = _Category.value;
    var manuid = _Manufacturer.value;
    var subcat = _SubCategory.value;
    var unit = _UnitList.value;

    String finalcategoryID;
    String finalSubcategoryID;
    String finalManufacID;
    String finalUnitID;

    String finalcategoryName;
    String finalSubcategoryName;
    String finalManufacName;
    String finalUnitName;

    //TODO:: extra variable lagbe to store which data i will use

    if (cat == null) {

      finalcategoryID = _previousCategory.value;
      finalcategoryName = _previousCategoryName.value;
      print("Previous Cat: " + _previousCategory.value+" and "+_previousCategoryName.value);
      print("CAT OK");
    } else if (cat != null) {
      finalcategoryID = _Category.value;
      finalcategoryName = _CategoryName.value;
      print("New Category: " + _Category.value+" and "+_CategoryName.value);
    }

    if (manuid == null) {
      finalManufacID = _previousManufacturer.value;
      finalManufacName = _previousManufacturerName.value;
      print("Previous Manu: " + _previousManufacturer.value+" and "+_previousManufacturerName.value);
      print("MANU OK");
    } else if (manuid != null) {
      finalManufacID = _Manufacturer.value;
      finalManufacName = _ManufacturerName.value;
      print("New Manu: " + _Manufacturer.value+" and "+_ManufacturerName.value);
    }

    if (subcat == null) {
      finalSubcategoryID = _previousSubCategory.value;
      finalSubcategoryName = _previousSubCategoryName.value;
      print("Previous subcat: " + _previousSubCategory.value+" and "+_previousSubCategoryName.value);
      print("subcat OK");
    } else if (subcat != null) {
      finalSubcategoryID = _SubCategory.value;
      finalSubcategoryName = _SubCategoryName.value;
      print("New subcat: " + _SubCategory.value+" and "+_SubCategoryName.value);
    }

    if (unit == null) {
      finalUnitID = _previousUnitList.value;
      finalUnitName = _previousUnitListName.value;
      print("Previous unit: " + _previousUnitList.value+" and "+_previousUnitListName.value);
      print("unit OK");
    } else if (unit != null) {
      finalUnitID = _UnitList.value;
      finalUnitName = _UnitName.value;
      print("New unit: " + _UnitList.value+" and "+_UnitName.value);
    }



    print('id: '+_product_id.value+" CatagoryID: "+finalcategoryID+" SubID: "+finalSubcategoryID+" UnitID: "+finalUnitID+" ManuID: "+finalManufacID+
        "Productname: "+_ProductName.value+" Description: "+_ProductDescription.value+" Manu PN: "+_Manufacturer_Pn.value+" Gtin: "+_Gtin.value+" ListPrice "+_ListPrice.value);


    MasterDataModel master = MasterDataModel(
      id: _product_id.value.toString(),
      productName: _ProductName.value.toString(),
      manufacturerName: finalManufacName.toString(),
      manufacturerId: finalManufacID.toString(),
      manufacturerPN: _Manufacturer_Pn.value.toString(),
      categoryName: finalcategoryName.toString(),
      categoryNameId: finalcategoryID.toString(),
      subCategoryName: finalSubcategoryName.toString(),
      subCategoryNameId: finalSubcategoryID.toString(),
      unitName: finalUnitName.toString(),
      unitId: finalUnitID.toString(),
      productDescription: _ProductDescription.value.toString(),
      packagingUnit: "0",
      listPrice: _ListPrice.value.toString(),
      gtin: _Gtin.value.toString(),
      updateFlag: "true",
      newFlag: data.newFlag.toString(),
      productPicture: data.productPicture.toString(),
      isTransferToApp: data.isTransferToApp.toString(),
      isOrderableViaApp: data.isOrderableViaApp.toString(),
      productHeight: data.productHeight.toString(),
      productLength: data.productLength.toString(),
    );


    await _repository.updateMaster(master);

//    sublist_getsuccess_model success = await _repository.updateProductMasterData(_product_id.value,_ProductName.value,_ProductDescription.value,finalcategoryID,finalSubcategoryID,finalUnitID,finalManufacID,
//        _Manufacturer_Pn.value,_Gtin.value,_ListPrice.value);
//
//    _UpdatePropductSuccessFetcher.sink.add(success);
  }

  UpdateProductMasterData() async {
//    print('id: '+_product_id.value+" CatagoryID: "+_Category.value+" SubID: "+_SubCategory.value+" UnitID: "+_UnitList.value+" ManuID: "+_Manufacturer.value+
//        "Productname: "+_ProductName.value+" Description: "+_ProductDescription.value+" Manu PN: "+_Manufacturer_Pn.value+" Gtin: "+_Gtin.value+" ListPrice "+_ListPrice.value);

//        print("Previous cat"+ _previousCategory.value);
//        print("New Category"+ _Category.value);
//        dispose();

    var cat = _Category.value;
    var manuid = _Manufacturer.value;
    var subcat = _SubCategory.value;
    var unit = _UnitList.value;

    String finalcategoryID;
    String finalSubcategoryID;
    String finalManufacID;
    String finalUnitID;

    String finalcategoryName;
    String finalSubcategoryName;
    String finalManufacName;
    String finalUnitName;

    //TODO:: extra variable lagbe to store which data i will use

    if (cat == null) {

      finalcategoryID = _previousCategory.value;
      finalcategoryName = _previousCategoryName.value;
      print("Previous Cat: " + _previousCategory.value+" and "+_previousCategoryName.value);
      print("CAT OK");
    } else if (cat != null) {
      finalcategoryID = _Category.value;
      finalcategoryName = _CategoryName.value;
      print("New Category: " + _Category.value+" and "+_CategoryName.value);
    }

    if (manuid == null) {
      finalManufacID = _previousManufacturer.value;
      finalManufacName = _previousManufacturerName.value;
      print("Previous Manu: " + _previousManufacturer.value+" and "+_previousManufacturerName.value);
      print("MANU OK");
    } else if (manuid != null) {
      finalManufacID = _Manufacturer.value;
      finalManufacName = _ManufacturerName.value;
      print("New Manu: " + _Manufacturer.value+" and "+_ManufacturerName.value);
    }

    if (subcat == null) {
      finalSubcategoryID = _previousSubCategory.value;
      finalSubcategoryName = _previousSubCategoryName.value;
      print("Previous subcat: " + _previousSubCategory.value+" and "+_previousSubCategoryName.value);
      print("subcat OK");
    } else if (subcat != null) {
      finalSubcategoryID = _SubCategory.value;
      finalSubcategoryName = _SubCategoryName.value;
      print("New subcat: " + _SubCategory.value+" and "+_SubCategoryName.value);
    }

    if (unit == null) {
      finalUnitID = _previousUnitList.value;
      finalUnitName = _previousUnitListName.value;
      print("Previous unit: " + _previousUnitList.value+" and "+_previousUnitListName.value);
      print("unit OK");
    } else if (unit != null) {
      finalUnitID = _UnitList.value;
      finalUnitName = _UnitName.value;
      print("New unit: " + _UnitList.value+" and "+_UnitName.value);
    }



    print('id: '+_product_id.value+" CatagoryID: "+finalcategoryID+" SubID: "+finalSubcategoryID+" UnitID: "+finalUnitID+" ManuID: "+finalManufacID+
       "Productname: "+_ProductName.value+" Description: "+_ProductDescription.value+" Manu PN: "+_Manufacturer_Pn.value+" Gtin: "+_Gtin.value+" ListPrice "+_ListPrice.value);




//    sublist_getsuccess_model success = await _repository.updateProductMasterData(_product_id.value,_ProductName.value,_ProductDescription.value,finalcategoryID,finalSubcategoryID,finalUnitID,finalManufacID,
//        _Manufacturer_Pn.value,_Gtin.value,_ListPrice.value);
//
//    _UpdatePropductSuccessFetcher.sink.add(success);
  }

  //UPDATE SUBLIST ALL THING CODE

  void dispose() async {
//    _title.close();
//    _id.drain();
//    _name.drain();
//    _posts.drain();
    _lastID.drain();
    _product_id.drain();

    _unit.drain();
    _unitshort.drain();
    _manufacturer.drain();
    _packaging_material.drain();
    _category.drain();
    _sub_category.drain();
    _category_id.drain();
    _Category.drain();
    _SubCategory.drain();
    _UnitList.drain();
    _Manufacturer_Pn.drain();
    _Gtin.drain();
    _ListPrice.drain();
    _Manufacturer.drain();
    _ProductDescription.drain();
    _ProductName.drain();

    _previousCategory.drain();
    _previousSubCategory.drain();
    _previousUnitList.drain();
    _previousManufacturer.drain();

    _previousManufacturerName.drain();
    _previousSubCategoryName.drain();
    _previousUnitListName.drain();
    _previousManufacturerName.drain();

    _CategoryName.drain();
    _SubCategoryName.drain();
    _ManufacturerName.drain();
    _UnitName.drain();
    _packaging_materialName.drain();

    _packaging_materialName.value = null;
    _CategoryName.value = null;
    _SubCategoryName.value = null;
    _ManufacturerName.value = null;
    _UnitName.value = null;


    _lastID.value = null;
    _Category.value = null;
    _SubCategory.value = null;
    _Manufacturer.value = null;
    _UnitList.value = null;

    _previousCategory.value = null;
    _previousSubCategory.value = null;
    _previousUnitList.value = null;
    _previousManufacturer.value = null;

    _previousCategoryName.value = null;
    _previousSubCategoryName.value = null;
    _previousUnitListName.value = null;
    _previousManufacturerName.value = null;

    _ProductName.value = null;
    _ProductDescription.value = null;
    _Manufacturer_Pn.value = null;
    _Gtin.value = null;
    _ListPrice.value = null;

    //GETALLLIST
    await _unitFetcher.drain();
    _unitFetcher.close();

    await _manufacFetcher.drain();
    _manufacFetcher.close();

    await _catagoryFetcher.drain();
    _catagoryFetcher.close();

    await _subcatagoryFetcher.drain();
    _subcatagoryFetcher.close();

    await _materialpackFetcher.drain();
    _materialpackFetcher.close();

    //CREATE
    await _unitSuccessFetcher.drain();
    _unitSuccessFetcher.close();

    await _manufacSuccessFetcher.drain();
    _manufacSuccessFetcher.close();

    await _catagorySuccessFetcher.drain();
    _catagorySuccessFetcher.close();

    await _subcatagorySuccessFetcher.drain();
    _subcatagorySuccessFetcher.close();

    await _materialpackSuccessFetcher.drain();
    _materialpackSuccessFetcher.close();

//    await _postDatafetcher.drain();
//    _postDatafetcher.close();
  }

}

final sublist_bloc = sublist_Bloc();
