import 'dart:convert';

import 'package:app/Bloc/NewDelivery_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/Resources/database_helper.dart';
import 'package:app/UI/Deliveries.dart';
import 'package:app/UI/SystemSettings.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' show Client;

import 'DeliveryProductList.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class NewDeliveryPage extends StatefulWidget {
  @override
  _NewDeliveryPageState createState() => _NewDeliveryPageState();
}

class _NewDeliveryPageState extends State<NewDeliveryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  ScanResult barcode2;
  var qrText = "";
  var controller;
  bool qr_request = false;

  String cameraStatus;
  String _cameraKey = "_camera";
  SessionManager prefs =  SessionManager();

  String deviceID=""
  ,serverIP=""
  ,serverPort=""
  ,serverLog="";


  String initial= "http://";



  TextEditingController _searchQueryController = new TextEditingController();

  List<String> product_names = <String>[];

  List<String> barcode = <String>[];

  List<NewDeliveryModel> products = [];

  List<String> result1 = [];
  List<String> result2 = [];

  DatabaseHelper helper = DatabaseHelper();

  NewDeliveryModel newdelivery;
  NewDeliveryModel product;


  List<MasterDataModel> _newData = [];
  List<MasterDataModel> _fetcheddata = [];

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<NewDeliveryModel> deliveryList;
  int count = 0;

  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  //Toaster toast;

  final _resetKey1 = GlobalKey<FormState>();
  final _resetKey2 = GlobalKey<FormState>();
  bool _resetValidate1 = false;
  bool _resetValidate2 = false;

  bool _validate1;
  bool _validate2;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";

  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  Client client = Client();

  void getCamera() async {
    Future<bool> serverip = prefs.getBoolData(_cameraKey);
    serverip.then((data) async {

      print("camera status " + data.toString());

      setState(() {
        cameraStatus = data.toString();
      });
      print(cameraStatus.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    product_names.clear();
//    barcode.clear();
//    products.clear();
//
//
//    updateListView();

    getIP();
    getPort();
    getCamera();
    ndelivery_bloc.getProduct();
    //ndelivery_bloc.deleteTable();
    masterdata_bloc.fetchAllMasterdatafromDB();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    masterdata_bloc.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DeliveriesPage()));
            ndelivery_bloc.deleteTable();
          },
        ),
        title: Text(
          translate('new_delivery').toString(),
          style: GoogleFonts.exo2(
            textStyle: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Image.asset(
            'assets/images/shopping_complete.png',
            color: Colors.white,
            fit: BoxFit.fill,
          ),
          onPressed: () {
            if (product == null) {
              print("akjsaks");
              print(_scaffoldKey.toString());
//              _scaffoldKey.currentState.showSnackBar(
//                  SnackBar(
//                    content: Text('Assign a GlobalKey to the Scaffold'),
//                    duration: Duration(seconds: 3),
//                  ));
            }
            else {
              _showNoteDialog(context);
            }
          },
        ),
        backgroundColor: Colors.green,
      ),
      body: Builder(
        builder: (context) {
          return Container(
            color: Theme
                .of(context)
                .backgroundColor,
            child: Column(
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(
                        translate('new_delivery_desc').toString(),
                        style: GoogleFonts.exo2(
                          textStyle: TextStyle(
                              fontSize: 12,
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              fontWeight: FontWeight.w500
                          ),
                        ),),
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        top: 10,
                        right: 10,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 13,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      width: 50,
                      child: Center(
                          child: Text(
                            count.toString(),
                            style: GoogleFonts.exo2(
                                textStyle: TextStyle(fontSize: 26)),
                          )),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 58,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width - 87,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10, left: 13, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 13,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                            controller: _searchQueryController,
                            onChanged: onSearchTextChanged,
                            autocorrect: true,
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            decoration: new InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintStyle: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              labelStyle: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              hintText: translate('new_delivery_hint').toString(),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white60,
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 55,
                          width: 55,
                          child: Container(
                            child: IconButton(
                              icon: new Image.asset(
                                'assets/images/barcode.png',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                              tooltip: 'Scan barcode',
                              onPressed: () {

                                if(cameraStatus=="true"){
                                  setState(() {
                                    qr_request = true;
                                  });

                                  setState(() {
                                    qrText = "";
                                  });
                                }
                                else{
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    action: SnackBarAction(
                                      label: 'Settings',
                                      textColor: Colors.blue,
                                      onPressed: () {
                                        // some code
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => SystemSettingsPage()));
                                      },
                                    ),
                                    content: Text(
                                      'Turn on Camera from System Settings First!',
                                      style: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    duration: Duration(seconds: 4),
                                  ));
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                // qr_request
                //     ? Padding(
                //   padding: EdgeInsets.only(top: 170.0),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width *.97,
                //     height: 300,
                //     // ignore: unrelated_type_equality_checks
                //     child: qrText.isEmpty && cameraStatus == "true"
                //         ? QRView(
                //       key: qrKey,
                //       onQRViewCreated: _onQRViewCreated,
                //       overlay: QrScannerOverlayShape(
                //         borderColor: Colors.green,
                //         borderRadius: 10,
                //         borderLength: 150,
                //         borderWidth: 10,
                //         cutOutSize: 300,
                //       ),
                //     )
                //         : Container(),
                //   ),
                // )
                //     : WillPopScope(
                //   // ignore: missing_return
                //   onWillPop: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => DeliveriesPage()));
                //     ndelivery_bloc.deleteTable();
                //   },
                //   child: SingleChildScrollView(
                //     child: Container(
                //
                //       child: Column(
                //         children: <Widget>[
                //           Container(
                //             height: 110,
                //             width: MediaQuery
                //                 .of(context)
                //                 .size
                //                 .width - 30,
                //             margin: EdgeInsets.only(top: 10),
                //             decoration: BoxDecoration(
                //               color: Theme
                //                   .of(context)
                //                   .backgroundColor,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Theme
                //                       .of(context)
                //                       .backgroundColor
                //                       .withOpacity(0.5),
                //                   spreadRadius: 2,
                //                   blurRadius: 5,
                //                   offset: Offset(0, 3),
                //                 ),
                //               ],
                //             ),
                //             child: StatefulBuilder(
                //               builder: (context, setState) {
                //                 return StreamBuilder(
                //                     stream: ndelivery_bloc.allProductData,
                //                     builder: (BuildContext context, AsyncSnapshot<
                //                         List<NewDeliveryModel>>snapshot) {
                //                       return newproductdata(snapshot);
                //                     });
                //               },
                //             ),
                //           ),
                //
                //           SizedBox(height: 20,),
                //
                //           Container(
                //             height: 110,
                //             width: MediaQuery
                //                 .of(context)
                //                 .size
                //                 .width - 30,
                //             margin: EdgeInsets.only(top: 10),
                //             decoration: BoxDecoration(
                //               color: Theme
                //                   .of(context)
                //                   .backgroundColor,
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Theme
                //                       .of(context)
                //                       .backgroundColor
                //                       .withOpacity(0.5),
                //                   spreadRadius: 2,
                //                   blurRadius: 5,
                //                   //TODO:: eikhane master data load khabe!
                //                   offset: Offset(0, 3),
                //                 ),
                //               ],
                //             ),
                //             child: StreamBuilder<List<MasterDataModel>>(
                //               stream: masterdata_bloc.allMasterData,
                //               builder: (context,
                //                   AsyncSnapshot<List<MasterDataModel>> snapshot) {
                //                 if (snapshot.hasData) {
                //                   _fetcheddata = snapshot.data;
                //                   //_newData = fetcheddata;
                //                   print("Data eikhane:: ");
                //
                //                   print(_fetcheddata.length);
                //                 }
                //
                //                 else if (snapshot.hasError) {
                //                   return Text("${snapshot.error}");
                //                 }
                //
                //                 return Center(child: Text(""));
                //                 //return masterdataview(_fetcheddata); //it should be changed
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },

      ),
    );
  }

  Widget newproductdata(AsyncSnapshot<List<NewDeliveryModel>> snapshot) {
    if (snapshot.hasData) {
      return Container(
        color: Theme
            .of(context)
            .backgroundColor,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            product = snapshot.data[index];
            final Widget dismissibleCard = new Dismissible(
              key: UniqueKey(),
              background: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Deleting",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                color: Colors.redAccent,
              ),
              onDismissed: (DismissDirection direction) {
                if (product.id.toString() != null) {
                  setState(() {
                    ndelivery_bloc.deleteProductById(product.id);
                  });

                  setState(() {
                    count--;
                    _searchQueryController.text = "";
                  });

                  //TODO:: SNACKBAR EXAMPLE

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Successfully Deleted',
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              direction: _dismissDirection,
              child: Container(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    snapshot.data[index].productName.toString(),
                    style: GoogleFonts.exo2(
                      fontSize: 20,
                    ),
                  ),

                  //TODO:: eikhane eshe streambuilder theke eshe porte thakbe

                  subtitle: Text(
                    snapshot.data[index].barcode.toString(),
                    style: GoogleFonts.exo2(),
                  ),
                ),
              ),
            );
            return dismissibleCard;
          },
        ),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    } else if (!snapshot.hasData) {
      Center(child: Text("No Data"));
    }

    return Center(child: CircularProgressIndicator());
//    return Center(child: Text("No Data"));
  }

  void _showNoteDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (_) =>
            StatefulBuilder(
              builder: (context, setState) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var width = MediaQuery
                          .of(context)
                          .size
                          .width;

                      return Form(
                        key: _resetKey1,
                        autovalidate: _resetValidate1,
                        child: Container(
                          height: 150,
                          width: width - 100,
                          child: new Column(
                            children: <Widget>[
//                              new Container(
//                                child: new TextFormField(
//                                  autofocus: false,
//                                  style: GoogleFonts.exo2(
//                                    textStyle: TextStyle(
//                                      fontSize: 20,
//                                    ),
//                                  ),
//                                  decoration: new InputDecoration(
//                                    focusedBorder: OutlineInputBorder(
//                                      borderSide: BorderSide(
//                                          color: Colors.blue, width: 3.0),
//                                    ),
//                                    enabledBorder: OutlineInputBorder(
//                                      borderSide:
//                                          BorderSide(color: Colors.black),
//                                    ),
//                                    hintStyle: GoogleFonts.exo2(
//                                      textStyle: TextStyle(
//                                        fontSize: 20,
//                                      ),
//                                    ),
//                                    labelStyle: GoogleFonts.exo2(
//                                      textStyle: TextStyle(
//                                        fontSize: 20,
//
//                                      ),
//                                    ),
//                                    labelText: 'Note',
//                                    hintText: 'Enter Your Note Here (Optional)',
//                                    errorText:
//                                        _validate1 == false ? errortext1 : null,
//                                  ),
//                                  controller: _inputcontrol1,
//                                  maxLines: null,
//                                  keyboardType: TextInputType.multiline,
//                                  // ignore: missing_return
//                                ),
//                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 16, bottom: 10),
                                      child: Text(
                                        translate('note').toString(),style: GoogleFonts.exo2(
                                        fontSize: 20,
                                      ),),
                                    ),
                                    Container(
                                      height: 90,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width - 80,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 0, left: 13, right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 8.0, bottom: 0),
                                        child: TextField(
                                          textAlign: TextAlign.start,
                                          controller: _inputcontrol1,
                                          autocorrect: true,
                                          style: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintStyle: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            labelStyle: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            hintText: translate('note_hint').toString(),
                                          ),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: Text(translate('skip').toString()),
                        onPressed: () {
                          print("Skip hbe arekta Dialog khulbe");
                          Navigator.pop(context);
                          _showHandlingUnitDialog(context);
                        }),
                    new FlatButton(
                        child: Text(translate('add').toString(),),
                        onPressed: () {
                          print("Add hobe");

                          product.note = _inputcontrol1.text;

                          print(product.barcode.toString());
                          print(product.note.toString());
                          print(product.id.toString());

                          ndelivery_bloc.updateProduct(product);

                          _inputcontrol1.text = "";

                          Navigator.pop(context);
                          _showHandlingUnitDialog(context);
                        })
                  ],
                );
              },
            ));
  }


  void _showHandlingUnitDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (_) =>
            StatefulBuilder(
              builder: (context, setState) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var width = MediaQuery
                          .of(context)
                          .size
                          .width;

                      return Form(
                        key: _resetKey2,
                        autovalidate: _resetValidate2,
                        child: Container(
                          height: 120,
                          width: width - 100,
                          child: new Column(
                            children: <Widget>[
//                          new Container(
//                            child: new TextFormField(
//                              autofocus: false,
//                              style: GoogleFonts.exo2(
//                                textStyle: TextStyle(
//                                  fontSize: 20,
//                                ),
//                              ),
//                              decoration: new InputDecoration(
//                                focusedBorder: OutlineInputBorder(
//                                  borderSide: BorderSide(
//                                      color: Colors.blue, width: 3.0),
//                                ),
//                                enabledBorder: OutlineInputBorder(
//                                  borderSide:
//                                  BorderSide(color: Colors.black),
//                                ),
//                                hintStyle: GoogleFonts.exo2(
//                                  textStyle: TextStyle(
//                                    fontSize: 20,
//                                  ),
//                                ),
//                                labelStyle: GoogleFonts.exo2(
//                                  textStyle: TextStyle(
//                                    fontSize: 20,
//
//                                  ),
//                                ),
//                                suffixIcon: IconButton(
//                                  icon: new Image.asset('assets/images/barcode.png',
//                                      fit: BoxFit.contain),
//                                  tooltip: 'Scan barcode',
//                                  onPressed: barcodeScanning2,
//                                ),
//                                labelText: 'Handling Unit',
//                                hintText: 'Enter Your Unit Barcode Here (Optional)',
//                                errorText:
//                                _validate1 == false ? errortext1 : null,
//                              ),
//                              controller: _inputcontrol2,
//                              maxLines: null,
//                              keyboardType: TextInputType.multiline,
//                              // ignore: missing_return
//                            ),
//                          ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 16, bottom: 10),
                                      child: Text(translate('handling_unit').toString(),
                                        style: GoogleFonts.exo2(
                                          fontSize: 20,
                                        ),),
                                    ),
                                    Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 0, left: 13, right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,

                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 8.0, bottom: 0),
                                        child: TextField(
                                          textAlign: TextAlign.start,
                                          controller: _inputcontrol2,
                                          autocorrect: true,
                                          style: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: new InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintStyle: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            labelStyle: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            hintText: translate('handling_unit_hint').toString(),
                                            suffixIcon: IconButton(
                                              icon: new Image.asset(
                                                  'assets/images/barcode.png',
                                                  fit: BoxFit.contain),
                                              tooltip: 'Scan barcode',
                                              onPressed: barcodeScanning2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: Text(translate('skip').toString()),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => DeliveryProductList()));

                          print("Skip hbe arekta Dialog khulbe");
                        }),
                    new FlatButton(
                        child: Text(translate('add').toString()),
                        onPressed: () async {
                          print("Add hobe");

                          final response = await client.get(
                              '$initial$serverIP:$serverPort/api/hunit/'+_inputcontrol2.text);

                          if (response.statusCode == 200) {
                            List jsonResponse = json.decode(response.body);

                            debugPrint(
                                "From Get Class:: " + jsonResponse.toString());          //TODO:: NEED THAT FOR LOGIN ALSO

                            if (jsonResponse.toString() == "[]") {
                              print("NULL VALUE");
                              product.handling_unit = "0";

                              print(product.handling_unit.toString());

                              ndelivery_bloc.updateProduct(product);

                              ndelivery_bloc.dispose();

                              _inputcontrol2.text = "";

                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      DeliveryProductList()));
                            }

                            else {
                              print("VALUE EXIST");
                              product.handling_unit = _inputcontrol2.text;

                              print(product.handling_unit.toString());

                              ndelivery_bloc.updateProduct(product);

                              ndelivery_bloc.dispose();

                              _inputcontrol2.text = "";

                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DeliveryProductList()));
                            }
                          }
                          else {
                            throw Exception('Failed to load jobs from API');
                          }
                        })
                  ],
                );
              },
            ));
  }


  Future barcodeScanning2() async {
    try {
      barcode2 = await BarcodeScanner.scan();
      print(barcode2.rawContent.toString());
      setState(() {
        this.barcode2 = barcode2;
        _inputcontrol2.text = barcode2.rawContent.toString();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode2 = 'No camera permission!' as ScanResult;
        });
      } else {
        setState(() => this.barcode2 = 'Unknown error: $e' as ScanResult);
      }
    } on FormatException {
      setState(() => this.barcode2 = 'Nothing captured.' as ScanResult);
    } catch (e) {
      setState(() => this.barcode2 = 'Unknown error: $e' as ScanResult);
    }
  }


  onSearchTextChanged(String text) async {
    _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()) || userDetail.id.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail);
    });

    if (_newData[0].gtin.toString() == _searchQueryController.text) {
      print("LIkheo paisi");

      newdelivery = NewDeliveryModel(
        barcode_: _searchQueryController.text.toString(),
        product_name_: _newData[0].productName.toString(),
        quantity_: 1,
        product_id_: _newData[0].id.toString(),
      );
      count++;
      ndelivery_bloc.insertProduct(newdelivery);
      ndelivery_bloc.dispose();
      ndelivery_bloc.getProduct();

      //print(_newData[0].id.toString());
    }

    else if (_newData[0].gtin.toString() == qrText.toString()) {
      print("Barcode paisi");

      newdelivery = NewDeliveryModel(
        barcode_: _searchQueryController.text.toString(),
        product_name_: _newData[0].productName.toString(),
        quantity_: 1,
        product_id_: _newData[0].id.toString(),
      );
      count++;
      ndelivery_bloc.insertProduct(newdelivery);
      ndelivery_bloc.dispose();
      ndelivery_bloc.getProduct();
    }

