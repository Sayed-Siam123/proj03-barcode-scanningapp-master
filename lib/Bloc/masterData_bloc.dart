import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Model/unit_model.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';


class MasterData_Bloc{
  final _repository = Repository();
  MasterDataModel master;
  MasterDataModelV2 master2;

  bool status = false;
  // ignore: close_sinks
  final _masterdataFetcher = PublishSubject<List<MasterDataModel>>();
  final _masterdataFetcherV2 = PublishSubject<List<MasterDataModelV2>>();

  final _singlemasterdatafetcher = PublishSubject<List<SingleMasterDataModel>>();
  final _singlemasterdatafetcherV2 = PublishSubject<List<SingleMasterDataModelV2>>();


  final _MaxIdFetcher = PublishSubject<sublist_getsuccess_model>();


  final _id = BehaviorSubject<String>();
  final _productname = BehaviorSubject<String>();


  final _ProductName = BehaviorSubject<String>();
  final _ProductDescription = BehaviorSubject<String>();
  final _Category = BehaviorSubject<String>();
  final _SubCategory = BehaviorSubject<String>();
  final _Unit = BehaviorSubject<String>();
  final _Manufacturer = BehaviorSubject<String>();
  final _Manufacturer_Pn = BehaviorSubject<String>();
  final _Gtin = BehaviorSubject<String>();
  final _ListPrice = BehaviorSubject<String>();


  Function(String) get getProductName => _ProductName.sink.add;
  Function(String) get getProductDesc => _ProductDescription.sink.add;
  Function(String) get getCategory => _Category.sink.add;
  Function(String) get getSubCategory => _SubCategory.sink.add;
  Function(String) get getUnit => _Unit.sink.add;
  Function(String) get getManufacturer => _Manufacturer.sink.add;
  Function(String) get getManufacturerPn => _Manufacturer_Pn.sink.add;
  Function(String) get getGtin => _Gtin.sink.add;
  Function(String) get getListPrice => _ListPrice.sink.add;





  Function(String) get getId => _id.sink.add;
  Function(String) get get_product_name => _productname.sink.add;


  Stream<List<MasterDataModel>> get allMasterData => _masterdataFetcher.stream;
  Stream<List<MasterDataModelV2>> get allMasterDataV2 => _masterdataFetcherV2.stream;

  Stream<List<SingleMasterDataModel>> get singleMasterData => _singlemasterdatafetcher.stream;
  Stream<List<SingleMasterDataModelV2>> get singleMasterDatav2 => _singlemasterdatafetcherV2.stream;






  Stream<sublist_getsuccess_model> get MaxIDData => _MaxIdFetcher.stream;


  fetchAllMasterdatafromDB() async{
    List<MasterDataModel> masterdatadb = await _repository.getAllMAsterProduct();
    _masterdataFetcher.sink.add(masterdatadb);
  }

  fetchAllMasterdatafromDBV2() async{
    print("OK");
    List<MasterDataModelV2> masterdatadbv2 = await _repository.getAllMasterProductV2();
    _masterdataFetcherV2.sink.add(masterdatadbv2);
  }



  fetchAllMasterData() async {

       List<MasterDataModel> masterdataapi = await _repository.fetchAllMasterData(); //from api check
       List<MasterDataModel> masterdatadb = await _repository.getAllMAsterProduct(); //from db check


       if(masterdatadb.isEmpty){

         for(int i = 0; i<masterdataapi.length;i++){
           print ("Length:: "+masterdatadb.length.toString());
           insertProduct(masterdataapi[i]);

         }
       }

       else{
         print ("Length:: "+masterdatadb.length.toString());
       }

       //eikhan theke db te porbe

  }


  getsinglemasterdata() async{
    print("ID NUMBER IS :: "+_id.value);
    List<SingleMasterDataModel> singlemasterdata = await _repository.getsinglemasterdata(_id.value);
    _singlemasterdatafetcher.sink.add(singlemasterdata);
  }//GET_BY API CALL

  getsinglemasterdatafromDB() async{
    print("ID NUMBER IS :: "+_id.value);
    List<SingleMasterDataModel> singlemasterdata = await _repository.getsinglemasterdatafromDB(_id.value);
    print(singlemasterdata[0].productName.toString());
    _singlemasterdatafetcher.sink.add(singlemasterdata);
  } //FETCH FROM DB

