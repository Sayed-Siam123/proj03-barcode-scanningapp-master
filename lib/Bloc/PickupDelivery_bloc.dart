import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PickupDelivery_bloc{
  final _repository = Repository();

  final _getProductIDfromScan = BehaviorSubject<String>();

  final _allpickupproductdataFetcher = PublishSubject<List<PickupDeliveryModel>>();

  final _singlepickupdataFetcher = PublishSubject<SinglePickupDataModel>();

  Stream<List<PickupDeliveryModel>> get allPickupProductData1 => _allpickupproductdataFetcher.stream;
  Stream<SinglePickupDataModel> get singlePickupData => _singlepickupdataFetcher.stream;

  Function(String) get getProductIDfromScan => _getProductIDfromScan.sink.add;



  insertPickupProduct(PickupDeliveryModel productinfo) async{
    print("GET: "+ productinfo.delivery_id_.toString());


    await _repository.insertPickupData(productinfo);
//    print("FROM BLOC");

  }

  getAllpickupdatafromDB() async{
    List<PickupDeliveryModel> pickupalldata = await _repository.fetchallpickupData();
    _allpickupproductdataFetcher.sink.add(pickupalldata);
  }

  getSingledata() async{

    print("ID IS :: "+_getProductIDfromScan.value);

    SinglePickupDataModel getSingledata = await _repository.fetchSinglePickupData(_getProductIDfromScan.value);
    _singlepickupdataFetcher.sink.add(getSingledata);

  }

  deletePickupTable() async{
    await _repository.deleteAllPickupProductsTable();
  }


  void dispose() async{

    _getProductIDfromScan.drain();
    _getProductIDfromScan.value = null;

    await _allpickupproductdataFetcher.drain();
    _allpickupproductdataFetcher.close();
    await _singlepickupdataFetcher.drain();
    _singlepickupdataFetcher.close();

  }





}

final pickupdelivery_bloc = PickupDelivery_bloc();