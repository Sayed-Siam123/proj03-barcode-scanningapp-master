import 'package:app/Bloc/NewDelivery_bloc.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Resources/database_helper.dart';
import 'package:app/UI/Deliveries.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'DeliveryProductList.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class NewDeliveryPage extends StatefulWidget {
  @override
  _NewDeliveryPageState createState() => _NewDeliveryPageState();
}

class _NewDeliveryPageState extends State<NewDeliveryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  ScanResult barcode2;
  var qrText = "";
  var controller;
  bool qr_request = false;

  TextEditingController _searchQueryController = new TextEditingController();

  List<String> product_names = <String>[];

  List<String> barcode = <String>[];

  List<NewDeliveryModel> products = [];

  List<String> result1 = [];
  List<String> result2 = [];

  DatabaseHelper helper = DatabaseHelper();

  NewDeliveryModel newdelivery;
  NewDeliveryModel product;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<NewDeliveryModel> deliveryList;
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

        newdelivery = NewDeliveryModel(
          barcode_: _searchQueryController.text.toString(),
          product_name_: "Product",
          quantity_: 1,
        );
      });

//      newdelivery.productName = qrText;
//      newdelivery.Barcode = qrText;
//      newdelivery.Quantity = 1;

      setState(() {
        controller.dispose();
        qr_request = false;
        count++;
        print(newdelivery.barcode.toString());
        //print(newdelivery.productName.toString());
        ndelivery_bloc.insertProduct(newdelivery);
        ndelivery_bloc.dispose();
        ndelivery_bloc.getProduct();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    product_names.clear();
//    barcode.clear();
//    products.clear();
//
//
//    updateListView();

    ndelivery_bloc.getProduct();
    //ndelivery_bloc.deleteTable();
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
            ndelivery_bloc.deleteTable();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Image.asset(
            'assets/images/shopping_complete.png',
            color: Colors.white,
            fit: BoxFit.fill,
          ),
          onPressed: () {
            print("akjsaks");
            _showNoteDialog(context);
          },
        ),
        backgroundColor: Colors.green,
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
                        count.toString(),
                        style: GoogleFonts.exo2(textStyle: TextStyle(fontSize: 50)),
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
                              builder: (context) => DeliveriesPage()));
                      ndelivery_bloc.deleteTable();
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
                        child: StatefulBuilder(
                          builder: (context, setState) {
                            return StreamBuilder(
                                stream: ndelivery_bloc.allProductData,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<NewDeliveryModel>>
                                        snapshot) {
                                  return newproductdata(snapshot);
                                });
                          },
                        ),
                      ),
                    ),
                  ),
          ],
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
            product = snapshot.data[index];
            final Widget dismissibleCard = new Dismissible(
              key: UniqueKey(),
              background: Container(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Deleting",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                color: Colors.redAccent,
              ),
              onDismissed: (DismissDirection direction) {
                if (product.id.toString() != null) {
                  setState(() {
                    ndelivery_bloc.deleteProductById(product.id);
                  });

                  setState(() {
                    count--;
                    _searchQueryController.text = "";
                  });

                  //TODO:: SNACKBAR EXAMPLE

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Successfully Deleted',
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              direction: _dismissDirection,
              child: Container(
                color: Colors.white,
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
                ),
              ),
            );
            return dismissibleCard;
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

  void _showNoteDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (_) => StatefulBuilder(
              builder: (context, setState) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var width = MediaQuery.of(context).size.width;

                      return Form(
                        key: _resetKey1,
                        autovalidate: _resetValidate1,
                        child: Container(
                          height: 120,
                          width: width - 100,
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                child: new TextFormField(
                                  autofocus: false,
                                  style: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  decoration: new InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 3.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    hintStyle: GoogleFonts.exo2(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    labelStyle: GoogleFonts.exo2(
                                      textStyle: TextStyle(
                                        fontSize: 20,

                                      ),
                                    ),
                                    labelText: 'Note',
                                    hintText: 'Enter Your Note Here (Optional)',
                                    errorText:
                                        _validate1 == false ? errortext1 : null,
                                  ),
                                  controller: _inputcontrol1,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  // ignore: missing_return
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: const Text('Skip'),
                        onPressed: () {
                          print("Skip hbe arekta Dialog khulbe");
                          Navigator.pop(context);
                          _showHandlingUnitDialog(context);
                        }),
                    new FlatButton(
                        child: const Text('Add'),
                        onPressed: () {
                          print("Add hobe");

                          product.note = _inputcontrol1.text;

                          print(product.barcode.toString());
                          print(product.note.toString());
                          print(product.id.toString());

                          ndelivery_bloc.updateProduct(product);

                          _inputcontrol1.text = "";

                          _showHandlingUnitDialog(context);
                        })
                  ],
                );
              },
            ));
  }


  void _showHandlingUnitDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (context, setState) {
            return new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var width = MediaQuery.of(context).size.width;

                  return Form(
                    key: _resetKey2,
                    autovalidate: _resetValidate2,
                    child: Container(
                      height: 120,
                      width: width - 100,
                      child: new Column(
                        children: <Widget>[
                          new Container(
                            child: new TextFormField(
                              autofocus: false,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 3.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black),
                                ),
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 20,

                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: new Image.asset('assets/images/barcode.png',
                                      fit: BoxFit.contain),
                                  tooltip: 'Scan barcode',
                                  onPressed: barcodeScanning2,
                                ),
                                labelText: 'Handling Unit',
                                hintText: 'Enter Your Unit Barcode Here (Optional)',
                                errorText:
                                _validate1 == false ? errortext1 : null,
                              ),
                              controller: _inputcontrol2,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              // ignore: missing_return
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              actions: <Widget>[
                new FlatButton(
                    child: const Text('Skip'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DeliveryProductList()));

                      print("Skip hbe arekta Dialog khulbe");
                    }),
                new FlatButton(
                    child: const Text('Add'),
                    onPressed: () {
                      print("Add hobe");

                      product.handling_unit = _inputcontrol2.text;

                      print(product.handling_unit.toString());
                      print(product.note.toString());
                      print(product.id.toString());

                      ndelivery_bloc.updateProduct(product);

                      ndelivery_bloc.dispose();

                      _inputcontrol2.text = "";

                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DeliveryProductList()));
                    })
              ],
            );
          },
        ));
  }


  Future barcodeScanning2() async {
    try {
      barcode2 = await BarcodeScanner.scan();
      print(barcode2.rawContent.toString());
      setState(() {
        this.barcode2 = barcode2;
        _inputcontrol2.text = barcode2.rawContent.toString();
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
