import 'dart:async';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/Home.dart';
import 'package:app/Widgets/LevelPrintingSettings.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:barcode_scan/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:responsive_screen/responsive_screen.dart';

class LevelPrintingPage extends StatefulWidget {
  @override
  _LevelPrintingPageState createState() => _LevelPrintingPageState();
}

class _LevelPrintingPageState extends State<LevelPrintingPage> {
  final barcode = new TextEditingController();
  var barcode1;
  List<MasterDataModelV2> fetcheddata = [];
  List<MasterDataModelV2> _newData = [];

  SnackbarHelper snack = new SnackbarHelper();

  bool status = false;

  int counter = 1;
  String barcode_c, desc, price;

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
    final orientation = MediaQuery.of(context).orientation;

    dynamic size = MediaQuery.of(context).size;
    dynamic deviceRatio = size.width / size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Level Printing",
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LevelPrintingSettingsPage()));
              },
              icon: Icon(
                Icons.settings,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        floatingActionButton: status == true
            ? FloatingActionButton(
                onPressed: () {
                  _printDocument();
                },
                child: Icon(FontAwesome.print),
                backgroundColor: Colors.green.shade500,
              )
            : SizedBox(
                width: 0,
                height: 0,
              ),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(wp(3)),
              padding: EdgeInsets.all(wp(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<List<MasterDataModelV2>>(
                    stream: masterdata_bloc.allMasterDataV2,
                    builder: (context,
                        AsyncSnapshot<List<MasterDataModelV2>> snapshot) {
                      if (snapshot.hasData) {
                        fetcheddata = snapshot.data;
                        //_newData = fetcheddata;
                        print("From Level Printing page");
                        print(fetcheddata.length);
                        //return masterdataview(hp(100),wp(100),fetcheddata);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return Center(child: Text(""));
                    },
                  ),
                  Text(
                    "Barcode",
                    style: TextStyle(
                      fontSize: hp(2),
                    ),
                  ),
                  SizedBox(
                    height: hp(1),
                  ),
                  Builder(
                    builder: (context) => Container(
                      width: wp(90),
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
                                onPressed: () {
                                  setState(() {
                                    status = false;
                                  });
                                  barcodeScanning1(context);
                                }),
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
                          onChanged: (String text) {
                            setState(() {
                              status = false;
                            });
                            onsearchedBarcode(text, context);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hp(1),
                  ),
                  Divider(),
                  SizedBox(
                    height: hp(1),
                  ),
                  status == true
                      ? Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                    Text(
                                      "Price",
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: hp(3),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      desc.toString(),
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                    Text(
                                      price.toString(),
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: hp(1),
                            ),
                            Divider(),
                            SizedBox(
                              height: hp(1),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Relation",
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                    Text(
                                      "Barcode 1",
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                    Text(
                                      "Barcode 2",
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: hp(3),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Direct (1:1)",
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                    Text(
                                      barcode_c.toString(),
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                    Text(
                                      barcode_c.toString(),
                                      style: TextStyle(
                                        fontSize: hp(2),
                                      ),
                                    ),
                                    SizedBox(
                                      height: hp(1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: hp(1),
                            ),
                            Divider(),
                            SizedBox(
                              height: hp(1),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Quantity to print",
                                  style: TextStyle(
                                    fontSize: hp(2),
                                  ),
                                ),
                                SizedBox(
                                  width: hp(1),
                                ),
                                Container(
                                  width: wp(40),
                                  color: Colors.transparent,
                                  margin: EdgeInsets.fromLTRB(0, 0, wp(0), 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (counter > 1) {
                                              counter--;
                                            }
                                          });
                                        },
                                        child: Container(
                                            height: wp(10),
                                            width: wp(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade300
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 5,
                                                )
                                              ],
                                            ),
                                            child: Icon(
                                              AntDesign.minus,
                                              size: wp(5),
                                            )),
                                      ),
                                      SizedBox(
                                        width: hp(2.5),
                                      ),
                                      Text(
                                        counter.toString(),
                                        style: TextStyle(fontSize: hp(2)),
                                      ),
                                      SizedBox(
                                        width: hp(2.5),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            counter++;
                                          });
                                          print(fetcheddata[0].gtin.toString());
                                        },
                                        child: Container(
                                          height: wp(10),
                                          width: wp(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade300
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 5,
                                              )
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            size: wp(5),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
                ],
              ),
            ),
          ),
        ));
  }

  Future barcodeScanning1(BuildContext context) async {
    try {
      barcode1 = await BarcodeScanner.scan();
      setState(() {
        //status1 = false;
        this.barcode1 = barcode1;
        barcode.text = barcode1.rawContent.toString();
      });
      onsearchedBarcode(barcode1.rawContent.toString(), context);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode1 = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode1 = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode1 = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode1 = 'Unknown error: $e');
    }
  }

  void onsearchedBarcode(String text, BuildContext context) {
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
    Timer(Duration(milliseconds: 50), () {
      checkData(context);
    });
  }

  void checkData(BuildContext context) {
    if (_newData.isEmpty || barcode.text != _newData[0].gtin.toString()) {
      print("not got it");
      snack.snackbarshowNormal(context, "No product found!", 1, Colors.black87);
    } else if (_newData.isNotEmpty &&
        barcode.text == _newData[0].gtin.toString()) {
      print("got it");
      snack.snackbarshowNormal(context, "Product found!", 3, Colors.black87);
      Timer(Duration(seconds: 1), () {
        setState(() {
          status = true;
          barcode_c = _newData[0].gtin.toString();
          desc = _newData[0].productDescription.toString();
          price = _newData[0].listPrice.toString();
        });
      });
      // masterdata_bloc.getId(_newData[0].id.toString());
      // masterdata_bloc.getsinglemasterdatafromDBV2();
    }
  }

  void _printDocument() async {

    Printing.layoutPdf(
      onLayout: (pageFormat) async {

        final doc = pw.Document();
        final PdfImage assetImage = await pdfImageFromImageProvider(
          pdf: doc.document,
          image: const AssetImage('assets/images/logo.png'),
        );

        doc.addPage(
          pw.Page(
              pageFormat: PdfPageFormat.a5,
              build: (pw.Context context) =>
                  // pw.Center(
                  // child: pw.Container(
                  //   height: hp(30),
                  //   width: wp(70),
                  //   decoration: pw.BoxDecoration(
                  //       shape: pw.BoxShape.rectangle,
                  //       border: pw.BoxBorder(
                  //         color: PdfColor.fromHex("#000000"),
                  //         top: true,
                  //         bottom: true,
                  //         left: true,
                  //         right: true,
                  //       )),
                  //   child: pw.Column(
                  //       mainAxisAlignment: pw.MainAxisAlignment.start,
                  //       children: <pw.Widget>[
                  //         pw.Align(
                  //             alignment: pw.Alignment.center,
                  //             child: pw.Container(
                  //                 child: pw.BarcodeWidget(
                  //                   height: 70,
                  //                   width: 170,
                  //                   data: barcode_c == null? "0": barcode_c,
                  //                   barcode: pw.Barcode.qrCode(),
                  //                 ))),
                  //         pw.SizedBox(height: 10),
                  //         pw.Align(
                  //             child: pw.Row(
                  //                 mainAxisAlignment: pw.MainAxisAlignment.center,
                  //                 children: <pw.Widget>[
                  //                   pw.Column(
                  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //                       mainAxisAlignment:
                  //                       pw.MainAxisAlignment.spaceEvenly,
                  //                       children: <pw.Widget>[
                  //                         pw.Text("Date",
                  //                             style: pw.TextStyle(
                  //                               font: pw.Font.helveticaBold(),
                  //                               fontSize: 15,
                  //                             )),
                  //                         pw.Text("Store",
                  //                             style: pw.TextStyle(
                  //                               font: pw.Font.helveticaBold(),
                  //                               fontSize: 15,
                  //                             )),
                  //                         pw.Text("POS/QTY",
                  //                             style: pw.TextStyle(
                  //                               font: pw.Font.helveticaBold(),
                  //                               fontSize: 15,
                  //                             )),
                  //                       ]),
                  //                   pw.SizedBox(width: 30),
                  //                   pw.Column(
                  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
                  //                       mainAxisAlignment:
                  //                       pw.MainAxisAlignment.spaceEvenly,
                  //                       children: <pw.Widget>[
                  //                         pw.Text(barcode_c.toString(),
                  //                             style: pw.TextStyle(
                  //                               font: pw.Font.helveticaBold(),
                  //                               fontSize: 15,
                  //                             )),
                  //                         pw.Text("Store 1",
                  //                             style: pw.TextStyle(
                  //                               font: pw.Font.helveticaBold(),
                  //                               fontSize: 15,
                  //                             )),
                  //                       ]),
                  //                 ]))
                  //       ]),
                  // )),

                  pw.Center(
                    child: pw.Container(
                        height: 200,
                        width: 500,
                        decoration: pw.BoxDecoration(
                            shape: pw.BoxShape.rectangle,
                            border: pw.BoxBorder(
                              color: PdfColor.fromHex("#000000"),
                              top: true,
                              bottom: true,
                              left: true,
                              right: true,
                            )),
                        child: pw.Column(children: [
                          pw.Image(assetImage,
                              width: 280, height: 55, fit: pw.BoxFit.fill),
                          pw.Divider(),
                          pw.Padding(
                            padding: pw.EdgeInsets.only(top: 10,left: 20),
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(desc.toString(),style: pw.TextStyle(
                                          fontSize: 20,
                                        )),
                                        pw.Text(price.toString(),style: pw.TextStyle(
                                          fontSize: 16,
                                        )),
                                      ]
                                  ),
                                  pw.BarcodeWidget(
                                    height: 70,
                                    width: 170,
                                    data: barcode_c == null ? "0" : barcode_c,
                                    barcode: pw.Barcode.qrCode(),
                                  ),
                                ]),
                          )
                        ])),
                  )),
        );

        return doc.save();
      },
    );
  }
}
