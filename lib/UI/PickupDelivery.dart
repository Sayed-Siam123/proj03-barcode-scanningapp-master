import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Resources/database_helper.dart';
import 'package:app/UI/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


class PickupDelivery extends StatefulWidget {
  @override
  _PickupDeliveryState createState() => _PickupDeliveryState();
}

class _PickupDeliveryState extends State<PickupDelivery> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  ScanResult barcode2;
  var qrText = "";
  var controller;
  bool qr_request = false;

  TextEditingController _searchQueryController = new TextEditingController();

  List<String> product_names = <String>[];

  List<String> barcode = <String>[];

  List<PickupDeliveryModel> products = [];

  List<String> result1 = [];
  List<String> result2 = [];

  DatabaseHelper helper = DatabaseHelper();

  PickupDeliveryModel newdelivery;
  PickupDeliveryModel product;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<PickupDeliveryModel> deliveryList;
  int count = 0;

  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  //Toaster toast;

  final _resetKey1 = GlobalKey<FormState>();
  final _resetKey2 = GlobalKey<FormState>();
  bool _resetValidate1 = false;
  bool _resetValidate2 = false;

  bool _validate1;
  bool _validate2;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";

  final DismissDirection _dismissDirection = DismissDirection.horizontal;


  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        _searchQueryController.text = qrText;

//        ndelivery_bloc.getselecteditemProductName("ProductsNameHere");
//        ndelivery_bloc.getselecteditemBarcode(_searchQueryController.text.toString());
//        ndelivery_bloc.getselecteditemQuantity(1);

//        newdelivery = NewDeliveryModel(
//          barcode_: _searchQueryController.text.toString(),
//          product_name_: "Product",
//          quantity_: 1,
//        );
//      });

//      newdelivery.productName = qrText;
//      newdelivery.Barcode = qrText;
//      newdelivery.Quantity = 1;

      setState(() {
        controller.dispose();
        qr_request = false;
        count++;
        //print(newdelivery.barcode.toString());
        //print(newdelivery.productName.toString());
//        ndelivery_bloc.insertProduct(newdelivery);
//        ndelivery_bloc.dispose();
//        ndelivery_bloc.getProduct();
      });
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text(
          "Pickup Delivery",
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
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: Text("Please Enter GTIN or Product ID"),
                ),

                SizedBox(width: 40,),

                Container(
                  margin: EdgeInsets.only(
                    left: 100,
                    top: 10,
                  ),
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
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
                  width: 60,
                  child: Center(
                      child: Text(
                        "33",
                        style: GoogleFonts.exo2(textStyle: TextStyle(fontSize: 25)),
                      )),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 58,
                  width: MediaQuery.of(context).size.width - 87,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, left: 13, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
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
                        autocorrect: true,
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
                          hintText: "Enter or Scan Product GTIN To Add",
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
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
                          icon: new Image.asset(
                            'assets/images/qr-code.png',
                            fit: BoxFit.contain,
                            color: Colors.white,
                          ),
                          tooltip: 'Scan barcode',
                          onPressed: () {
                            setState(() {
                              qr_request = true;
                            });

                            setState(() {
                              qrText = "";
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),


            qr_request
                ? Padding(
              padding: EdgeInsets.only(top: 100.0),
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
            )
                : WillPopScope(
              // ignore: missing_return
              onWillPop: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()));
                //ndelivery_bloc.deleteTable();
              },
              child: SingleChildScrollView(
                child: Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width - 30,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .backgroundColor
                            .withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
//                  child: StatefulBuilder(
//                    builder: (context, setState) {
//                      return StreamBuilder(
//                          stream: ndelivery_bloc.allProductData,
//                          builder: (BuildContext context,
//                              AsyncSnapshot<List<NewDeliveryModel>>
//                              snapshot) {
//                            return newproductdata(snapshot);
//                          });
//                    },
//                  ),

                child: Text("jshajsahs"),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
