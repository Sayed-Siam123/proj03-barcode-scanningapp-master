import 'dart:async';

import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/AddProduct.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/SystemSettings.dart';
import 'package:app/Widgets/MastarDataWidget.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:sweetalert/sweetalert.dart';

class MasterData extends StatefulWidget {
  @override
  _MasterDataState createState() => _MasterDataState();
}

class _MasterDataState extends State<MasterData> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  ProgressDialog pr;
  // List<MasterDataModel> _newData = [];
  // List<MasterDataModel> fetcheddata = [];

  List<MasterDataModelV2> _newData = [];
  List<MasterDataModelV2> fetcheddata = [];


  StreamSubscription streamerforIChecker;
  ConnectivityResult result;
  var isEditable = false;
  FocusNode _focusNode = new FocusNode();


  //Barcode scan implement
  ScanResult barcode;

  //String _scanBarcode = 'Unknown';
  bool price_status;
  String _managePricesKey = "_managePrices";


  SessionManager prefs = SessionManager();

  void getpriceShowStatus() async {
    Future<bool> serverip = prefs.getBoolData(_managePricesKey);
    serverip.then((data) async {
      print('price show status pabo');
      print("price show status " + data.toString());

      setState(() {
        price_status = data;
      });
      print(price_status.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  initState() {
    masterdata_bloc.fetchAllMasterdatafromDBV2();
    super.initState();
    Timer(Duration(microseconds: 50), () {
      getpriceShowStatus();
    });
  }

  _showDialog(String title) async {
    await Future.delayed(Duration(seconds: 1));

    SweetAlert.show(
      context,
      title: "Info!",
      subtitle: title.toString(), //TODO:: SWEET ALERT EXAMPLE
      style: SweetAlertStyle.loading,
    );
  }

  _showDialog1(String title) async {
    await Future.delayed(Duration(seconds: 1));

    SweetAlert.show(
      context,
      title: "Info!",
      subtitle: title.toString(), //TODO:: SWEET ALERT EXAMPLE
      style: SweetAlertStyle.success,
    );
  }

  _showDialog2(BuildContext context) async {
//    pr = ProgressDialog(
//      context,
//      type: ProgressDialogType.Download,
//      textDirection: TextDirection.rtl,
//      isDismissible: true,
////      customBody: LinearProgressIndicator(
////        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
////        backgroundColor: Colors.white,
////      ),
//    );
//
//    pr.style(
////      message: 'Downloading file...',
//      message:
//      'Please Wait',
//      borderRadius: 10.0,
//      backgroundColor: Colors.white,
//      elevation: 10.0,
//      insetAnimCurve: Curves.easeInOut,
//      progress: 0.0,
//      progressWidgetAlignment: Alignment.center,
//      maxProgress: 100.0,
//      progressTextStyle: TextStyle(
//          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
//      messageTextStyle: TextStyle(
//          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
//    );

    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    pr.style(
      message: 'Backuping data. Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

  Widget build(BuildContext context) {

    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    _showDialog2(context);
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage())),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: _isSearching
              ? new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black45,
              ),
              color: Colors.black54,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));

                //
                // _scaffoldKey.currentState.openDrawer();
              })
              : new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    color: Colors.black45,
                  ),
                  color: Colors.black54,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));

                    //
                    // _scaffoldKey.currentState.openDrawer();
                  }),
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: StreamBuilder<List<MasterDataModelV2>>(
            stream: masterdata_bloc.allMasterDataV2,
            builder: (context, AsyncSnapshot<List<MasterDataModelV2>> snapshot) {
              if (snapshot.hasData) {

                fetcheddata = snapshot.data;

                //_newData = fetcheddata;
                print(fetcheddata.length);
                return fetcheddata.length > 0 ? masterdataview(hp(100),wp(100),fetcheddata): Center(child: Text("No data"));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {
//            print("jabs");
//            Navigator.push(context,
//                MaterialPageRoute(builder: (context) => AddProductPage()));
//            // Add your onPressed code here!
//          },
//          child: Icon(
//            Icons.add,
//            size: 50,
//          ),
//          backgroundColor: Colors.green,
//        ),
        floatingActionButton: Container(
          height: 110,
          width: MediaQuery.of(context).size.width - 30,
          child: Stack(
            children: <Widget>[
//               Align(
//                 alignment: Alignment.bottomLeft,
//                 child: FloatingActionButton(
//                   heroTag: null,
//                   tooltip: "Backup data",
//                   backgroundColor: Colors.green,
//                   onPressed: () async {
//                     print("jabs");
//
//                     var connectivityResult =
//                         await (Connectivity().checkConnectivity());
//                     if (connectivityResult == ConnectivityResult.mobile) {
//                       //_showDialog1("Mobile Internet OK");
//                       pr.show();
//                       masterdata_bloc.syncAddDatatoAPI(); //sync the data to api
//                       masterdata_bloc.syncUpdateDatatoAPI();
//                       Future.delayed(Duration(seconds: 3)).then((value) {
//                         pr.hide().whenComplete(() {
// //                        Navigator.of(context).push(CupertinoPageRoute(
// //                            builder: (BuildContext context) => SecondScreen()));
//                           print("COmpleted");
//                         });
//                       });
//                     } else if (connectivityResult == ConnectivityResult.wifi) {
//                       //_showDialog1("WiFi Internet OK");
//                       pr.show();
//                       masterdata_bloc.syncAddDatatoAPI(); //sync the data to api
//                       masterdata_bloc.syncUpdateDatatoAPI();
//                       Future.delayed(Duration(seconds: 3)).then((value) {
//                         pr.hide().whenComplete(() {
// //                        Navigator.of(context).push(CupertinoPageRoute(
// //                            builder: (BuildContext context) => SecondScreen()));
//                           print("COmpleted");
//                         });
//                       });
//                     } else {
//                       print("No internet");
//                       _showDialog("No Internet");
//                     }
//                   },
//                   child: Icon(
//                     Icons.cloud_upload,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ),
              Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    print("jabs");

                    //dynamic lastID = int.parse(fetcheddata.last.id.toString())?? 0;

                    if(fetcheddata.length == 0){
                      print("0");
                      Navigator.push(
                          context, MaterialPageRoute(
                                 builder: (context) => AddProductPage(id: 0)));
                    }

                    else{
                      print("1");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductPage(
                                id: int.parse(fetcheddata.last.id.toString()),
                                context: context,
                              )));
                    }
                    // Add your onPressed code here!
                  },
                  child: Icon(
                    Icons.add,
                    size: 50,
                  ),
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Search widget
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,

      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: GoogleFonts.exo2(
          textStyle: TextStyle(fontSize: 20, color: Colors.black38),
        ),
      ),
      style: GoogleFonts.exo2(
        textStyle: TextStyle(fontSize: 16, color: Colors.black),
      ),
      onChanged: onSearchTextChanged,
      focusNode: _focusNode,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: Icon(
            isEditable == false ? MaterialIcons.touch_app : AntDesign.barcode,
            color: Colors.black45,
          ),
          onPressed: () {
            // if (_searchQueryController == null ||
            //     _searchQueryController.text.isEmpty) {
            //   Navigator.pop(context);
            //   return;
            // }
            // _clearSearchQuery();

            if(isEditable){
              setState(() {
                //during qr mode
                isEditable = false;
                _focusNode.unfocus();
              });
            }

            else{
              setState(() {
                //during keyboard mode
                isEditable = true;
                _focusNode.requestFocus();
              });
            }

            print(isEditable.toString());


          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search,
          color: Colors.black45,
        ),
        onPressed: _startSearch,
      ),
      // IconButton(
      //   icon: Icon(Icons.settings,color: Colors.black54,),
      //   tooltip: 'Settings',
      //   onPressed: (){
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => SystemSettingsPage()));
      //   },
      // ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