  getsinglemasterdatafromDBV2() async{
    print("ID NUMBER IS :: "+_id.value);
    List<SingleMasterDataModelV2> singlemasterdata = await _repository.getsinglemasterdatafromDBV2(_id.value);
    print(singlemasterdata[0].productDescription.toString());
    _singlemasterdatafetcherV2.sink.add(singlemasterdata);
  } //FETCH FROM DB



  fetchMaxIDData() async {

    sublist_getsuccess_model MaxIDdata = await _repository.getMaxIDData();
    _MaxIdFetcher.sink.add(MaxIDdata);

  }


  insertProduct(MasterDataModel productinfo) async{
    //print("GET: "+ selectedItembarcode.value.toString() + "   " + selectedItemproductname.value.toString()+ "   " + selectedItemquantity.value.toString());



    master = MasterDataModel(id: productinfo.id.toString(),
    productName: productinfo.productName.toString(),manufacturerName: productinfo.manufacturerName.toString(),categoryName: productinfo.categoryName.toString(),
    productDescription: productinfo.productDescription.toString(),subCategoryName: productinfo.subCategoryName.toString(),packagingUnit: productinfo.packagingUnit.toString(),
    gtin: productinfo.gtin.toString(),productPicture: productinfo.productPicture.toString(),listPrice: productinfo.listPrice.toString(),
    productWeight: productinfo.productWeight.toString(),referenceNo: productinfo.referenceNo.toString(),updateFlag: productinfo.updateFlag==null ? "false" : productinfo.updateFlag.toString(),
    categoryNameId: productinfo.categoryNameId.toString(),isOrderableViaApp: productinfo.isOrderableViaApp.toString(),isTransferToApp: productinfo.isTransferToApp.toString(),
    manufacturerId: productinfo.manufacturerId.toString(),
    manufacturerPN: productinfo.manufacturerPN == null?"111":productinfo.manufacturerPN.toString(),
    productHeight: productinfo.productHeight.toString(),productLength: productinfo.productLength.toString(),productWidth: productinfo.productWidth.toString(),
      subCategoryNameId: productinfo.subCategoryNameId.toString(),unitId: productinfo.unitId.toString(),unitName:productinfo.unitName.toString(),
    newFlag: productinfo.newFlag==null ? "false" : productinfo.newFlag.toString(),);

    print("Product barcode in bloc: "+ master.id.toString());

    await _repository.insertMasterdata(master);

    print("FROM BLOC");

  }

  insertProductV2(MasterDataModelV2 productinfo) async{
    //print("GET: "+ selectedItembarcode.value.toString() + "   " + selectedItemproductname.value.toString()+ "   " + selectedItemquantity.value.toString());

    master2 = MasterDataModelV2(id: productinfo.id.toString(),
      productDescription: productinfo.productDescription.toString(),gtin: productinfo.gtin.toString(),productPicture: productinfo.productPicture.toString(),listPrice: productinfo.listPrice.toString(),
      updateFlag: productinfo.updateFlag==null ? "false" : productinfo.updateFlag.toString(), newFlag: productinfo.newFlag==null ? "false" : productinfo.newFlag.toString(),
      code_digits: productinfo.code_digits.toString(),code_type: productinfo.code_type.toString());

    print("Product barcode in bloc: "+ master2.id.toString());

    await _repository.insertMasterdataV2(master2);

    print("FROM BLOC");

  }

