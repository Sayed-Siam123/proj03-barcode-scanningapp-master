import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';


class MasterData_Bloc{
  final _repository = Repository();
  MasterDataModel master;
  bool status = false;
  // ignore: close_sinks
  final _masterdataFetcher = PublishSubject<List<MasterDataModel>>();
  final _singlemasterdatafetcher = PublishSubject<List<SingleMasterDataModel>>();


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
  Stream<List<SingleMasterDataModel>> get singleMasterData => _singlemasterdatafetcher.stream;






  Stream<sublist_getsuccess_model> get MaxIDData => _MaxIdFetcher.stream;


  fetchAllMasterdatafromDB() async{
    List<MasterDataModel> masterdatadb = await _repository.getAllMAsterProduct();
    _masterdataFetcher.sink.add(masterdatadb);
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
  } //GET_BY




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
    productWeight: productinfo.productWeight.toString(),referenceNo: productinfo.referenceNo.toString(),updateFlag: "false",
    categoryNameId: productinfo.categoryNameId.toString(),isOrderableViaApp: productinfo.isOrderableViaApp.toString(),isTransferToApp: productinfo.isTransferToApp.toString(),
    manufacturerId: productinfo.manufacturerId.toString(),
    manufacturerPN: productinfo.manufacturerPN == null?"111":productinfo.manufacturerPN.toString(),
    productHeight: productinfo.productHeight.toString(),productLength: productinfo.productLength.toString(),productWidth: productinfo.productWidth.toString(),
      subCategoryNameId: productinfo.subCategoryNameId.toString(),unitId: productinfo.unitId.toString(),unitName:productinfo.unitName.toString());

    print("Product barcode in bloc: "+ master.id.toString());

    await _repository.insertMasterdata(master);

    print("FROM BLOC");

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
    await _singlemasterdatafetcher.drain();
    _singlemasterdatafetcher.close();

    await _MaxIdFetcher.drain();
    _MaxIdFetcher.close();



//    await _postDatafetcher.drain();
//    _postDatafetcher.close();
  }

}

final masterdata_bloc = MasterData_Bloc();