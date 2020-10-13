import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';

class DataAcquisition_barcodeAddWidget extends StatefulWidget {


  dynamic height;
  dynamic width;
  String file_name;
  bool status;
  GlobalKey<ScaffoldState> scaffoldKey;

  DataAcquisition_barcodeAddWidget({this.height, this.width, this.scaffoldKey,this.file_name,this.status});

  @override
  _DataAcquisition_barcodeAddWidgetState createState() => _DataAcquisition_barcodeAddWidgetState();
}

class _DataAcquisition_barcodeAddWidgetState extends State<DataAcquisition_barcodeAddWidget> {

  ScanResult barcode2;

  final gtin = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: wp(0),top: hp(2),bottom: wp(1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("File Name",style: TextStyle(
                              fontSize: hp(2.5),
                            ),),
                            SizedBox(width: wp(5),),
                            Text(widget.file_name.toString(),style: TextStyle(
                              fontSize: hp(2.5),
                              color: Colors.green.shade500
                            ),),

                          ],
                        ),

                        SizedBox(width: wp(7),),
                        Container(
                          height: hp(6),
                          width: hp(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.4),
                                blurRadius: 5,
                                spreadRadius: 5,
                              )
                            ]
                          ),
                          child: Center(
                            child: Text("0",style: TextStyle(
                              fontSize: hp(2.5),
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: wp(3),top: hp(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Scan Barcode",style: TextStyle(
                          fontSize: hp(2),
                        ),),
                        Container(
                          margin: EdgeInsets.fromLTRB(wp(0), hp(1), wp(0), hp(1)),
                          padding: EdgeInsets.fromLTRB(wp(3), hp(0), wp(1), 0),
                          width: wp(90),
                          height: hp(6.5),
                          alignment: Alignment.center,
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
                            padding: EdgeInsets.only(left: 0.0, top: hp(0)),
                            child: TextField(
                                autocorrect: true,
                                style: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                controller: gtin,
                                decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 0.0, top: hp(2.2)),
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
                                  hintText: "Enter or Scan barcode",
                                  suffixIcon: IconButton(
                                    icon: new Image.asset(
                                        'assets/images/barcode.png',
                                        fit: BoxFit.contain),
                                    tooltip: 'Scan barcode',
                                    onPressed: barcodeScanning2,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: hp(.7),),
                  Divider(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left:wp(3),top: hp(1)),
                        child: Text("Last Scanned Item",style: TextStyle(
                          fontSize: hp(2),
                        ),),
                      ),
                      SizedBox(height: hp(1),),
                      Padding(
                        padding: EdgeInsets.fromLTRB(wp(2),0,wp(2),0),
                        child: Card(
                          child: ListTile(
                            title: Text("Barcode 4"),
                            subtitle: Text("1212121"),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: hp(.8),),
                  Divider(),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left:wp(3),top: hp(1)),
                        child: Text("Item List",style: TextStyle(
                          fontSize: hp(2),
                        ),),
                      ),
                      SizedBox(height: hp(1),),
                      Padding(
                        padding: EdgeInsets.fromLTRB(wp(2),0,wp(2),0),
                        child: Card(
                          child: ListTile(
                            title: Text("Barcode 4"),
                            subtitle: Text("1212121"),
                          ),
                        ),
                      ),

                      SizedBox(height: hp(1),),
                      Padding(
                        padding: EdgeInsets.fromLTRB(wp(2),0,wp(2),0),
                        child: Card(
                          child: ListTile(
                            title: Text("Barcode 3"),
                            subtitle: Text("1212121"),
                          ),
                        ),
                      ),

                      SizedBox(height: hp(1),),
                      Padding(
                        padding: EdgeInsets.fromLTRB(wp(2),0,wp(2),0),
                        child: Card(
                          child: ListTile(
                            title: Text("Barcode 2"),
                            subtitle: Text("1212121"),
                          ),
                        ),
                      ),

                      SizedBox(height: hp(1),),
                      Padding(
                        padding: EdgeInsets.fromLTRB(wp(2),0,wp(2),0),
                        child: Card(
                          child: ListTile(
                            title: Text("Barcode 1"),
                            subtitle: Text("1212121"),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future barcodeScanning2() async {
    try {
      barcode2 = await BarcodeScanner.scan();
      print(barcode2);
      setState(() {
        this.barcode2 = barcode2;
        gtin.text = barcode2.rawContent.toString();
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
}
