import 'dart:convert';

import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/UI/Deliveries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';



const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';


class Tag {
  String name;
  int quantity;

  Tag(this.name, this.quantity);

  factory Tag.fromJson(dynamic json) {
    return Tag(json['name'] as String, json['quantity'] as int);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.quantity} }';
  }
}


class NewDeliveryPage extends StatefulWidget {
  @override
  _NewDeliveryPageState createState() => _NewDeliveryPageState();
}

class _NewDeliveryPageState extends State<NewDeliveryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  var controller;
  bool qr_request = false;

  TextEditingController _searchQueryController = new TextEditingController();


  List<String> product_names = [];
  List<String> barcode = [];

  List<NewDeliveryModel> products = [];





  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        //_searchQueryController.text = qrText;

//        var product = new NewDeliveryModel(barcode: _searchQueryController.text,product_name: "New product");
//        deliveryList.add(product);
//        print("Size is : "+deliveryList.length.toString());


//      deliveryList.clear();
//        print("Size is : "+deliveryList.length.toString());

      });

      product_names.add("Product");
      barcode.add(qrText.toString());




//      for(int i = 0; i < barcode.length;i++) {
//          print( "barcodes are "+barcode[i] + "  Product name  "+product_names[i]);
//      }
//


      setState(() {
        qr_request = false;
      });

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product_names.clear();
    barcode.clear();
    products.clear();
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeliveriesPage()));
            },
          ),
          title: Text(
            "New Delivery",
            style: GoogleFonts.exo2(
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
        ),

        body: Container(
          color: Theme
              .of(context)
              .backgroundColor,

          child: Column(
            children: <Widget>[

              Container(

                margin: EdgeInsets.only(
                    left: 330,
                  top: 10,
                ),
                height: 70,
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
                width: MediaQuery.of(context).size.width-350,
                child: Center(child: Text("8",
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                      fontSize: 50
                    )
                  ),
                )),
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
                            hintText: "Enter or Scan Product GTIN To Add",
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
                            onPressed: (){
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



              qr_request ?
              Padding(
                padding: EdgeInsets.only(top: 100.0),
                child: Container(
                  width: MediaQuery.of(context).size.width-60,
                  height: 300,
                  child: qrText.isEmpty ? QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.green,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300,
                    ),
                  ) :Container(),

                ),
              ) : SingleChildScrollView(
                child: Container(
                  height: 310,
                  width: MediaQuery.of(context).size.width-30,
                  margin: EdgeInsets.only(top: 5),
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
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: barcode.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          alignment: AlignmentDirectional.center,
                          child: Text((index+1).toString(),
                            style: GoogleFonts.exo2(
                                fontSize: 20
                            ),),
                        ),
                        title: Text(product_names[index],
                          style: GoogleFonts.exo2(
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Text(barcode[index],
                          style: GoogleFonts.exo2(

                          ),),
                        trailing: Container(
                          height: 60,
                          width: 80,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("POS/QTY",
                                  style: GoogleFonts.exo2(
                                    fontSize: 15,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                Text("4 / 201",
                                  style: GoogleFonts.exo2(
                                    fontSize: 15,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

            ],
          ),

        ),

      );
    }
  }