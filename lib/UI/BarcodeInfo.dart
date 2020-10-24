import 'dart:async';

import 'package:app/Bloc/NewDelivery_bloc.dart';
import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/Widgets/MastarDataWidget.dart';
import 'package:app/UI/SystemSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'BarcodeInfoDetails.dart';
import 'BarcodeinfoSystemSettings.dart';
import 'Details.dart';
import 'Home.dart';
import 'package:barcode_scan/barcode_scan.dart';

class BarcodeInfo extends StatefulWidget {
  @override
  _BarcodeInfoState createState() => _BarcodeInfoState();
}

class _BarcodeInfoState extends State<BarcodeInfo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  SessionManager prefs = SessionManager();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  String cameraStatus;
  String _cameraKey = "_camera";
  List<MasterDataModelV2> _newData = [];
  List<MasterDataModelV2> _fetcheddata = [];

  var qrText = "";
  var controller;
  bool qr_request = true;
  bool qr_complete = false;

  //Barcode scan implement
  ScanResult barcode;

  //String _scanBarcode = 'Unknown';

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

  initState() {
    //getCamera();
    masterdata_bloc.fetchAllMasterdatafromDBV2();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sublist_bloc.dispose();
    masterdata_bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              return Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          title: Text(
            "Barcode Information",
            style: GoogleFonts.exo2(
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BarcodeinfoSystemSettings()));
              },
              icon: Icon(Icons.settings,color: Colors.black54,),
            )
          ],
        ),
        // body: Container(
        //   color: Theme.of(context).backgroundColor,
        //   child: StreamBuilder<List<MasterDataModel>>(
        //     stream: masterdata_bloc.allMasterData,
        //     builder: (context, AsyncSnapshot<List<MasterDataModel>> snapshot) {
        //       if (snapshot.hasData) {
        //         _fetcheddata = snapshot.data;
        //         //_newData = fetcheddata;
        //         print("Data gula:: ");
        //
        //         print(_fetcheddata.length);
        //         return masterdataview(_fetcheddata, context);
        //       } else if (snapshot.hasError) {
        //         return Text("${snapshot.error}");
        //       }
        //
        //       return Center(child: CircularProgressIndicator());
        //       //return masterdataview(_fetcheddata); //it should be changed
        //     },
        //   ),
        // ),
        body: Builder(
          builder: (context) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: hp(3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        StreamBuilder<List<MasterDataModelV2>>(
                          stream: masterdata_bloc.allMasterDataV2,
                          builder: (context,
                              AsyncSnapshot<List<MasterDataModelV2>>
                              snapshot) {
                            if (snapshot.hasData) {
                              _fetcheddata = snapshot.data;
                              //_newData = fetcheddata;
                              print("Data eikhane koyta dekho to:: ");

                              print(_fetcheddata.length);
                              //return masterdataview(_fetcheddata, context);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }

                            return Center(child: Text(""));
                            //return masterdataview(_fetcheddata); //it should be changed
                          },
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 15.0, top: 5),
                        //   child: Text(
                        //     translate('search').toString(),
                        //     style: GoogleFonts.exo2(
                        //       textStyle: TextStyle(
                        //           fontSize: 20,
                        //           color: Theme.of(context).accentColor),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 5, left: 15.0),
                        //   child: Text(
                        //     translate('search_desc').toString(),
                        //     style: GoogleFonts.exo2(
                        //       textStyle: TextStyle(
                        //           fontSize: 15,
                        //           color: Theme.of(context).accentColor),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: hp(10),
                        width: wp(95),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 0, left: hp(1.5), right: 0,bottom: hp(1)),
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
                              // onTap: () {
                              //   setState(() {
                              //     qr_request = false;
                              //   });
                              // },
                              autofocus: true,
                              keyboardType: TextInputType.number,
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
                                hintText: "Enter barcode to search",
                              )),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 10.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).buttonColor,
                      //       borderRadius: BorderRadius.all(Radius.circular(5)),
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.white60,
                      //           spreadRadius: 1,
                      //           blurRadius: 1,
                      //           offset: Offset(1, 1),
                      //         ),
                      //       ],
                      //     ),
                      //     child: SizedBox(
                      //       height: 55,
                      //       width: 55,
                      //       child: Container(
                      //         child: IconButton(
                      //           icon: Icon(Entypo.keyboard),
                      //           tooltip: 'Enter Keypad entry',
                      //           onPressed: () {
                      //             // if (cameraStatus == "true") {
                      //             //   setState(() {
                      //             //     qr_request = true;
                      //             //   });
                      //             //
                      //             //   setState(() {
                      //             //     qrText = "";
                      //             //   });
                      //             // } else {
                      //             //   Scaffold.of(context).showSnackBar(SnackBar(
                      //             //     action: SnackBarAction(
                      //             //       label: 'Settings',
                      //             //       textColor: Colors.blue,
                      //             //       onPressed: () {
                      //             //         // some code
                      //             //         Navigator.push(
                      //             //             context,
                      //             //             MaterialPageRoute(
                      //             //                 builder: (context) =>
                      //             //                     SystemSettingsPage()));
                      //             //       },
                      //             //     ),
                      //             //     content: Text(
                      //             //       'Turn on Camera from System Settings First!',
                      //             //       style: GoogleFonts.exo2(
                      //             //         textStyle: TextStyle(
                      //             //           fontSize: 16,
                      //             //         ),
                      //             //       ),
                      //             //     ),
                      //             //     duration: Duration(seconds: 4),
                      //             //   ));
                      //             // }
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  // qr_request
                  //     ? Column(
                  //         children: <Widget>[
                  //           Padding(
                  //             padding: EdgeInsets.only(top: 170.0),
                  //             child: Container(
                  //               width: MediaQuery.of(context).size.width *.97,
                  //               height: 300,
                  //               // ignore: unrelated_type_equality_checks
                  //               child: qrText.isEmpty && cameraStatus == "true"
                  //                   ? QRView(
                  //                       key: qrKey,
                  //                       onQRViewCreated: _onQRViewCreated,
                  //                       overlay: QrScannerOverlayShape(
                  //                         borderColor: Colors.green,
                  //                         borderRadius: 10,
                  //                         borderLength: 150,
                  //                         borderWidth: 10,
                  //                         cutOutSize: 300,
                  //                       ),
                  //                     )
                  //                   : Container(),
                  //             ),
                  //           ),
                  //           Container(
                  //             height: 110,
                  //             width: MediaQuery.of(context).size.width - 30,
                  //             margin: EdgeInsets.only(top: 10),
                  //             decoration: BoxDecoration(
                  //               color: Theme.of(context).backgroundColor,
                  //               boxShadow: [
                  //                 BoxShadow(
                  //                   color: Theme.of(context)
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
                  //                   AsyncSnapshot<List<MasterDataModel>>
                  //                       snapshot) {
                  //                 if (snapshot.hasData) {
                  //                   _fetcheddata = snapshot.data;
                  //                   //_newData = fetcheddata;
                  //                   print("Data eikhane koyta dekho to:: ");
                  //
                  //                   print(_fetcheddata.length);
                  //                   //return masterdataview(_fetcheddata, context);
                  //                 } else if (snapshot.hasError) {
                  //                   return Text("${snapshot.error}");
                  //                 }
                  //
                  //                 return Center(child: Text(""));
                  //                 //return masterdataview(_fetcheddata); //it should be changed
                  //               },
                  //             ),
                  //           ),
                  //         ],
                  //       )
                  //
                  //     // : qr_complete ? Container(
                  //     //   height: 200,
                  //     //     width: 200,
                  //     //     child: Text("Complete hoyeche"))
                  //
                  //     : qr_complete
                  //         ? WillPopScope(
                  //             // ignore: missing_return
                  //             onWillPop: () {},
                  //             child: SingleChildScrollView(
                  //               child: Container(
                  //                 child: Column(
                  //                   children: <Widget>[
                  //                     Container(
                  //                       margin: EdgeInsets.only(top: 10),
                  //                       height: 100,
                  //                       width: double.infinity,
                  //                       color:
                  //                           Theme.of(context).backgroundColor,
                  //                       child: ListView.builder(
                  //                           scrollDirection: Axis.vertical,
                  //                           itemCount: _newData.length,
                  //                           itemBuilder: (BuildContext context,
                  //                               int index) {
                  //                             return Column(
                  //                               children: <Widget>[
                  //                                 MasterDataWidget(
                  //                                   gtin: _newData[index].gtin,
                  //                                   product_name:
                  //                                       _newData[index]
                  //                                           .productName,
                  //                                   category: _newData[index]
                  //                                       .categoryName,
                  //                                   product_id:
                  //                                       _newData[index].id,
                  //                                   productPicture:
                  //                                       _newData[index]
                  //                                           .productPicture,
                  //                                 ),
                  //                                 SizedBox(
                  //                                   height: 6,
                  //                                 )
                  //                               ],
                  //                             );
                  //                           }),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           )
                  //         : Container(height: 200, width: 200, child: Text("")),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future barcodeScanning() async {
    try {
      barcode = await BarcodeScanner.scan();
      print(barcode.rawContent.toString());
      setState(() {
        this.barcode = barcode;
        _searchQueryController.text = barcode.rawContent.toString();
        onSearchTextChanged(barcode.rawContent.toString());
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!' as ScanResult;
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e' as ScanResult);
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.' as ScanResult);
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e' as ScanResult);
    }
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

    Timer(Duration(milliseconds: 100),(){
      checkData();
    });

    setState(() {});
  }

  void checkData(){
    if (_newData.isNotEmpty && _newData[0].gtin.toString() == _searchQueryController.text) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BarcodeInfoDetailsPage()));
      masterdata_bloc.getId(_newData[0].id.toString());
      masterdata_bloc.getsinglemasterdatafromDB();
    } else {
      print("not found");
    }

    //print(_searchQueryController.text.toString());

  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        _searchQueryController.text = qrText;
      });

      print("Scanned DATA: " + qrText.toString());
      setState(() {
        qr_complete = true;
      });

      onSearchTextChanged(qrText.toString());
      setState(() {
        controller.dispose();
        qr_request = false;
      });
    });
  }
}
