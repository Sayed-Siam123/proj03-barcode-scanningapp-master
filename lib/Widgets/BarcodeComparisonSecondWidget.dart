import 'dart:async';

import 'package:app/Model/masterdata_model.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';

class BarcodeComparisonSecondWidget extends StatefulWidget {
  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  final String mastercode, digits, type;

  BarcodeComparisonSecondWidget(
      {this.height,
      this.width,
      this.scaffoldKey,
      this.mastercode,
      this.type,
      this.digits});

  @override
  _BarcodeComparisonSecondWidgetState createState() =>
      _BarcodeComparisonSecondWidgetState();
}

class _BarcodeComparisonSecondWidgetState
    extends State<BarcodeComparisonSecondWidget> {
  final secondBarcode = new TextEditingController();

  ScanResult barcode1;
  ResultType barcode1_r;
  ScanResult barcode2;

  String barcode_type = "";
  String barcode_digits = "";

  String mastercode;
  String barcode;

  bool status = null;

  String _quantityKey = "_quantityKey";
  var _quantity = 0;
  var _quantityFound = 0;

  String activation;
  String _activateKey = "_bar_com_activateKey";
  String refernece = "null";
  String _referenceCodeKey = "_referneceCode";

  SnackbarHelper snack = new SnackbarHelper();
  SessionManager prefs = new SessionManager();

  List<MasterDataModelV2> fetcheddata = [];
  List<MasterDataModelV2> _newData = [];
  List<MasterDataModelV2> _newData2 = [];

  bool status1 = false;
  bool status2 = false;

  void getQuantity() async {
    Future<String> quantity = prefs.getData(_quantityKey);
    quantity.then((data) async {
      print(data);
      setState(() {
        if (data != null) _quantity = int.parse(data);
      });
    }, onError: (e) {
      print(e);
    });
  }

  void getReference() async {
    Future<bool> referenceActivation = prefs.getBoolData(_referenceCodeKey);
    referenceActivation.then((data) async {
      print("reference activation " + data.toString());
      setState(() {
        if (data != null) refernece = data.toString();
      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(), () {
      getReference();
      getQuantity();
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(hp(15), hp(0), hp(0), hp(1)),
              child: Column(
                children: [
                  refernece == "true"
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(0, hp(2), 0, hp(10)),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: wp(20),
                              color: Colors.transparent,
                              child: Center(
                                  child: Text('$_quantityFound/$_quantity',
                                      style: TextStyle(
                                        fontSize: hp(4),
                                      ))),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(0, hp(2), 0, hp(10)),
                          child: Text(""),
                        ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mastercode",
                        style: TextStyle(
                          fontSize: hp(3.7),
                        ),
                      ),
                      SizedBox(
                        width: wp(5),
                      ),
                      Text(
                        widget.mastercode,
                        style: TextStyle(
                          fontSize: hp(3.7),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: hp(3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.type,
                        style: TextStyle(
                          fontSize: hp(3.7),
                        ),
                      ),
                      SizedBox(
                        width: wp(40),
                      ),
                      Text(
                        widget.digits == "No data"
                            ? widget.digits
                            : widget.digits + " Digits",
                        style: TextStyle(
                          fontSize: hp(3.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: hp(1),
            ),
            Divider(),
            Column(
              children: [
                SizedBox(
                  height: wp(3),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: wp(5),
                    ),
                    refernece == "null" || refernece == "false"
                        ? Text("Scan barcode")
                        : Text("Reference Barcode"),
                    SizedBox(
                      width: wp(5),
                    ),
                    Container(
                      width: wp(55),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 0, left: 0, right: 0),
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
                              icon: new Image.asset('assets/images/barcode.png',
                                  fit: BoxFit.contain),
                              tooltip: 'Scan barcode',
                              onPressed: () => refernece == "true"
                                  ? barcodeScanning2_Mode1()
                                  : barcodeScanning2_mode2(),
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
                          onChanged: (String text) {
                            refernece == "true"
                                ? onChangeBarcode_Mode2(text)
                                : onChangeBarcode_Mode1(text);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(hp(15), hp(5), hp(0), hp(1)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        barcode_type == "" ? "No Data" : barcode_type,
                        style: TextStyle(
                          fontSize: hp(3.7),
                        ),
                      ),
                      SizedBox(
                        width: wp(40),
                      ),
                      Text(
                        barcode_digits == ""
                            ? "No data"
                            : barcode_digits + " Digits",
                        style: TextStyle(
                          fontSize: hp(3.7),
                        ),
                      ),
                    ],
                  ),
                ),

                status == true
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: hp(30), bottom: hp(1), left: wp(1.5)),
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
                                        border: Border.all(width: wp(.6)),
                                        shape: BoxShape.circle),
                                    child: Center(
                                        child: Text(
                                      "OK",
                                      style: TextStyle(fontSize: 30),
                                    )),
                                  )),
                            ],
                          ),
                        ),
                      )
                    : status == false
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: hp(30), bottom: hp(1), left: wp(1.5)),
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
                                            border: Border.all(width: wp(.6)),
                                            shape: BoxShape.circle),
                                        child: Center(
                                            child: Text(
                                          "FAIL",
                                          style: TextStyle(fontSize: 30),
                                        )),
                                      )),
                                ],
                              ),
                            ),
                          )
                        : Text(""),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future barcodeScanning2_Mode1() async {
    if ((_quantity == 0 || _quantity == null) && refernece != "null") {
      snack.snackbarshowAction2(
          context, "Set the quantity first!", 2, Colors.black87);
    } else {
      try {
        barcode2 = await BarcodeScanner.scan();
        print(barcode2);

        setState(() {
          //status2 = false;
          this.barcode2 = barcode2;
          barcode_type = barcode2.format.toString();
          barcode_digits = barcode2.rawContent.length.toString();
          secondBarcode.text = barcode2.rawContent.toString();
        });
        onChangeBarcode_Mode2(barcode2.rawContent.toString());
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
  }

  void onChangeBarcode_Mode1(String text) {
    print(text);

    if (text != widget.mastercode.toString()) {
      print("not got it");
      setState(() {
        status = false;
      });
      //snack.snackbarshowNormal(context, "No matched product found!", 1, Colors.black87);
    } else if (text == widget.mastercode.toString()) {
      print("got it");

      setState(() {
        status = true;
      });

      // if(_quantityFound == _quantity){
      //   snack.snackbarshowNormal(context, "Matching done with all of $_quantity items !", 1, Colors.black87);
      // }
      //
      // else{
      //   setState(() {
      //     _quantityFound++;
      //     status = true;
      //   });
      //   snack.snackbarshowNormal(context, "Product matched!", 1, Colors.black87);
      // }
    }
  }

  Future barcodeScanning2_mode2() async {
    try {
      barcode2 = await BarcodeScanner.scan();
      print(barcode2);

      setState(() {
        //status2 = false;
        this.barcode2 = barcode2;
        barcode_type = barcode2.format.toString();
        barcode_digits = barcode2.rawContent.length.toString();
        secondBarcode.text = barcode2.rawContent.toString();
      });
      onChangeBarcode_Mode2(barcode2.rawContent.toString());
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

  void onChangeBarcode_Mode2(String text) {
    print(text);

    if (text != widget.mastercode.toString()) {
      print("not got it");
      setState(() {
        status = false;
      });
      //snack.snackbarshowNormal(context, "No matched product found!", 1, Colors.black87);
    } else if (text == widget.mastercode.toString()) {
      if (_quantityFound == _quantity) {
        //snack.snackbarshowNormal(context,"Matching done with all of $_quantity items !", 1, Colors.black87);
      } else {
        setState(() {
          _quantityFound++;
          status = true;
        });
        //snack.snackbarshowNormal(context, "Product matched!", 1, Colors.black87);
      }
    }
  }
}
