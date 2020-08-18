import 'package:app/Model/DeliveriesListModel.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Resources/Repository.dart';
import 'package:rxdart/rxdart.dart';

class NewDelivery_bloc{
  final _repository = Repository();

  final selectedItembarcode = BehaviorSubject<String>();
  final selectedItemproductname = BehaviorSubject<String>();
  final selectedItemquantity = BehaviorSubject<int>();

  final _productdataFetcher = PublishSubject<List<NewDeliveryModel>>();

  final _allproductdataFetcher = PublishSubject<List<NewDeliveryModel>>();

  final _alldeliverydataFetcher = PublishSubject<List<DeliveriesListModel>>();


  Stream<List<NewDeliveryModel>> get allProductData => _productdataFetcher.stream;

  Stream<List<NewDeliveryModel>> get allProductData1 => _allproductdataFetcher.stream;

  Stream<List<DeliveriesListModel>> get allDelivereiesData => _alldeliverydataFetcher.stream;


  Function(String) get getselecteditemBarcode => selectedItembarcode.sink.add;
  Function(String) get getselecteditemProductName => selectedItemproductname.sink.add;
  Function(int) get getselecteditemQuantity => selectedItemquantity.sink.add;


  insertProduct(NewDeliveryModel productinfo) async{
    //print("GET: "+ selectedItembarcode.value.toString() + "   " + selectedItemproductname.value.toString()+ "   " + selectedItemquantity.value.toString());


    print("Product barcode in bloc: "+ productinfo.barcode.toString());

    await _repository.insertTodo(productinfo);
    print("FROM BLOC");

  }

  getProduct() async {
    List<NewDeliveryModel> productdata = await _repository.fetchProductData();
    _productdataFetcher.sink.add(productdata);
  }

  getallProduct() async {
    List<NewDeliveryModel> productdata = await _repository.fetchAllProductData();
    _allproductdataFetcher.sink.add(productdata);
  }

  updateProduct(NewDeliveryModel product) async {
    await _repository.updateProduct(product);
    getProduct();
  }

  deleteProductById(int id) async {
    _repository.deleteProductById(id);
    getProduct();
  }

  deleteTable() async{
    await _repository.deleteAllProductsTable();
  }

  getAllDeliveryList() async{
    List<DeliveriesListModel> delivereisdata = await _repository.fetchDelivereisData();
    _alldeliverydataFetcher.sink.add(delivereisdata);
  }

  createDeliverypost(String data) async{
    print(data);
    await _repository.createDeliverypost(data);
    deleteTable();
  }



  void dispose() async{

    selectedItembarcode.drain();
    selectedItembarcode.value = null;
    selectedItemproductname.drain();
    selectedItemproductname.value = null;
    selectedItemquantity.drain();
    selectedItemquantity.value = null;

    await _productdataFetcher.drain();
    _productdataFetcher.close();

    await _allproductdataFetcher.drain();
    _allproductdataFetcher.close();

    await _alldeliverydataFetcher.drain();
    _alldeliverydataFetcher.close();

  }


}



final ndelivery_bloc = NewDelivery_bloc();