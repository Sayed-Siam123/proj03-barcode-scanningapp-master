// ignore: camel_case_types
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/unit_model.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class sublist_Bloc {
  final _repository = Repository();

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

  //category_get
  final _category = BehaviorSubject<String>();

  //sub-category
  final _sub_category = BehaviorSubject<String>();
  final _category_id = BehaviorSubject<String>();

  final _sub_category_id = BehaviorSubject<String>();
  final _unit_id = BehaviorSubject<String>();
  final _manufacturer_id = BehaviorSubject<String>();

  final _product_id = BehaviorSubject<String>();

  final _ProductName = BehaviorSubject<String>();
  final _ProductDescription = BehaviorSubject<String>();
  final _Category = BehaviorSubject<String>();
  final _SubCategory = BehaviorSubject<String>();
  final _UnitList = BehaviorSubject<String>();
  final _Manufacturer = BehaviorSubject<String>();
  final _Manufacturer_Pn = BehaviorSubject<String>();
  final _Gtin = BehaviorSubject<String>();
  final _ListPrice = BehaviorSubject<String>();

  final _previousCategory = BehaviorSubject<String>();
  final _previousSubCategory = BehaviorSubject<String>();
  final _previousUnitList = BehaviorSubject<String>();
  final _previousManufacturer = BehaviorSubject<String>();

  Function(String) get getProductName => _ProductName.sink.add;

  Function(String) get getProductDesc => _ProductDescription.sink.add;

  Function(String) get getCategoryID => _Category.sink.add;

  Function(String) get getSubCategoryID => _SubCategory.sink.add;

  Function(String) get getUnitID => _UnitList.sink.add;

  Function(String) get getManufacturerID => _Manufacturer.sink.add;

  Function(String) get getManufacturerPn => _Manufacturer_Pn.sink.add;

  Function(String) get getGtin => _Gtin.sink.add;

  Function(String) get getListPrice => _ListPrice.sink.add;

  Function(String) get getProductID => _product_id.sink.add;

  Function(String) get getPreviousCategoryID => _previousCategory.sink.add;

  Function(String) get getPreviousSubCategoryID =>
      _previousSubCategory.sink.add;

  Function(String) get getPreviousUnitID => _previousUnitList.sink.add;

  Function(String) get getPreviousManufacturerID =>
      _previousManufacturer.sink.add;

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

  //category_get_sink
  Function(String) get getcategory => _category.sink.add;

  //sub_category_get_sink
  Function(String) get getsub_category => _sub_category.sink.add;

  Function(String) get getcategory_id => _category_id.sink.add;

  //ADD PRODUCT
  Function(String) get getsubcategory_id => _sub_category_id.sink.add;

  Function(String) get getunit_id => _unit_id.sink.add;

  Function(String) get getmanufacturer_id => _manufacturer_id.sink.add;

//getunit_id
  fetchAllUnitData() async {
    List<UnitModel> unitdata = await _repository.getAllUnitData();
    _unitFetcher.sink.add(unitdata);
  }

  fetchAllCatagoryData() async {
    List<CategoryModel> categorydata = await _repository.getAllCatagoryData();
    _catagoryFetcher.sink.add(categorydata);
  }

  fetchAllSubCatagoryData() async {
    List<SubCategoryModel> subcategorydata =
        await _repository.getAllSubCategoryData();
    _subcatagoryFetcher.sink.add(subcategorydata);
  }

  fetchAllMateralPackData() async {
    List<MaterialPackModel> materialpackdata =
        await _repository.getAllMaterialPackData();
    _materialpackFetcher.sink.add(materialpackdata);
  }

  fetchAllManufacData() async {
    List<ManufactureModel> manufacData = await _repository.getAllmanufacData();
    _manufacFetcher.sink.add(manufacData);
  } //TODO::ALL GET LIST

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
    sublist_getsuccess_model success = await _repository.updateManufacturer(_Manufacturer.value,_manufacturer.value);
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

    //TODO:: extra variable lagbe to store which data i will use

    if (cat == null) {

      finalcategoryID = _previousCategory.value;
      print("Previous Cat: " + _previousCategory.value);
      print("CAT OK");
    } else if (cat != null) {
      finalcategoryID = _Category.value;
      print("New Category: " + _Category.value);
    }

    if (manuid == null) {
      finalManufacID = _previousManufacturer.value;
      print("Previous Manu: " + _previousManufacturer.value);
      print("MANU OK");
    } else if (manuid != null) {
      finalManufacID = _Manufacturer.value;
      print("New Manu: " + _Manufacturer.value);
    }

    if (subcat == null) {
      finalSubcategoryID = _previousSubCategory.value;
      print("Previous subcat: " + _previousSubCategory.value);
      print("subcat OK");
    } else if (subcat != null) {
      finalSubcategoryID = _SubCategory.value;
      print("New subcat: " + _SubCategory.value);
    }

    if (unit == null) {
      finalUnitID = _previousUnitList.value;
      print("Previous unit: " + _previousUnitList.value);
      print("unit OK");
    } else if (unit != null) {
      finalUnitID = _UnitList.value;
      print("New unit: " + _UnitList.value);
    }



    print('id: '+_product_id.value+" CatagoryID: "+finalcategoryID+" SubID: "+finalSubcategoryID+" UnitID: "+finalUnitID+" ManuID: "+finalManufacID+
       "Productname: "+_ProductName.value+" Description: "+_ProductDescription.value+" Manu PN: "+_Manufacturer_Pn.value+" Gtin: "+_Gtin.value+" ListPrice "+_ListPrice.value);




    sublist_getsuccess_model success = await _repository.updateProductMasterData(_product_id.value,_ProductName.value,_ProductDescription.value,finalcategoryID,finalSubcategoryID,finalUnitID,finalManufacID,
        _Manufacturer_Pn.value,_Gtin.value,_ListPrice.value);

    _UpdatePropductSuccessFetcher.sink.add(success);
  }

  //UPDATE SUBLIST ALL THING CODE

  void dispose() async {
//    _title.close();
//    _id.drain();
//    _name.drain();
//    _posts.drain();
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

    _Category.value = null;
    _SubCategory.value = null;
    _Manufacturer.value = null;
    _UnitList.value = null;

    _previousCategory.value = null;
    _previousSubCategory.value = null;
    _previousUnitList.value = null;
    _previousManufacturer.value = null;

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