  syncAddDatatoAPI() async{
    List<MasterDataModel> newmasterdata = await _repository.getAllMAsterNewProduct();
    List<CategoryModel> catdata = await _repository.getAllCategoryNewProduct();
    List<SubCategoryModel> subcatdata = await _repository.getAllSubCategoryNewProduct();
    List<UnitModel> unitdata = await _repository.getAllUnitNewProduct();
    List<MaterialPackModel> packmatdata = await _repository.getAllPackMatNewProduct();
    List<ManufactureModel> manufacdata = await _repository.getAllManufacNewProduct();


    //MASTER ADD
    if(newmasterdata.length ==0){
      print("master Kicchu nai");
    }

    else if(newmasterdata.length !=0) {

      for(int i = 0;i<newmasterdata.length;i++){
        print("new master data");
        print(newmasterdata[i].productName.toString());
        await _repository.createProductMasterData(newmasterdata[i].productName.toString(), newmasterdata[i].productDescription.toString(), newmasterdata[i].categoryNameId.toString(), newmasterdata[i].subCategoryNameId.toString(), newmasterdata[i].unitId.toString(), newmasterdata[i].manufacturerId.toString(), newmasterdata[i].manufacturerPN.toString(), newmasterdata[i].gtin.toString(), newmasterdata[i].listPrice.toString());
      }
      await _repository.deleteAllMasterdataTable();
      fetchAllMasterData();
    }

    //CAT ADD
    if(catdata.length ==0){
      print("cat Kicchu nai");
    }

    else if(catdata.length !=0) {

      for(int i = 0;i<catdata.length;i++){
        print(catdata[i].categoryName.toString());
        await _repository.createCategory(catdata[i].categoryName.toString());

      }

      await _repository.deleteAllCategoryTable();
      sublist_bloc.fetchAllCatagoryData();

    }

    //SUB CAT ADD
    if(subcatdata.length ==0){
      print("subcat Kicchu nai");
    }

    else if(subcatdata.length !=0) {

      for(int i = 0;i<subcatdata.length;i++){
        print(subcatdata[i].categoryId.toString());
        await _repository.createSubCategory(subcatdata[i].categoryId.toString(), subcatdata[i].subCategoryName.toString());
      }

      await _repository.deleteAllSubCategoryTable();
      sublist_bloc.fetchAllSubCatagoryData();
    }


    //UNIT ADD
    if(unitdata.length ==0){
      print("unit Kicchu nai");
    }

    else if(unitdata.length !=0) {

      for(int i = 0;i<unitdata.length;i++){
        print(unitdata[i].unitName.toString());
        await _repository.createUnit(unitdata[i].unitName.toString(),unitdata[i].unitShort.toString());
      }

      await _repository.deleteAllUnitTable();
      sublist_bloc.fetchAllUnitData();

    }

    // PACK MAT ADD
    if(packmatdata.length ==0){
      print("packmat Kicchu nai");
    }

    else if(packmatdata.length !=0) {

      for(int i = 0;i<packmatdata.length;i++){
        print(packmatdata[i].materialName.toString());
        await _repository.createPackagingMaterial(packmatdata[i].materialName.toString());
      }

      await _repository.deleteAllPackMatTable();
      sublist_bloc.fetchAllMateralPackData();

    }

    //MANUFAC ADD
    if(manufacdata.length ==0){
      print("packmat Kicchu nai");
    }

    else if(manufacdata.length !=0) {

      for(int i = 0;i<manufacdata.length;i++){
        print(manufacdata[i].manufacturerName.toString());
        await _repository.createManufacturer(manufacdata[i].manufacturerName.toString());
      }

      await _repository.deleteAllManufacTable();
      sublist_bloc.fetchAllManufacData();

    }

  }

