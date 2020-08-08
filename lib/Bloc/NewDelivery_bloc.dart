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


  Stream<List<NewDeliveryModel>> get allProductData => _productdataFetcher.stream;

  Stream<List<NewDeliveryModel>> get allProductData1 => _allproductdataFetcher.stream;

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

  }


}



final ndelivery_bloc = NewDelivery_bloc();