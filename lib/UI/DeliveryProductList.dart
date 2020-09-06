import 'dart:async';

import 'package:app/Bloc/NewDelivery_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/GetDeliveryResponse_Model.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/UI/Deliveries.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DeliveryProductList extends StatefulWidget {
  @override
  _DeliveryProductListState createState() => _DeliveryProductListState();
}

class _DeliveryProductListState extends State<DeliveryProductList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<NewDeliveryModel> _product;
  SessionManager prefs =  SessionManager();
  String finalDate = '';

  bool status = false;

  String position_ = null;
  String useridKey = "userid";
  String userid = "";

  int _quantity = 0;

  int totalQuantity = 0;
  bool countStatus = false;

  List quantityofitems = List<int>();

  getdeliverysuccess_model fetched_data = new getdeliverysuccess_model();
  getdeliverysuccess_model another_fetched_data = new getdeliverysuccess_model();

//  void _incrament() {
//    setState(() {
//      _quantity++;
//    });
//    print(_quantity.toString());
//  }
//
//  void _decrement() {
//    setState(() {
//      if (_quantity != 0) {
//        _quantity--;
//      }
//    });
//    print(_quantity.toString());
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityofitems.clear();
    getCurrentDate();
    print(finalDate);
    ndelivery_bloc.getallProduct();
    getUserid();
    Timer(Duration(seconds: 3), () {
      getTotal();
    });
  }

  void getUserid() async {

    Future<String> _userid = prefs.getData(useridKey);
    _userid.then((data) {

      print("userid " + data.toString());
      this.userid = data.toString();

      print("USerid: "+userid);

    },onError: (e) {
      print(e);
    });


  }

  getTotal(){

    if(countStatus == false){
      for(int i = 0; i<quantityofitems.length;i++){
        setState(() {
          totalQuantity += quantityofitems[i];
        });
      }
      print("length:: "+quantityofitems.length.toString());
      countStatus = true;
    }


    print(totalQuantity);
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
                MaterialPageRoute(builder: (context) => DeliveriesPage()));
          },
        ),
        title: Text(
          translate('delivery_list_title').toString(),
          style: GoogleFonts.exo2(
            textStyle: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
      ),
      floatingActionButton: Container(
        height: 110,
        width: MediaQuery.of(context).size.width - 30,
        child: Stack(
          children: <Widget>[
            status == false
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.grey.shade700,
                      onPressed: () async {
                        print("Inactive");

                      },
                      child: Icon(
                        Icons.print,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomLeft,
                    child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.green,
                      onPressed: () async {
                        _printDocument();
                      },
                      child: Icon(
                        Icons.print,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
            status == false
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.green,
                      onPressed: () {
                        print("dsdsd");
                        //print(_product.length.toString());

                        String str = '';

                        print(_product.last.noteText);
                        for (int i = 0; i < _product.length - 1; i++) {
                          _product[i].HandlingUnit = _product.last.handlingUnit;
                          _product[i].Note = _product.last.noteText;
                        }

                        for (int i = 0; i < _product.length; i++) {
                          str += userid.toString() +
                              "," +
                              _product[i].handlingUnit +
                              "," +
                              _product[i].productID.toString() +
                              "," +
                              _product[i].quantity.toString() +
                              "," +
                              _product[i].noteText.toString() +
                              "\$";

//                    str += "1" + ", " + "1" + ", " +
//                        "TP1000015" + ", " +
//                        _product[i].quantity.toString() + ", " +
//                        _product[i].noteText.toString() + " \$ ";
                        }

                        //print(str);
                        ndelivery_bloc.deleteTable();

                        ndelivery_bloc.createDeliverypost(str);
                        ndelivery_bloc.getAllDeliveryList();
//                  ndelivery_bloc.deleteTable();

                        setState(() {
                          status = true;
                        });

                        Timer(Duration(seconds: 3), () {
                          setState(() {
                            another_fetched_data.position = fetched_data.position;
                            another_fetched_data.code = fetched_data.code;
                            another_fetched_data.message = fetched_data.message;

                          });
                        });

                        print("From ANother : "+another_fetched_data.position.toString());
                      },
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      heroTag: null,
                      backgroundColor: Colors.green,
                      onPressed: () {
                        print("dsdsd");

                        ndelivery_bloc.deleteTable();
                        ndelivery_bloc.getAllDeliveryList();

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveriesPage()));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Navigator.push(context,
              MaterialPageRoute(builder: (context) => DeliveriesPage()));
        },
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 240,
                  width: MediaQuery.of(context).size.width - 20,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 5,
                          md: 3,
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  translate('delivery_id').toString(),
                                  style: GoogleFonts.exo2(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  translate('pallet').toString(),
                                  style: GoogleFonts.exo2(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      translate('position').toString(),
                                      style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 0,
                                        top: 10,
                                      ),
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.0),
                                            spreadRadius: 0,
                                            blurRadius: 0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      width: 70,
                                      child: Center(
                                          child: Text(
                                            another_fetched_data.position==null? "" : another_fetched_data.position.toString(),
                                            style: GoogleFonts.exo2(
                                                textStyle: TextStyle(fontSize: 30)),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ResponsiveGridCol(
                          xs: 7,
                          md: 5,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        another_fetched_data.code==null ? "" : another_fetched_data.code.toString(),
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        another_fetched_data.message==null ? "" : another_fetched_data.message.toString(),
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            translate('quantity').toString(),
                                            style: GoogleFonts.exo2(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: 0,
                                              top: 12,
                                            ),
                                            height: 70,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.0),
                                                  spreadRadius: 0,
                                                  blurRadius: 0,
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                            ),
                                            width: 70,
                                            child: Center(
                                                child: Text(
                                                  totalQuantity.toString(),
                                                  style: GoogleFonts.exo2(
                                                      textStyle: TextStyle(fontSize: 30)),
                                                )),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Center(
                  child: Container(
                    height: 420,
                    width: MediaQuery.of(context).size.width - 20,
                    color: Colors.white,
                    child: status == false
                        ? StreamBuilder(
                            stream: ndelivery_bloc.allProductData1,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<NewDeliveryModel>>
                                    snapshot) {
                              return newproductdata(snapshot);
                            })
                        : StreamBuilder<getdeliverysuccess_model>(
                      stream: ndelivery_bloc.deliveypostdata,
                      builder: (context, AsyncSnapshot<getdeliverysuccess_model> snapshot) {
                        if (snapshot.hasData) {
                          //_newData = fetcheddata;
                          print("Data gula:: ");

                          fetched_data = snapshot.data;

                          print(fetched_data.message);
                          print(fetched_data.position.toString());
                          print(fetched_data.code.toString());
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }

                        return Center(child: Text(""));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget newproductdata(AsyncSnapshot<List<NewDeliveryModel>> snapshot) {
    if (snapshot.hasData) {
      return Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            _product = snapshot.data;
            quantityofitems.add(snapshot.data[index].quantity);

            print("Initial Quantity:: "+quantityofitems.length.toString());

            return Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  snapshot.data[index].productName.toString(),
                  style: GoogleFonts.exo2(
                    fontSize: 20,
                  ),
                ),

                //TODO:: eikhane eshe streambuilder theke eshe porte thakbe

                subtitle: Text(
                  snapshot.data[index].barcode.toString(),
                  style: GoogleFonts.exo2(),
                ),
                trailing: Container(
                  height: 60,
                  width: 200,
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              if (quantityofitems[index] != 1) {
                                quantityofitems[index]--;

                                if(countStatus){
                                  totalQuantity--;
                                }
                                print(quantityofitems[index].toString());
                                //ndelivery_bloc.updateProduct(_product[index]);
                                _product[index].Quantity =
                                    quantityofitems[index];
                                print("After increment Total quantity: " +
                                    _product[index].quantity.toString() +
                                    "of id" +
                                    _product[index].id.toString());
                                ndelivery_bloc.updateProduct(_product[index]);
                              }
                            });
                          },
                          color: Colors.white,
                          textColor: Colors.black54,
                          child: Icon(
                            Icons.remove,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        ),
                        Text(
                          quantityofitems[index].toString(),
                          style: GoogleFonts.exo2(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            setState(() {
                              quantityofitems[index]++;

                              if(countStatus){
                                totalQuantity++;
                              }

                              print(quantityofitems[index].toString());
                              _product[index].Quantity = quantityofitems[index];
                              print("After increment Total quantity: " +
                                  _product[index].quantity.toString() +
                                  "of id" +
                                  _product[index].id.toString());
                              ndelivery_bloc.updateProduct(_product[index]);
                            });
                          },
                          color: Colors.white,
                          textColor: Colors.black54,
                          child: Icon(
                            Icons.add,
                            size: 24,
                          ),
                          padding: EdgeInsets.all(10),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else if (snapshot.hasError) {
      return Text("${snapshot.error}");
    } else if (!snapshot.hasData) {
      Center(child: Text("No Data"));
    }

    return Center(child: CircularProgressIndicator());
//    return Center(child: Text("No Data"));
  }

  void _printDocument() {
    Printing.layoutPdf(
      onLayout: (pageFormat) {
        final doc = pw.Document();

        doc.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a5,
            build: (pw.Context context) => pw.Center(
                child: pw.Container(
              height: 140,
              width: 190,
              decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.rectangle,
                  border: pw.BoxBorder(
                    color: PdfColor.fromHex("#000000"),
                    top: true,
                    bottom: true,
                    left: true,
                    right: true,
                  )),
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: <pw.Widget>[
                    pw.Align(
                        alignment: pw.Alignment.center,
                        child: pw.Container(
                            child: pw.BarcodeWidget(
                          height: 70,
                          width: 170,
                          data: fetched_data.code == null? "TP0000": fetched_data.code,
                          barcode: pw.Barcode.code128(),
                        ))),
                    pw.SizedBox(height: 10),
                    pw.Align(
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: <pw.Widget>[
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceEvenly,
                              children: <pw.Widget>[
                                pw.Text("Date",
                                    style: pw.TextStyle(
                                      font: pw.Font.helveticaBold(),
                                      fontSize: 15,
                                    )),
                                pw.Text("Store",
                                    style: pw.TextStyle(
                                      font: pw.Font.helveticaBold(),
                                      fontSize: 15,
                                    )),
                                pw.Text("POS/QTY",
                                    style: pw.TextStyle(
                                      font: pw.Font.helveticaBold(),
                                      fontSize: 15,
                                    )),
                              ]),
                          pw.SizedBox(width: 30),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceEvenly,
                              children: <pw.Widget>[
                                pw.Text(finalDate.toString(),
                                    style: pw.TextStyle(
                                      font: pw.Font.helveticaBold(),
                                      fontSize: 15,
                                    )),
                                pw.Text("Store 1",
                                    style: pw.TextStyle(
                                      font: pw.Font.helveticaBold(),
                                      fontSize: 15,
                                    )),
                                pw.Text(fetched_data.position+"/"+"201",
                                    style: pw.TextStyle(
                                      font: pw.Font.helveticaBold(),
                                      fontSize: 15,
                                    )),
                              ]),
                        ]))
                  ]),
            )),
          ),
        );

        return doc.save();
      },
    );
  }

  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}.${dateParse.month}.${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }
}
