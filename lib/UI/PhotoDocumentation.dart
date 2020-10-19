import 'dart:async';
import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/PhotoDocumentationDetails.dart';
import 'package:app/Widgets/PhotoDocumentationSettings.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';

class PhotoDocumentationPage extends StatefulWidget {
  @override
  _PhotoDocumentationPageState createState() => _PhotoDocumentationPageState();
}

class _PhotoDocumentationPageState extends State<PhotoDocumentationPage> {

  final barcode = new TextEditingController();
  var barcode1;
  List<MasterDataModelV2> fetcheddata = [];
  List<MasterDataModelV2> _newData = [];

  SnackbarHelper snack = new SnackbarHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    masterdata_bloc.fetchAllMasterdatafromDBV2();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    masterdata_bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Photo Documentation",
          style: new TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PhotoDocumetationSettings()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(hp(2),hp(4),hp(2),hp(2)),
          width: hp(100),
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              StreamBuilder<List<MasterDataModelV2>>(
                stream: masterdata_bloc.allMasterDataV2,
                builder: (context, AsyncSnapshot<List<MasterDataModelV2>> snapshot) {
                  if (snapshot.hasData) {
                    fetcheddata = snapshot.data;
                    //_newData = fetcheddata;
                    print("From photo documentation page");
                    print(fetcheddata.length);
                    //return masterdataview(hp(100),wp(100),fetcheddata);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(child: Text(""));
                },
              ),


              Text("Barcode",style: TextStyle(
                fontSize: hp(2),
              ),),
              SizedBox(height: hp(1),),
              Builder(
                builder: (context) => Container(
                  width: wp(90),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 0, left: 0, right: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 3),
                    child: TextField(
                      controller: barcode,
                      autocorrect: true,
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          icon: new Image.asset(
                              'assets/images/barcode.png',
                              fit: BoxFit.contain),
                          tooltip: 'Scan barcode',
                          onPressed:() => barcodeScanning1(context),
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintStyle: GoogleFonts.exo2(
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        labelStyle: GoogleFonts.exo2(
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        hintText: "Enter Barcode or scan",
                      ),
                      onChanged: (String text){
                        onsearchedBarcode(text,context);
                      },
                    ),
                  ),
                ),
              ),


              Container(
                margin: EdgeInsets.fromLTRB(hp(0),hp(4),hp(0),hp(2)),
                width: wp(100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Search Result",style: TextStyle(
                      fontSize: hp(2),
                    ),),
                    SizedBox(height: hp(6)),
                    Center(child: Text("No data")),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future barcodeScanning1(BuildContext context) async {
    try {
      barcode1 = await BarcodeScanner.scan();
      setState(() {
        //status1 = false;
        this.barcode1 = barcode1;
        barcode.text = barcode1.rawContent.toString();
      });
      onsearchedBarcode(barcode1.rawContent.toString(),context);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode1 = 'No camera permission!' ;
        });
      } else {
        setState(() => this.barcode1 = 'Unknown error: $e' );
      }
    } on FormatException {
      setState(() => this.barcode1 = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode1 = 'Unknown error: $e');
    }
  }

  void onsearchedBarcode(String text,BuildContext context){
    print(text);

    //print(fetcheddata[0].gtin.toString());

     _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail);
    });


    //print("Saved gtin: "+ _newData[0].gtin.toString());
    Timer(Duration(milliseconds: 50),(){
      checkData(context);
    });

  }

  void checkData(BuildContext context){
    if(_newData.isEmpty){
      print("not got it");
      snack.snackbarshowNormal(context, "No product found!", 3, Colors.black87);
    }
    else if(_newData.isNotEmpty && barcode.text == _newData[0].gtin.toString()){
      print("got it");
      snack.snackbarshowNormal(context, "Product found!", 3, Colors.black87);
      Timer(Duration(seconds: 2),(){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PhotoDocumentationDetailsPage()));
      });
      masterdata_bloc.getId(_newData[0].id.toString());
      masterdata_bloc.getsinglemasterdatafromDBV2();
    }
  }

}