//    print(_newData[0].productName.toString());
//    print("ID is::::: "+_newData[0].id.toString());

//    Navigator.of(context).pushNamed('/details');
//    masterdata_bloc.getId(_newData[0].productId.toString());
//    masterdata_bloc.getsinglemasterdata();

    setState(() {});
  }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData;
//         _searchQueryController.text = qrText;
//
//
//
//         onSearchTextChanged(qrText.toString());
//
// //        ndelivery_bloc.getselecteditemProductName("ProductsNameHere");
// //        ndelivery_bloc.getselecteditemBarcode(_searchQueryController.text.toString());
// //        ndelivery_bloc.getselecteditemQuantity(1);
//
// //        newdelivery = NewDeliveryModel(
// //          barcode_: _searchQueryController.text.toString(),
// //          product_name_: "Product",
// //          quantity_: 1,
// //        );
//       });
//
// //      newdelivery.productName = qrText;
// //      newdelivery.Barcode = qrText;
// //      newdelivery.Quantity = 1;
//
//       setState(() {
//         controller.dispose();
//         qr_request = false;
//         //count++;
// //        print(newdelivery.barcode.toString());
// //        //print(newdelivery.productName.toString());
// //        ndelivery_bloc.insertProduct(newdelivery);
// //        ndelivery_bloc.dispose();
// //        ndelivery_bloc.getProduct();
//       });
//     });
//   }


}
