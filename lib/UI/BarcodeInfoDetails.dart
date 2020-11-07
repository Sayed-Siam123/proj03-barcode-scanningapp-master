import 'dart:async';
import 'dart:io';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/BarcodeInfo.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/UI/ProductDetails.dart';
import 'package:app/UI/ProductEditPage.dart';
import 'package:app/UI/ProductGeneral.dart';
import 'package:app/UI/ProductPackaging.dart';
import 'package:app/UI/SystemSettings.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'Home.dart';

class BarcodeInfoDetailsPage extends StatefulWidget {

  String newFlag;

  BarcodeInfoDetailsPage({this.newFlag});

  @override
  _BarcodeInfoDetailsPageState createState() => _BarcodeInfoDetailsPageState();
}

class _BarcodeInfoDetailsPageState extends State<BarcodeInfoDetailsPage>
    with WidgetsBindingObserver implements ScannerCallBack {
  //TODO:: eikhane Product Details ashbe

  SessionManager prefs = SessionManager();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  String cameraStatus;

  String desc;
  String price;
  String picture;

  String barcode_type_stat;
  String num_of_digits;


  String _cameraKey = "_camera";
  List<MasterDataModelV2> _newData = [];
  List<MasterDataModelV2> _fetcheddata = [];
  List<SingleMasterDataModelV2> singledata = [];
  String productName = "";
  String barcode = "";
  String description = "";
  String barcode_type = "";
  String digits = "";
  String proPic = "";
  String price_data = "";

  TextEditingController barcode_text = TextEditingController();


  String _showDescriptionKey = "_showDescription";
  String _showPriceKey = "_showPrice";
  String _showPicturesKey = "_showPictures";
  String _showBarcodeKey = "_showBarcode";
  String _showNumberofDigitsKey = "_showNumberofDigits";



  var qrText = "";
  var controller;
  bool qr_request = false;

  TabController _tabController;


  var isEditable = true;
  FocusNode _focusNode = new FocusNode();

  HoneywellScanner honeywellScanner = HoneywellScanner();
  String scannedCode = 'Empty';
  bool scannerEnabled = false;
  bool scan1DFormats = true;
  bool scan2DFormats = true;

  var root;

  @override
  void initState() {
    getCamera();
    masterdata_bloc.fetchAllMasterdatafromDBV2();
    masterdata_bloc.getsinglemasterdatafromDBV2();
    WidgetsBinding.instance.addObserver(this);
    honeywellScanner.setScannerCallBack(this);
    updateScanProperties();
    super.initState();
    source();
    Timer(Duration(milliseconds: 300), () {
      getName();
      getDesc();
      getPic();
      getPrice();
      getBarType();
      getNumofDigits();
    });
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(honeywellScanner != null) honeywellScanner.stopScanner();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == null) return;
    switch(state){
      case AppLifecycleState.resumed:
        if(honeywellScanner != null) honeywellScanner.resumeScanner();
        break;
      case AppLifecycleState.inactive:
        if(honeywellScanner != null) honeywellScanner.pauseScanner();
        break;
      case AppLifecycleState.paused://AppLifecycleState.paused is used as stopped state because deactivate() works more as a pause for lifecycle
        if(honeywellScanner != null) honeywellScanner.pauseScanner();
        break;
      case AppLifecycleState.detached:
        if(honeywellScanner != null) honeywellScanner.pauseScanner();
        break;
      default:
        break;
    }  }

  updateScanProperties() {
    List<CodeFormat> codeFormats = [];
    if (scan1DFormats ?? false)
      codeFormats.addAll(CodeFormatUtils.ALL_1D_FORMATS);
    if (scan2DFormats ?? false)
      codeFormats.addAll(CodeFormatUtils.ALL_2D_FORMATS);

//    codeFormats.add(CodeFormat.AZTEC);
//    codeFormats.add(CodeFormat.CODABAR);
//    codeFormats.add(CodeFormat.CODE_39);
//    codeFormats.add(CodeFormat.CODE_93);
//    codeFormats.add(CodeFormat.CODE_128);
//    codeFormats.add(CodeFormat.DATA_MATRIX);
//    codeFormats.add(CodeFormat.EAN_8);
//    codeFormats.add(CodeFormat.EAN_13);
////    codeFormats.add(CodeFormat.ITF);
//    codeFormats.add(CodeFormat.MAXICODE);
//    codeFormats.add(CodeFormat.PDF_417);
//    codeFormats.add(CodeFormat.QR_CODE);
//    codeFormats.add(CodeFormat.RSS_14);
//    codeFormats.add(CodeFormat.RSS_EXPANDED);
//    codeFormats.add(CodeFormat.UPC_A);
//    codeFormats.add(CodeFormat.UPC_E);
////    codeFormats.add(CodeFormat.UPC_EAN_EXTENSION);

    honeywellScanner.setProperties(
        CodeFormatUtils.getAsPropertiesComplement(codeFormats));
  }


  @override
  void onDecoded(String result) {
    setState(() {
      scannedCode = result;
      barcode_text.text = scannedCode;
      onSearchTextChanged(scannedCode.toString());
    });
    honeywellScanner.stopScanner();
    setState(() {
      scannerEnabled = false;
    });
  }

  @override
  void onError(Exception error) {
    setState(() {
      scannedCode = error.toString();
    });
  }


  void source() async{
    Timer(Duration(milliseconds: 50),() async{
      List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();

      setState(() {
        root = storageInfo[0].appFilesDir+"/Indentit/Photos/"; //storageInfo[1] for SD card, getting the root directory
      });
      // print(root.toString());
      // print(root.toString()+"/"+widget.productPicture);

    });
  }

  getName() {
    if (singledata.isNotEmpty) {
      setState(() {
        barcode = singledata[0].gtin.toString();
        description = singledata[0].productDescription.toString();
        proPic = singledata[0].productPicture.toString();
        price_data = singledata[0].listPrice.toString();
        barcode_type = singledata[0].code_type.toString();
        digits = singledata[0].code_digits.toString();
      });
    }
    print(barcode);
    print(proPic.toString());
    print("Flag Status: "+ widget.newFlag.toString());
  }

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

  void getDesc() async {
    Future<bool> descrip = prefs.getBoolData(_showDescriptionKey);
    descrip.then((data) async {
      print("desc status " + data.toString());

      setState(() {
        desc = data.toString();
      });
      print(desc.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  void getPrice() async {
    Future<bool> descrip = prefs.getBoolData(_showPriceKey);
    descrip.then((data) async {
      print("camera status " + data.toString());

      setState(() {
        price = data.toString();
      });
      print(price.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  void getPic() async {
    Future<bool> descrip = prefs.getBoolData(_showPicturesKey);
    descrip.then((data) async {
      print("Picture status " + data.toString());

      setState(() {
        picture = data.toString();
      });
      print(picture.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  void getBarType() async {
    Future<bool> barType = prefs.getBoolData(_showBarcodeKey);
    barType.then((data) async {
      print("barcode type status " + data.toString());

      setState(() {
        barcode_type_stat = data.toString();
      });
      print(barcode_type_stat.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  void getNumofDigits() async {
    Future<bool> numDigits = prefs.getBoolData(_showNumberofDigitsKey);
    numDigits.then((data) async {
      print("barcode type status " + data.toString());

      setState(() {
        num_of_digits = data.toString();
      });
      print(num_of_digits.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => BarcodeInfo()));
      },
      child: new Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "Barcode Information",
            style: GoogleFonts.exo2(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 00.00,
          leading: new IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage())),
          ),
        ),

        body: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) {
              return qr_request == false
                  ? Stack(
                      children: <Widget>[
                        StreamBuilder<List<MasterDataModelV2>>(
                          stream: masterdata_bloc.allMasterDataV2,
                          builder: (context,
                              AsyncSnapshot<List<MasterDataModelV2>> snapshot) {
                            if (snapshot.hasData) {
                              _fetcheddata = snapshot.data;
                              //_newData = fetcheddata;
                              print(
                                  "Data eikhane koyta dekho to 2nd route e:: ");

                              print(_fetcheddata.length);
                              //return masterdataview(_fetcheddata, context);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            return Center(child: Text(""));
                            //return masterdataview(_fetcheddata); //it should be changed
                          },
                        ),

                        StreamBuilder<List<SingleMasterDataModelV2>>(
                            stream: masterdata_bloc.singleMasterDatav2,
                            builder: (context,
                                AsyncSnapshot<List<SingleMasterDataModelV2>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                singledata = snapshot.data;
                                print("Data gula 2nd route e for single file:: ");
                                print(singledata.length);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              return Center(child: Text(""));
                            }),
                        // Expanded(
                        //   child: TabBarView(
                        //     children: [
                        //       new ProductGeneralPage(),
                        //       new ProductDetailsPage(),
                        //       new ProductPackagingPage(),
                        //     ],
                        //     controller: _tabController,
                        //   ),
                        // ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(wp(2),hp(30),wp(2),hp(2)),
                          child: Container(
                            width: wp(100),
                            color: Colors.white,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(hp(5),hp(8),hp(3),hp(10)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(hp(2)),
                                      height: hp(30),
                                      width: wp(34),
                                      color: Colors.transparent,
                                      child: Column(
                                        children: <Widget>[
                                          Text("Barcode"),
                                          desc == "null" || desc == "false" ? Text("") : Text("Description"),
                                          price == "null" || price == "false" ? Text("") : Text("Price"),
                                          barcode_type_stat == "null" || barcode_type_stat == "false" ? Text("") : Text("Barcode type"),
                                          num_of_digits == "null" || num_of_digits == "false" ? Text("") : Text("Number of digits"),

                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      ),
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(hp(0),hp(8),hp(2),hp(3)),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(hp(0),hp(2),hp(0),hp(2)),
                                      height: hp(30),
                                      width: wp(50),
                                      color: Colors.transparent,
                                      child: Column(
                                        children: <Widget>[
                                          Text(barcode.toString()),
                                          // Container(
                                          //   height: hp(2.5),
                                          //   width: wp(40),
                                          //   color: Colors.transparent,
                                          //   child: TextField(
                                          //       autofocus: true,
                                          //       controller: barcode_text,
                                          //       focusNode: _focusNode,
                                          //       decoration: InputDecoration(
                                          //         suffixIcon: IconButton(
                                          //           icon: Icon(
                                          //             isEditable == false
                                          //                 ? MaterialIcons.touch_app
                                          //                 : AntDesign.barcode,
                                          //             color: Colors.black54,
                                          //           ),
                                          //           onPressed: () {
                                          //             if (isEditable) {
                                          //               setState(() {
                                          //                 //during qr mode
                                          //                 isEditable = false;
                                          //                 _focusNode.unfocus();
                                          //               });
                                          //             } else {
                                          //               setState(() {
                                          //                 //during keyboard mode
                                          //                 isEditable = true;
                                          //                 _focusNode.requestFocus();
                                          //               });
                                          //             }
                                          //
                                          //             print(isEditable.toString());
                                          //           },
                                          //           iconSize: hp(2),
                                          //           padding: EdgeInsets.fromLTRB(wp(5), 0, 0, hp(1)),
                                          //         ),
                                          //         enabledBorder: UnderlineInputBorder(
                                          //           borderSide: BorderSide(color: Colors.black87),
                                          //         ),
                                          //         focusedBorder: UnderlineInputBorder(
                                          //           borderSide: BorderSide(color: Colors.black87),
                                          //         ),
                                          //       ),
                                          //     onChanged: (String value){
                                          //         onSearchTextChanged(value);
                                          //     },
                                          //   ),
                                          // ),
                                          desc == "null" || desc == "false" ? Text("") : Text(description == "" ? "No Data" : description.toString()),
                                          price == "null" || price == "false" ? Text("") : Text(price_data.toString()),
                                          barcode_type_stat == "null" || barcode_type_stat == "false" ? Text("") : Text(barcode_type == "" ? "No Data" : barcode_type.toString()),
                                          num_of_digits == "null" || num_of_digits == "false" ? Text("") : Text(digits == "" ? "No Data" : digits.toString()),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        widget.newFlag == "false" ? Padding(
                          padding: EdgeInsets.fromLTRB(hp(3),hp(8),hp(3),hp(3)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: hp(30),
                              width: wp(50),
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(top: hp(3)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(wp(2)),
                                  child: Image.network(
                                    'http://202.164.212.238:8054'+proPic.toString(), //TODO:: null picture set
                                    width: wp(45),
                                    height: hp(25),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ): Padding(
                          padding: EdgeInsets.fromLTRB(hp(3),hp(8),hp(3),hp(3)),
                          child: Align(
                            alignment: Alignment.center,
                            child: picture == "null" || picture == "false" ?  Container(height: 0,width: 0,) :
                            Container(
                              height: hp(30),
                              width: wp(50),
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(top: hp(3)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(wp(2)),
                                  child: Image.file(File(root+proPic.toString()), width: wp(45),
                                    height: hp(25),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 200.0, left: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 60,
                            height: 300,
                            // child: qrText.isEmpty
                            //     ? QRView(
                            //         key: qrKey,
                            //         onQRViewCreated: _onQRViewCreated,
                            //         overlay: QrScannerOverlayShape(
                            //           borderColor: Colors.green,
                            //           borderRadius: 10,
                            //           borderLength: 30,
                            //           borderWidth: 10,
                            //           cutOutSize: 300,
                            //         ),
                            //       )
                            //     : Container(),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     print("Its for barcode: ");
        //     if (cameraStatus == "true") {
        //       setState(() {
        //         qr_request = true;
        //       });
        //
        //       setState(() {
        //         qrText = "";
        //       });
        //     } else {
        //       Scaffold.of(context).showSnackBar(SnackBar(
        //         action: SnackBarAction(
        //           label: 'Settings',
        //           textColor: Colors.blue,
        //           onPressed: () {
        //             // some code
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => SystemSettingsPage()));
        //           },
        //         ),
        //         content: Text(
        //           'Turn on Camera from System Settings First!',
        //           style: GoogleFonts.exo2(
        //             textStyle: TextStyle(
        //               fontSize: 16,
        //             ),
        //           ),
        //         ),
        //         duration: Duration(seconds: 4),
        //       ));
        //     }
        //   },
        //   child: new Image.asset(
        //     'assets/images/barcode.png',
        //     fit: BoxFit.contain,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: Colors.green,
        // ),
//      body: Container(
//        margin: EdgeInsets.all(10),
//        child: StreamBuilder<List<SingleMasterDataModel>>(
//          stream: masterdata_bloc.singleMasterData,
//          builder: (context, AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
//            if (snapshot.hasData) {
//              List<SingleMasterDataModel> data = snapshot.data;
//              print("Data gula:: ");
//              print(data.length);
//              return masterdataview(data);
//
//            } else if (snapshot.hasError) {
//              return Text("${snapshot.error}");
//            }
//
//            return CircularProgressIndicator();
//          },
//        ),
//      ),

        // bottomNavigationBar: Container(
        //   color: Theme.of(context).backgroundColor,
        //   margin: EdgeInsets.only(bottom: 3),
        //   child: TabBar(
        //     indicatorWeight: 4,
        //     labelStyle: GoogleFonts.exo2(
        //         color: Colors.black, fontWeight: FontWeight.bold),
        //     unselectedLabelColor: Colors.black45,
        //     labelColor: Colors.black,
        //     tabs: [
        //       new Tab(
        //         text: translate('general').toString(),
        //       ),
        //       new Tab(
        //         text: translate('details').toString(),
        //       ),
        //       new Tab(
        //         text: translate('packaging').toString(),
        //       )
        //     ],
        //     controller: _tabController,
        //     indicatorColor: Colors.black,
        //     indicatorSize: TabBarIndicatorSize.tab,
        //   ),
        // ),
      ),
    );
  }

  void onSearchTextChanged(String text) async {
    print(text);
    _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail);
    });

    Timer(Duration(milliseconds: 500), () {
      checkData();
    });

    setState(() {});
  }

  void checkData() {

    if (_newData.isNotEmpty && _newData[0].gtin.toString() == barcode_text.text) {
      print("found");
      Timer(Duration(milliseconds: 300),(){
        setState(() {
          barcode_text.text = _newData[0].gtin.toString();
          description = _newData[0].productDescription.toString();
          proPic = _newData[0].productPicture.toString();
          price_data = _newData[0].listPrice.toString();
          barcode_type = _newData[0].code_type.toString();
          digits = _newData[0].code_digits.toString();
        });
      });
    }

    else {
      print("not found");
    }

    //print(_searchQueryController.text.toString());
  }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData;
//         _searchQueryController.text = qrText;
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
