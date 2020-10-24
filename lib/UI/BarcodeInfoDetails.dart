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
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'Home.dart';

class BarcodeInfoDetailsPage extends StatefulWidget {

  String newFlag;

  BarcodeInfoDetailsPage({this.newFlag});

  @override
  _BarcodeInfoDetailsPageState createState() => _BarcodeInfoDetailsPageState();
}

class _BarcodeInfoDetailsPageState extends State<BarcodeInfoDetailsPage>
    with SingleTickerProviderStateMixin {
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



  var qrText = "";
  var controller;
  bool qr_request = false;

  TabController _tabController;

  @override
  void initState() {
    getCamera();
    masterdata_bloc.fetchAllMasterdatafromDBV2();
    masterdata_bloc.getsinglemasterdatafromDBV2();
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      getName();
    });
  }

  getName() {
    if (singledata.isNotEmpty) {
      setState(() {
        barcode = singledata[0].gtin.toString();
        description = singledata[0].productDescription.toString();
        proPic = singledata[0].productPicture.toString();
      });
    }
    print(barcode);
    print(proPic.toString());
    print("Flag Status: "+ widget.newFlag.toString());
  }

  void dispose() {
    // TODO: implement dispose
    // sublist_bloc.dispose();
    // masterdata_bloc.dispose();
    super.dispose();
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
            description.toString(),
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
                                          Text("Description"),
                                          Text("Barcode type"),
                                          Text("Number of digits"),
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
                                          Text(description == "" ? "No Data" : description.toString()),
                                          Text("No Data"),
                                          Text("No Data"),
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
                            child: Container(
                              height: hp(30),
                              width: wp(50),
                              color: Colors.transparent,
                              child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(top: hp(3)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(wp(2)),
                                  child: Image.file(File("/storage/emulated/0/Indentit/Photos/"+proPic.toString()), width: wp(45),
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
                            child: qrText.isEmpty
                                ? QRView(
                                    key: qrKey,
                                    onQRViewCreated: _onQRViewCreated,
                                    overlay: QrScannerOverlayShape(
                                      borderColor: Colors.green,
                                      borderRadius: 10,
                                      borderLength: 30,
                                      borderWidth: 10,
                                      cutOutSize: 300,
                                    ),
                                  )
                                : Container(),
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

  onSearchTextChanged(String text) async {
    _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.id.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail);
    });

    if (_newData[0].gtin.toString() == _searchQueryController.text) {
      //print(_newData[0].id.toString());
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => DetailsPage(product_name: _newData[0].productName.toString())));
      masterdata_bloc.getId(_newData[0].id.toString());
      masterdata_bloc.getsinglemasterdata();
    } else if (_newData[0].gtin.toString() == qrText.toString()) {
      print("Barcode paisi");
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => DetailsPage(product_name: _newData[0].productName.toString())));
      masterdata_bloc.getId(_newData[0].id.toString());
      masterdata_bloc.getsinglemasterdata();
    }

//    print(_newData[0].productName.toString());
//    print("ID is::::: "+_newData[0].id.toString());

//    Navigator.of(context).pushNamed('/details');
//    masterdata_bloc.getId(_newData[0].productId.toString());
//    masterdata_bloc.getsinglemasterdata();

    setState(() {});
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        _searchQueryController.text = qrText;

        onSearchTextChanged(qrText.toString());

//        ndelivery_bloc.getselecteditemProductName("ProductsNameHere");
//        ndelivery_bloc.getselecteditemBarcode(_searchQueryController.text.toString());
//        ndelivery_bloc.getselecteditemQuantity(1);

//        newdelivery = NewDeliveryModel(
//          barcode_: _searchQueryController.text.toString(),
//          product_name_: "Product",
//          quantity_: 1,
//        );
      });

//      newdelivery.productName = qrText;
//      newdelivery.Barcode = qrText;
//      newdelivery.Quantity = 1;

      setState(() {
        controller.dispose();
        qr_request = false;
        //count++;
//        print(newdelivery.barcode.toString());
//        //print(newdelivery.productName.toString());
//        ndelivery_bloc.insertProduct(newdelivery);
//        ndelivery_bloc.dispose();
//        ndelivery_bloc.getProduct();
      });
    });
  }
}
