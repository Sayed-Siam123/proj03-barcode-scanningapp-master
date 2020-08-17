import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/AddProduct.dart';
import 'package:app/UI/Home.dart';
import 'package:app/Widgets/MastarDataDrawer.dart';
import 'package:app/Widgets/MastarDataWidget.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

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

  List<MasterDataModel> _newData = [];
  List<MasterDataModel> fetcheddata = [];

  //Barcode scan implement
  ScanResult barcode;

  //String _scanBarcode = 'Unknown';

  @override
  initState() {
    masterdata_bloc.fetchAllMasterData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage())),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: new MasterDataDrawer(),
        appBar: AppBar(
          leading: _isSearching
              ? const BackButton()
              : new IconButton(
                  icon: new Icon(
                    Icons.menu,
                    color: Colors.black45,
                  ),
                  color: Colors.black54,
                  onPressed: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => HomePage())
//                );

                    _scaffoldKey.currentState.openDrawer();
                  }),
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: StreamBuilder<List<MasterDataModel>>(
            stream: masterdata_bloc.allMasterData,
            builder: (context, AsyncSnapshot<List<MasterDataModel>> snapshot) {
              if (snapshot.hasData) {
                fetcheddata = snapshot.data;
                //_newData = fetcheddata;
                print("Data gula:: ");

                //TODO::eikhan theke kaj shuru hbe ashar por
                //TODO::fetched data new datay copy hoise
                //TODO::normally ja fetch hoye ashbe oitai new data list e dhuke jabe
                //TODO::filter amake oi newlist theke kora lagbe search korar jonne

                print(fetcheddata.length);
                return masterdataview(fetcheddata);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("jabs");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProductPage()));
            // Add your onPressed code here!
          },
          child: Icon(
            Icons.add,
            size: 50,
          ),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  //Search widget
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: GoogleFonts.exo2(
      textStyle: TextStyle(
      fontSize: 20,
        color: Colors.black38
      ),
    ),
      ),
      style: GoogleFonts.exo2(
    textStyle: TextStyle(
    fontSize: 16,
    color: Colors.black
    ),),
      onChanged: onSearchTextChanged,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.black45,
          ),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
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
      IconButton(
        icon: new Image.asset('assets/images/barcode.png', fit: BoxFit.contain),
        tooltip: 'Scan barcode',
        onPressed: barcodeScanning,
      ),
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
      if (userDetail.categoryName.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.gtin.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.productName.toLowerCase().contains(text.toLowerCase()))
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
    return Text(
      "Master data",
      style: GoogleFonts.exo2(
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.black
    ),)
    );
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

  Widget masterdataview(data) {
    return _newData.length != 0 || _searchQueryController.text.isNotEmpty
        ? RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () {
              return masterdata_bloc.fetchAllMasterData();
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: _newData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      MasterDataWidget(
                        gtin: _newData[index].gtin,
                        product_name: _newData[index].productName,
                        category: _newData[index].categoryName,
                        product_id: _newData[index].id,
                        productPicture: _newData[index].productPicture,
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
            onRefresh: () {
              return masterdata_bloc.fetchAllMasterData();
            },
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      MasterDataWidget(
                        gtin: data[index].gtin,
                        product_name: data[index].productName,
                        category: data[index].categoryName,
                        product_id: data[index].id,
                        productPicture: data[index].productPicture,
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
