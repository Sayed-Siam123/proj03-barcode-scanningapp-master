import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';


class MasterData_Bloc{
  final _repository = Repository();
  // ignore: close_sinks
  final _masterdataFetcher = PublishSubject<List<MasterDataModel>>();
  final _singlemasterdatafetcher = PublishSubject<List<SingleMasterDataModel>>();


  final _MaxIdFetcher = PublishSubject<sublist_getsuccess_model>();


  final _id = BehaviorSubject<String>();


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


  Stream<List<MasterDataModel>> get allMasterData => _masterdataFetcher.stream;
  Stream<List<SingleMasterDataModel>> get singleMasterData => _singlemasterdatafetcher.stream;






  Stream<sublist_getsuccess_model> get MaxIDData => _MaxIdFetcher.stream;



  fetchAllMasterData() async {

       List<MasterDataModel> masterdata = await _repository.fetchAllMasterData();
       _masterdataFetcher.sink.add(masterdata);

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