import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/Widgets/MastarDataWidget.dart';
import 'package:app/Widgets/SystemSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'Details.dart';
import 'Home.dart';
import 'package:barcode_scan/barcode_scan.dart';

class BarcodeInfo extends StatefulWidget {
  @override
  _BarcodeInfoState createState() => _BarcodeInfoState();
}

class _BarcodeInfoState extends State<BarcodeInfo> {
  SessionManager prefs = SessionManager();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  String cameraStatus;
  String _cameraKey = "_camera";
  List<MasterDataModel> _newData = [];
  List<MasterDataModel> _fetcheddata = [];

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
    getCamera();
    masterdata_bloc.fetchAllMasterdatafromDB();
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
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: StreamBuilder<List<MasterDataModel>>(
            stream: masterdata_bloc.allMasterData,
            builder: (context, AsyncSnapshot<List<MasterDataModel>> snapshot) {
              if (snapshot.hasData) {
                _fetcheddata = snapshot.data;
                //_newData = fetcheddata;
                print("Data gula:: ");

                print(_fetcheddata.length);
                return masterdataview(_fetcheddata,context);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(child: CircularProgressIndicator());
              //return masterdataview(_fetcheddata); //it should be changed
            },
          ),
        ),
      ),
    );
  }

  Widget masterdataview(fetcheddata,BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0,top: 5),
              child: Text("Search",style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).accentColor
                ),
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5,left: 15.0),
              child: Text("Search anything within the data,you may search by product id, Manufacturer PN, GTIN etc.",style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 15,
                    color: Theme.of(context).accentColor
                ),
              ),),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 58,
                  width: MediaQuery.of(context).size.width-87,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 30, left: 13, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
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
                            onPressed: () {  },
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
                          hintText: "Enter GTIN or Scan To Search",
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 55,
                      width: 55,
                      child: Container(
                        child: IconButton(
                          icon: new Image.asset('assets/images/qr-code.png',
                            fit: BoxFit.contain,
                            color:Colors.white,
                          ),
                          tooltip: 'Scan barcode',
                          onPressed: () {
                            if(cameraStatus=="true"){
                              barcodeScanning();
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



            Container(
              margin: EdgeInsets.only(top: 12),
              height: 700,
              width: double.infinity,
              color: Theme.of(context).backgroundColor,
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
                          height: 6,
                        )
                      ],
                    );
                  }),
            ),
          ],
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

    if(_newData[0].gtin.toString()==_searchQueryController.text)
      {

        //print(_newData[0].id.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsPage(product_name: _newData[0].productName.toString())));
        masterdata_bloc.getId(_newData[0].id.toString());
        masterdata_bloc.getsinglemasterdata();
    }

    else if(_newData[0].gtin.toString()==barcode.rawContent.toString()){
        print("Barcode paisi");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsPage(product_name: _newData[0].productName.toString())));
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
}
