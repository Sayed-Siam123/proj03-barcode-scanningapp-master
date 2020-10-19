import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/MasterData.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:pdf/widgets.dart';
import 'package:responsive_screen/responsive_screen.dart';

class BarcodeComparisonWidget extends StatefulWidget {

  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  BarcodeComparisonWidget({this.height,this.width,this.scaffoldKey});

  @override
  _BarcodeComparisonWidgetState createState() => _BarcodeComparisonWidgetState();
}

class _BarcodeComparisonWidgetState extends State<BarcodeComparisonWidget> {

  final masterBarcode = new TextEditingController();
  final secondBarcode = new TextEditingController();


  ScanResult barcode1;
  ScanResult barcode2;

  String mastercode;
  String barcode;

  bool status = null;



  List<MasterDataModelV2> fetcheddata= [];
  List<MasterDataModelV2> _newData= [];
  List<MasterDataModelV2> _newData2= [];

  bool status1 = false;
  bool status2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    masterdata_bloc.fetchAllMasterdatafromDBV2();
  }


  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(hp(3)),
          child: Container(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[

                StreamBuilder<List<MasterDataModelV2>>(
                  stream: masterdata_bloc.allMasterDataV2,
                  builder: (context, AsyncSnapshot<List<MasterDataModelV2>> snapshot) {
                    if (snapshot.hasData) {
                      fetcheddata = snapshot.data;
                      //_newData = fetcheddata;
                      print("From barcode comparison page");
                      print(fetcheddata.length);
                      //return masterdataview(hp(100),wp(100),fetcheddata);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    return Center(child: Text(""));
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(top: hp(6), bottom: hp(1)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "Mastercode",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wp(4),
                        ),
                        Container(
                          width: wp(70),
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
                                controller: masterBarcode,
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
                                    onPressed: barcodeScanning1,
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
                                  hintText: "Enter Mastercode",
                                ),
                              onChanged: (String text){
                                onChangeMastercode(text);
                              },

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: hp(22), bottom: hp(1),left: wp(1)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "Code type",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wp(9),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: status1 == false ? Text(
                            "No Data",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ): Text(
                            _newData[0].gtin.toString(),
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: hp(30), bottom: hp(1),left: wp(1.5)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "Digits",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wp(14),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "No Data",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: hp(40)),
                  child: Divider(),
                ),

                Padding(
                  padding: EdgeInsets.only(top: hp(48), bottom: hp(1)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "Scan Barcode",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wp(2),
                        ),
                        Container(
                          width: wp(70),
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
                                controller: secondBarcode,
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
                                    onPressed: barcodeScanning2,
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
                                  hintText: "Enter Barcode",
                                ),
                              onChanged: (String text){
                                onChangeBarcode(text);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: hp(64), bottom: hp(1),left: wp(1)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "Code type",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wp(9),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: status2 == false ? Text(
                            "No Data",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ):Text(
                            _newData2[0].gtin.toString(),
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: hp(72), bottom: hp(1),left: wp(1.5)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "Digits",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: wp(14),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Text(
                            "No Data",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                status == true ? Padding(
                  padding: EdgeInsets.only(top: hp(90), bottom: hp(1),left: wp(1.5)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: hp(3)),
                          child: Container(
                            height: hp(27),
                            width: wp(40),
                            decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              border: Border.all(
                                width: wp(.6)
                              ),
                              shape: BoxShape.circle
                            ),
                            child: Center(child: Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 30
                              ),
                            )),
                          )
                        ),
                      ],
                    ),
                  ),
                ): status == false ? Padding(
                  padding: EdgeInsets.only(top: hp(90), bottom: hp(1),left: wp(1.5)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: hp(3)),
                            child: Container(
                              height: hp(27),
                              width: wp(40),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                      width: wp(.6)
                                  ),
                                  shape: BoxShape.circle
                              ),
                              child: Center(child: Text(
                                "FAIL",
                                style: TextStyle(
                                    fontSize: 30
                                ),
                              )),
                            )
                        ),
                      ],
                    ),
                  ),
                ): Text(""),

              ],
            )
          ),
        ),
    );
  }

  Future barcodeScanning1() async {
    try {
      barcode1 = await BarcodeScanner.scan();
      print(barcode1);
      setState(() {
        //status1 = false;
        this.barcode1 = barcode1;
        masterBarcode.text = barcode1.rawContent.toString();
      });
      onChangeMastercode(barcode1.rawContent.toString());
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode1 = 'No camera permission!' as ScanResult;
        });
      } else {
        setState(() => this.barcode1 = 'Unknown error: $e' as ScanResult);
      }
    } on FormatException {
      setState(() => this.barcode1 = 'Nothing captured.' as ScanResult);
    } catch (e) {
      setState(() => this.barcode1 = 'Unknown error: $e' as ScanResult);
    }
  }

  Future barcodeScanning2() async {
    try {
      barcode2 = await BarcodeScanner.scan();
      print(barcode2);
      setState(() {
        //status2 = false;
        this.barcode2 = barcode2;
        secondBarcode.text = barcode2.rawContent.toString();
      });
      onChangeBarcode(barcode2.rawContent.toString());
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

  void onChangeMastercode(String text){
    print(text);
    // setState(() {
    //   mastercode = text.toString();
    // });

    _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.id.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail);
    });


    setState(() {
      status1 = true;
    });


  }

  void onChangeBarcode(String text){
    print(text);

    // _newData2.clear();
    // if (text.isEmpty) {
    //   setState(() {});
    //   return;
    // }
    //
    // fetcheddata.forEach((userDetail) {
    //   if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()) ||
    //       userDetail.id.toLowerCase().contains(text.toLowerCase()))
    //     _newData2.add(userDetail);
    // });
    //
    //   setState(() {
    //     status2 = true;
    //   });


      if(int.parse(_newData[0].gtin.toString()) == int.parse(text)){
        print("same");
        setState(() {
          status = true;
        });
      }

      else{
        print("diff");
        setState(() {
          status = false;
        });
      }
    }
  }