//  void updateSearchQuery(String newQuery) {
//
//      setState(() {
//
//        for (int i = 0; i < fetcheddata.length; i++) {
//          String gtin = fetcheddata.elementAt(i).gtin;
//          if (gtin.toLowerCase().contains(newQuery.toLowerCase())) {
//             print("Paisi");
//             print(gtin);
//
//             //_newData.add(fetcheddata.elementAt(i));
//          }
//
//          else{
//            print("No Such Data");
//          }
//        }
////        _newData = fetcheddata.where((list) => list.toString().contains(newQuery.toLowerCase())).toList();
//      });
//
//  }

  onSearchTextChanged(String text) async {
    _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail);
    });

    setState(() {});
  }

//  void updateView(String newQuery){
//    //_newData.clear();
//    if (newQuery.length > 0) {
//      Set<MasterDataModel> set = Set.from(fetcheddata);
//      set.forEach((element) => updateSearchQuery(newQuery));
//    }
//    if (newQuery.isEmpty) {
//      _newData.addAll(fetcheddata);
//    }
//    setState(() {});
//  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
    });
  }

  _buildTitle(BuildContext context) {
    return Text(translate('masterdata').toString(),
        style: GoogleFonts.exo2(
          textStyle: TextStyle(fontSize: 20, color: Colors.black),
        ));
  }

  //scan barcode asynchronously
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

  Widget masterdataview(height,width,data) {
    dynamic hp = Hp(height).hp;
    dynamic wp = Wp(width).wp;

    return _newData.length != 0 || _searchQueryController.text.isNotEmpty
        ? RefreshIndicator(
            key: _refreshIndicatorKey,
            // ignore: missing_return
            onRefresh: () {
              //masterdata_bloc.fetchAllMasterData();
              return masterdata_bloc.fetchAllMasterdatafromDBV2();
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _newData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      MasterDataWidget(
                        height: hp(100),
                        width: wp(100),
                        gtin: _newData[index].gtin,
                        product_id: _newData[index].id,
                        product_desc: _newData[index].productDescription,
                        productPicture: _newData[index].productPicture,
                        listprice: _newData[index].listPrice,
                        show_price: price_status.toString(),
                        newFlag: _newData[index].newFlag,
                        updateFlag: _newData[index].updateFlag,
                      ),
                      SizedBox(
                        height: 0,
                      )
                    ],
                  );
                }),
          )
        : RefreshIndicator(
            key: _refreshIndicatorKey,
            // ignore: missing_return
            onRefresh: () {
              //masterdata_bloc.fetchAllMasterData();
              return masterdata_bloc.fetchAllMasterdatafromDBV2();
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      MasterDataWidget(
                        height: hp(100),
                        width: wp(100),
                        product_desc: data[index].productDescription,
                        gtin: data[index].gtin,
                        product_id: data[index].id,
                        productPicture: data[index].productPicture,
                        listprice: data[index].listPrice,
                        show_price: price_status.toString(),
                        newFlag: data[index].newFlag,
                        updateFlag: data[index].updateFlag,
                      ),
                      SizedBox(
                        height: 0,
                      )
                    ],
                  );
                }),
          );
  }
}