  syncUpdateDatatoAPI() async{
    List<MasterDataModel> updatemasterdata = await _repository.getAllMAsterUpdateProduct();
    List<CategoryModel> updatecatdata = await _repository.getAllCategoryUpdateProduct();
    List<SubCategoryModel> updatesubcatdata = await _repository.getAllSubCategoryUpdateProduct();
    List<UnitModel> updateunitdata = await _repository.getAllUnitUpdateProduct();
    List<MaterialPackModel> updatepackmatdata = await _repository.getAllPackMatUpdateProduct();
    List<ManufactureModel> updatemanufacdata = await _repository.getAllManufacUpdateProduct();


    //MASTER ADD
    if(updatemasterdata.length ==0){
      print("master Kicchu nai");
    }

    else if(updatemasterdata.length !=0) {

      for(int i = 0;i<updatemasterdata.length;i++){
        print("new master data");
        print(updatemasterdata[i].productName.toString());
        await _repository.updateProductMasterData(updatemasterdata[i].id.toString(),updatemasterdata[i].productName.toString()
            , updatemasterdata[i].productDescription.toString(), updatemasterdata[i].categoryNameId.toString()
            , updatemasterdata[i].subCategoryNameId.toString(), updatemasterdata[i].unitId.toString()
            , updatemasterdata[i].manufacturerId.toString(), updatemasterdata[i].manufacturerPN.toString()
            , updatemasterdata[i].gtin.toString(), updatemasterdata[i].listPrice.toString());
      }
      await _repository.deleteAllMasterdataTable();
      fetchAllMasterData();
    }

    //CAT ADD
    if(updatecatdata.length ==0){
      print("cat Kicchu nai");
    }

    else if(updatecatdata.length !=0) {

      for(int i = 0;i<updatecatdata.length;i++){
        print(updatecatdata[i].categoryName.toString());
        await _repository.updateCatAPI(updatecatdata[i].id.toString(),updatecatdata[i].categoryName.toString());

      }

      await _repository.deleteAllCategoryTable();
      sublist_bloc.fetchAllCatagoryData();

    }

    //SUB CAT ADD
    if(updatesubcatdata.length ==0){
      print("subcat Kicchu nai");
    }

    else if(updatesubcatdata.length !=0) {

      for(int i = 0;i<updatesubcatdata.length;i++){
        print(updatesubcatdata[i].categoryId.toString());
        await _repository.updateSubCatAPI(updatesubcatdata[i].id.toString(),updatesubcatdata[i].categoryId.toString(), updatesubcatdata[i].subCategoryName.toString());
      }

      //await _repository.deleteAllSubCategoryTable();
      //sublist_bloc.fetchAllSubCatagoryData();
    }


    //UNIT ADD
    if(updateunitdata.length ==0){
      print("unit Kicchu nai");
    }

    else if(updateunitdata.length !=0) {

      for(int i = 0;i<updateunitdata.length;i++){
        print(updateunitdata[i].unitName.toString());
        await _repository.updateUnitAPI(updateunitdata[i].id.toString(),updateunitdata[i].unitName.toString(),updateunitdata[i].unitShort.toString());
      }

      await _repository.deleteAllUnitTable();
      sublist_bloc.fetchAllUnitData();

    }

    // PACK MAT ADD
    if(updatepackmatdata.length ==0){
      print("packmat Kicchu nai");
    }

    else if(updatepackmatdata.length !=0) {

      for(int i = 0;i<updatepackmatdata.length;i++){
        print(updatepackmatdata[i].materialName.toString());
        await _repository.updatePackMatAPI(updatepackmatdata[i].id.toString(),updatepackmatdata[i].materialName.toString());
      }

      await _repository.deleteAllPackMatTable();
      sublist_bloc.fetchAllMateralPackData();

    }

    //MANUFAC ADD
    if(updatemanufacdata.length ==0){
      print("manufac Kicchu nai");
    }

    else if(updatemanufacdata.length !=0) {

      for(int i = 0;i<updatemanufacdata.length;i++){
        print(updatemanufacdata[i].manufacturerName.toString());
        await _repository.updateManufacturerAPI(updatemanufacdata[i].id.toString(),updatemanufacdata[i].manufacturerName.toString());
      }

      await _repository.deleteAllManufacTable();
      sublist_bloc.fetchAllManufacData();

    }



  }




  void dispose() async{
//    _title.close();
     _id.drain();
//    _name.drain();
//    _posts.drain();
    //_id.close();


    _ProductName.drain();
    _ProductDescription.drain();
    _Category.drain();
    _SubCategory.drain();
    _Unit.drain();
    _Manufacturer.drain();
    _Manufacturer_Pn.drain();
    _Gtin.drain();
    _ListPrice.drain();
    _productname.drain();


    await _masterdataFetcher.drain();
    _masterdataFetcher.close();

    await _masterdataFetcherV2.drain();
    _masterdataFetcherV2.close();


    await _singlemasterdatafetcher.drain();
    _singlemasterdatafetcher.close();

    await _MaxIdFetcher.drain();
    _MaxIdFetcher.close();

    await _singlemasterdatafetcherV2.drain();
    _singlemasterdatafetcherV2.close();



//    await _postDatafetcher.drain();
//    _postDatafetcher.close();
  }

}

final masterdata_bloc = MasterData_Bloc();