import 'dart:async';
import 'dart:convert';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/DeliveriesListModel.dart';
import 'package:app/Model/GetDeliveryResponse_Model.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/UserLogin_Success_Model.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/foundation.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SharedPrefer.dart';



class ApiProvider {
  Client client = Client();

  SessionManager prefs =  SessionManager();

  String deviceID=""
  ,serverIP=""
  ,serverPort=""
  ,serverLog="";


  String initial= "http://";

  final _url = "https://json-server-restapi.herokuapp.com/";

  final _createurl = "http://202.164.212.238:8055/api/SublistPost/";

  final _updateurl = "http://202.164.212.238:8055/api/SublistPost/";

  final _base_url = "http://202.164.212.238:8055/api/";

  void getIP() async {

    Future<String> serverip = prefs.getData("_serverip");
    serverip.then((data) {

      print('serverip pabo');
      print("serverip " + data.toString());
      this.serverIP = data.toString();

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    },onError: (e) {
      print(e);
    });

  }

  void getPort() async {

    Future<String> serverport = prefs.getData("_serverport");
    serverport.then((data) {

      print("serverport " + data.toString());
      this.serverPort = data.toString();


    },onError: (e) {
      print(e);
    });


  }

  Future<List<MasterDataModel>> fetchMasterData() async {


    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));
    //1sec delay

    //then it will get data
    print("fetch from apiprovider");
    final response = await client.get(initial+serverIP+":"+serverPort+"/api/products/");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((masterdata) => new MasterDataModel.fromJson(masterdata)).toList();

//      if (values.length > 0) {
//        for (int i = 0; i < values.length; i++) {
//          if (values[i] != null) {
//            Map<String, dynamic> map = values[i];
//            _postList.add(Posts.fromJson(map));
//            debugPrint('Id-------${map['id']}');
//          }
//        }
//      }
//      return _postList;
    }

    //print(values.toString());


    else {
      throw Exception('Failed to load jobs from API');
    }
  }


  Future<List<SingleMasterDataModel>> fetchsinglemasterdata(id) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/products/"+id);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = json.decode(response.body);


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      //return SingleMasterDataModel.fromJson(json.decode(response.body));
      return jsonResponse.map((masterdata) => new SingleMasterDataModel.fromJson(masterdata)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<UnitModel>> getUnitData() async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));


    print("fetch from apiprovider");
    final response = await client.get(initial+serverIP+":"+serverPort+"/api/Units");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((masterdata) => new UnitModel.fromJson(masterdata)).toList();

//      if (values.length > 0) {
//        for (int i = 0; i < values.length; i++) {
//          if (values[i] != null) {
//            Map<String, dynamic> map = values[i];
//            _postList.add(Posts.fromJson(map));
//            debugPrint('Id-------${map['id']}');
//          }
//        }
//      }
//      return _postList;
    }

    //print(values.toString());


    else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<CategoryModel>> getCatagoryData() async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));


    print("fetch from apiprovider");
    final response = await client.get(initial+serverIP+":"+serverPort+"/api/Category");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((masterdata) => new CategoryModel.fromJson(masterdata)).toList();

//      if (values.length > 0) {
//        for (int i = 0; i < values.length; i++) {
//          if (values[i] != null) {
//            Map<String, dynamic> map = values[i];
//            _postList.add(Posts.fromJson(map));
//            debugPrint('Id-------${map['id']}');
//          }
//        }
//      }
//      return _postList;
    }

    //print(values.toString());


    else {
      throw Exception('Failed to load jobs from API');
    }
  }


  Future<List<SubCategoryModel>> getSubCategoryData() async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));


    print("fetch from apiprovider");
    final response = await client.get(initial+serverIP+":"+serverPort+"/api/SubCategory");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((masterdata) => new SubCategoryModel.fromJson(masterdata)).toList();

//      if (values.length > 0) {
//        for (int i = 0; i < values.length; i++) {
//          if (values[i] != null) {
//            Map<String, dynamic> map = values[i];
//            _postList.add(Posts.fromJson(map));
//            debugPrint('Id-------${map['id']}');
//          }
//        }
//      }
//      return _postList;
    }

    //print(values.toString());


    else {
      throw Exception('Failed to load jobs from API');
    }
  }


  Future<List<MaterialPackModel>> getMaterialPackData() async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));


    print("fetch from apiprovider");
    final response = await client.get(initial+serverIP+":"+serverPort+"/api/Material");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((masterdata) => new MaterialPackModel.fromJson(masterdata)).toList();

//      if (values.length > 0) {
//        for (int i = 0; i < values.length; i++) {
//          if (values[i] != null) {
//            Map<String, dynamic> map = values[i];
//            _postList.add(Posts.fromJson(map));
//            debugPrint('Id-------${map['id']}');
//          }
//        }
//      }
//      return _postList;
    }

    //print(values.toString());


    else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<ManufactureModel>> getmanufacData() async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));


    print("fetch from apiprovider");
    final response = await client.get(initial+serverIP+":"+serverPort+"/api/Manufacturer");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Manufac Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((masterdata) => new ManufactureModel.fromJson(masterdata)).toList();  //TODO::MOdel chnage kore manufac model use kora lagbe

