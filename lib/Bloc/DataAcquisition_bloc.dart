import 'package:app/Model/DataAcquisition_model.dart';
import 'package:app/resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class DataAcquisitionBloc{

  final _repository = Repository();

  final _alldataacquisitionFetcher = PublishSubject<List<DataAcquisition_model>>();
  final _singledataacquisitionFetcher = PublishSubject<List<DataAcquisition_model>>();

  Stream<List<DataAcquisition_model>> get alldataacquisition => _alldataacquisitionFetcher.stream;
  Stream<List<DataAcquisition_model>> get singledataacquisition => _singledataacquisitionFetcher.stream;






  InsertDataAcquisitionData(DataAcquisition_model data) async{

    await _repository.insertDataAcquisitiondata(data);

  }

  fetchAllDataAcquisition() async{
    List<DataAcquisition_model> masterdatadbv2 = await _repository.getAllDataAcqui();
    _alldataacquisitionFetcher.sink.add(masterdatadbv2);
  }

  fetchSingleDataAcquisition() async{
    List<DataAcquisition_model> masterdatadbv2 = await _repository.getSingleDataAcquisition();
    _singledataacquisitionFetcher.sink.add(masterdatadbv2);
  }

  deleteLastDataAcqui(int id) async{
    await _repository.deleteLastDataAcqui(id);
  }

  deleteFullDataAcquiTable() async{
    await _repository.deleteAllDataAcqui();
  }


  void dispose() async{
    await _alldataacquisitionFetcher.drain();
    _alldataacquisitionFetcher.close();

    await _singledataacquisitionFetcher.drain();
    _singledataacquisitionFetcher.close();
  }

}

final data_acquisition_bloc = DataAcquisitionBloc();