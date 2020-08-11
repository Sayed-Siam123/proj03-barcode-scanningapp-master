import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PickupDelivery_bloc{
  final _repository = Repository();

  final _allpickupproductdataFetcher = PublishSubject<List<PickupDeliveryModel>>();

  Stream<List<PickupDeliveryModel>> get allPickupProductData1 => _allpickupproductdataFetcher.stream;

  insertPickupProduct(PickupDeliveryModel productinfo) async{
    //print("GET: "+ selectedItembarcode.value.toString() + "   " + selectedItemproductname.value.toString()+ "   " + selectedItemquantity.value.toString());


    print("Product store in bloc: "+ productinfo.store_.toString());

//    await _repository.insertTodo(productinfo);
//    print("FROM BLOC");

  }

}

final pickupdelivery_bloc = PickupDelivery_bloc();