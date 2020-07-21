import 'dart:async';
import 'dart:convert';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/foundation.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'package:global_configuration/global_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ApiProvider {
  Client client = Client();

  String deviceID,serverIP,serverPort,serverLog;

  final _url = "http://202.164.212.238:8055/api/products/";

  final _createurl = "http://202.164.212.238:8055/api/SublistPost/";

  final _updateurl = "http://202.164.212.238:8055/api/SublistPost/";

  final base_url = "http://202.164.212.238:8055/api/";

  void getinfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String serverip = prefs.getString('_serverip');
    final String serverport = prefs.getString('_serverport');

    this.serverIP = serverip;
    this.serverPort = serverport;
  }

  Future<List<MasterDataModel>> fetchMasterData() async {

    print("fetch from apiprovider");
    final response = await client.get(_url);

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

    final response = await client.get(_url+id);

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
    String url = "http://202.164.212.238:8055/api/Units";
    print("fetch from apiprovider");
    final response = await client.get(url);

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
    String url = "http://202.164.212.238:8055/api/Category";
    print("fetch from apiprovider");
    final response = await client.get(url);

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
    String url = "http://202.164.212.238:8055/api/SubCategory";
    print("fetch from apiprovider");
    final response = await client.get(url);

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
    String url = "http://202.164.212.238:8055/api/Material";
    print("fetch from apiprovider");
    final response = await client.get(url);

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
    String url = "http://202.164.212.238:8055/api/Manufacturer";
    print("fetch from apiprovider");
    final response = await client.get(url);

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
  } //ALL GET


  //TODO:: Create

  Future<sublist_getsuccess_model> createUnit(unit,unitshort) async{

    final response = await client.get(_createurl+"UnitUpdate"+"/"+"0"+"/"+unit+"/"+unitshort );

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

    final response = await client.get(_createurl+"MaterialUpdate"+"/"+"0"+"/"+packagingmaterial );

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

    final response = await client.get(_createurl+"ManufacturerUpdate"+"/"+"0"+"/"+manufacturer );

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

    final response = await client.get(_createurl+"CategoryUpdate"+"/"+"0"+"/"+category );

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

    final response = await client.get(_createurl+"SubCategoryUpdate"+"/"+"0"+"/"+categoryid+"/"+subcategory);

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

    final response = await client.get(base_url+"ProductUpdate"+"/"+"GetMaxid");

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

    final response = await client.get(base_url+"ProductUpdate/SubmitData"+"/"+"0"+"/"+name+"/"+desc+"/"+manufac+"/"+category+"/"+subcat+"/"+unit+"/"+manu_pn+"/"+gtin+"/"+listprice);

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

    final response = await client.get(base_url+"ProductUpdate/SubmitData"+"/"+id+"/"+name+"/"+desc+"/"+manufac+"/"+category+"/"+subcat+"/"+unit+"/"+manu_pn+"/"+gtin+"/"+listprice);

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