//      if (values.length > 0) {
//        for (int i = 0; i < values.length; i++) {
//          if (values[i] != null) {
//            Map<String, dynamic> map = values[i];
//            _postList.add(Posts.fromJson(map));
//            debugPrint('Id-------${map['id']}');
//          }
//        }
//      }
//      return _postList;
    }

    //print(values.toString());


    else {
      throw Exception('Failed to load jobs from API');
    }
  }//ALL GET


  //UserLogin START



  Future<UserLogin_Success_Model> userLogin(email,password) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    print(email+"   "+password);

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/Users/"+email+"/"+password);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From User Class:: "+json.decode(response.body).toString());
      return UserLogin_Success_Model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

















  //UserLogin END



  //TODO:: Create

  Future<sublist_getsuccess_model> createUnit(unit,unitshort) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/SublistPost/"+"UnitUpdate"+"/"+"0"+"/"+unit+"/"+unitshort );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<sublist_getsuccess_model> createPackagingMaterial(packagingmaterial) async{


    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/SublistPost/"+"MaterialUpdate"+"/"+"0"+"/"+packagingmaterial );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<sublist_getsuccess_model> createManufacturer(manufacturer) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/SublistPost/"+"ManufacturerUpdate"+"/"+"0"+"/"+manufacturer);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<sublist_getsuccess_model> updateManufacturer(id,manufacturer) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/SublistPost/"+"ManufacturerUpdate"+"/"+id+"/"+manufacturer);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<sublist_getsuccess_model> createCategory(category) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/SublistPost/"+"CategoryUpdate"+"/"+"0"+"/"+category );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<sublist_getsuccess_model> createSubCategory(categoryid,subcategory) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/SublistPost/"+"SubCategoryUpdate"+"/"+"0"+"/"+categoryid+"/"+subcategory);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<sublist_getsuccess_model> getMaxIDData() async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/"+"ProductUpdate"+"/"+"GetMaxid");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<sublist_getsuccess_model> createProductMasterData(name, desc, category, subcat, unit, manufac, manu_pn, gtin, listprice) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/"+"ProductUpdate/SubmitData"+"/"+"0"+"/"+name+"/"+desc+"/"+manufac+"/"+category+"/"+subcat+"/"+unit+"/"+manu_pn+"/"+gtin+"/"+listprice);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<sublist_getsuccess_model> updateProductMasterData(id,name, desc, category, subcat, unit, manufac, manu_pn, gtin, listprice) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/"+"ProductUpdate/SubmitData"+"/"+id+"/"+name+"/"+desc+"/"+manufac+"/"+category+"/"+subcat+"/"+unit+"/"+manu_pn+"/"+gtin+"/"+listprice);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return sublist_getsuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  void putShared(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  Future getShared(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String val = prefs.getString(key);
    return val;
  }

  Future<List<DeliveriesListModel>> fetchDelivereisData() async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    print("fetch from apiprovider");
    final response = await client.get(initial+serverIP+":"+serverPort+"/api/delivery/");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((delivereiesListdata) => new DeliveriesListModel.fromJson(delivereiesListdata)).toList();
  }

    else {
      throw Exception('Failed to load jobs from API');
    }


  }

  Future<List<PickupListModel>> fetchPickupData() async{
    print("fetch from apiprovider");
    final response = await client.get(_url+"pickuplist/");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      //List<dynamic> values = new List<dynamic>();

      //values = json.decode(response.body);

      debugPrint("From Get Class:: "+jsonResponse.toString());
      return jsonResponse.map((pickupListdata) => new PickupListModel.fromJson(pickupListdata)).toList();
    }

    else {
      throw Exception('Failed to load jobs from API');
    }


  }

  Future<getdeliverysuccess_model> createDeliverypost(String data) async{
    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/CreateDelivery/SubmitData/"+data );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      debugPrint("From create:: "+json.decode(response.body).toString());
      return getdeliverysuccess_model.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<SinglePickupDataModel> fetchsinglePickupdata(deliveryID) async{

    getIP();
    getPort();
    await new Future.delayed(const Duration(milliseconds: 1000));

    final response = await client.get(initial+serverIP+":"+serverPort+"/api/CreateDelivery/GetPickupData/"+deliveryID);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
      return SinglePickupDataModel.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

}

  //print(GlobalConfiguration().getString("key1"));
//  Future login(email,password) async{
//
//
//    final response = await client.get("http://202.164.212.238:8055/api/Users/"+email+"/"+password);
//
//
//    if (response.statusCode == 200) {
//      // If the server did return a 200 OK response,
//      // then parse the JSON.
//
//
//      debugPrint("From singleGet Class:: "+json.decode(response.body).toString());
//      //return SinglePostModel.fromJson(json.decode(response.body));
//    } else {
//      // If the server did not return a 200 OK response,
//      // then throw an exception.
//      throw Exception('Failed to load album');
//    }
//
//  }