import 'package:app/Model/DeliveriesListModel.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class PickupDelivery_bloc {
  final _repository = Repository();


  final _allpickupdataFetcher = PublishSubject<List<PickupListModel>>();

  Stream<List<PickupListModel>> get allPickupData => _allpickupdataFetcher.stream;

  getAllPickupList() async{
    List<PickupListModel> pickupdata = await _repository.fetchPickupData();
    _allpickupdataFetcher.sink.add(pickupdata);
  }


  void dispose() async{

    await _allpickupdataFetcher.drain();
    _allpickupdataFetcher.close();

  }

}

final pdelivery_bloc = PickupDelivery_bloc();