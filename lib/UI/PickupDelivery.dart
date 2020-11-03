import 'package:app/Bloc/PickupDelivery_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/NewDeliveryModel.dart';
import 'package:app/Model/PickupDeliveryModel.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/Resources/database_helper.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/PickupSummary.dart';
import 'package:app/UI/SystemSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan/barcode_scan.dart';


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
  bool status = false;

  String cameraStatus;
  String _cameraKey = "_camera";
  SessionManager prefs =  SessionManager();

  TextEditingController _searchQueryController = new TextEditingController();

  List<String> product_names = <String>[];

  List<String> barcode = <String>[];

  List<PickupDeliveryModel> products = [];

  List<String> result1 = [];
  List<String> result2 = [];

  DatabaseHelper helper = DatabaseHelper();

  PickupDeliveryModel pickupDelivery;
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

  SinglePickupDataModel fetcheddata;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";

  final DismissDirection _dismissDirection = DismissDirection.horizontal;


  onChangedValue(String text){
    print(text);

      pickupdelivery_bloc.getProductIDfromScan(text.toString());
      pickupdelivery_bloc.getSingledata();
      pickupdelivery_bloc.dispose();

      setState(() {
        count++;
      });

//    pickupDelivery = PickupDeliveryModel(
//      delivery_id_: "TP1005",
//    );

    //pickupdelivery_bloc.insertPickupProduct(pickupDelivery);

  }


//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         qrText = scanData;
//         _searchQueryController.text = qrText;
//
//         onChangedValue(qrText);
//         controller.dispose();
//
// //        ndelivery_bloc.getselecteditemProductName("ProductsNameHere");
// //        ndelivery_bloc.getselecteditemBarcode(_searchQueryController.text.toString());
// //        ndelivery_bloc.getselecteditemQuantity(1);
//
// //        newdelivery = NewDeliveryModel(
// //          barcode_: _searchQueryController.text.toString(),
// //          product_name_: "Product",
// //          quantity_: 1,
// //        );
// //      });
//
// //      newdelivery.productName = qrText;
// //      newdelivery.Barcode = qrText;
// //      newdelivery.Quantity = 1;
//
//       setState(() {
//         qr_request = false;
//         //print(newdelivery.barcode.toString());
//         //print(newdelivery.productName.toString());
// //        ndelivery_bloc.insertProduct(newdelivery);
// //        ndelivery_bloc.dispose();
// //        ndelivery_bloc.getProduct();
//       });
//     });
//   });
//   }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products.clear();
    getCamera();
    pickupdelivery_bloc.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pickupdelivery_bloc.dispose();
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
            pickupdelivery_bloc.dispose();
            return Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text(
          translate('pickup_delivery').toString(),
          style: GoogleFonts.exo2(
            textStyle: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(
            Icons.done,
            color: Colors.white,
          ),
          onPressed: () {
            print("akjsaks");

            if(products == null){
              print("Empty");
            }

            else{

              for(int i = 0; i< products.length; i++){
                print(products[i].delivery_id_);

                pickupdelivery_bloc.insertPickupProduct(products[i]);
                pickupdelivery_bloc.dispose();
                pickupdelivery_bloc.getAllpickupdatafromDB();

              }

              products.clear();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PickupSummary()));
            }
          },
        ),
        backgroundColor: Colors.green,
      ),

      body: Builder(
        builder: (context) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(5,0,0,0),
                      child: Text(translate('pickup_delivery_desc').toString(),style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w500
                        ),
                      ),),
                    ),

                    SizedBox(width: 0,),

                    Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        top: 10,
                        right: 0,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 13,
                            offset: Offset(3, 3),
                          ),
                        ],
                      ),
                      width: 50,
                      child: Center(
                          child: Text(
                            count.toString(),
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
                            onChanged: onChangedValue,
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
                              hintText: translate('pickup_delivery_hint').toString(),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 13,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 55,
                          width: 55,
                          child: Container(
                            child: IconButton(
                              icon: new Image.asset(
                                'assets/images/barcode.png',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                              tooltip: 'Scan barcode',
                              onPressed: () {
                                if(cameraStatus=="true"){
                                  setState(() {
                                    qr_request = true;
                                  });

                                  setState(() {
                                    qrText = "";
                                  });
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


//                 qr_request
//                     ? Padding(
//                   padding: EdgeInsets.only(top: 170.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width *.97,
//                     height: 300,
//                     // ignore: unrelated_type_equality_checks
//                     child: qrText.isEmpty && cameraStatus == "true"
//                         ? QRView(
//                       key: qrKey,
//                       onQRViewCreated: _onQRViewCreated,
//                       overlay: QrScannerOverlayShape(
//                         borderColor: Colors.green,
//                         borderRadius: 10,
//                         borderLength: 150,
//                         borderWidth: 10,
//                         cutOutSize: 300,
//                       ),
//                     )
//                         : Container(),
//                   ),
//                 )
//                     : WillPopScope(
//                   // ignore: missing_return
//                   onWillPop: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => HomePage()));
//                     //ndelivery_bloc.deleteTable();
//                   },
//                   child: SingleChildScrollView(
//                     child: Container(
//                       height: 80,
//                       width: MediaQuery.of(context).size.width - 20,
//                       margin: EdgeInsets.only(top: 10),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).backgroundColor,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Theme.of(context)
//                                 .backgroundColor
//                                 .withOpacity(0.5),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
// //                  child: StatefulBuilder(
// //                    builder: (context, setState) {
// //                      return StreamBuilder(
// //                          stream: ndelivery_bloc.allProductData,
// //                          builder: (BuildContext context,
// //                              AsyncSnapshot<List<NewDeliveryModel>>
// //                              snapshot) {
// //                            return newproductdata(snapshot);
// //                          });
// //                    },
// //                  ),
//
//                       child: StreamBuilder<SinglePickupDataModel>(
//                         stream: pickupdelivery_bloc.singlePickupData,
//                         builder: (context, AsyncSnapshot<SinglePickupDataModel> snapshot) {
//                           if (snapshot.hasData) {
//                             fetcheddata = snapshot.data;
//                             //_newData = fetcheddata;
//                             print("Data gula:: ");
//
//                             print(fetcheddata.deliveryCode);
//
//                             //TODO:: Here is the problem
//
//
// //                      pickupDelivery = PickupDeliveryModel(
// //                        delivery_id_: fetcheddata.deliveryCode,
// //                        huid_: fetcheddata.huType=="" || fetcheddata.huType==null ? "HU01" : fetcheddata.huType,
// //                        pos_: fetcheddata.position,
// //                        qnty_: fetcheddata.quantity,
// //                      );
//
//                             products.add(PickupDeliveryModel(
//                               delivery_id_: fetcheddata.deliveryCode,
//                               huid_: fetcheddata.huType=="" || fetcheddata.huType==null ? "HU01" : fetcheddata.huType,
//                               pos_: fetcheddata.position,
//                               qnty_: fetcheddata.quantity,
//                             ));
// //
// ////                      pickupdelivery_bloc.insertPickupProduct(pickupDelivery);
// ////                      pickupdelivery_bloc.dispose();
// ////                      pickupdelivery_bloc.getAllpickupdatafromDB();
// //
//                             return Card(
//                               margin: EdgeInsets.all(5),
//                               child: Container(
//                                 height: 20,
//                                 width: MediaQuery
//                                     .of(context)
//                                     .size
//                                     .width - 20,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                 ),
//                                 child: ListTile(
//                                   onTap: () {
//                                     print("Asche");
//                                   },
//                                   title: Text(fetcheddata.deliveryCode.toString(), style: GoogleFonts.exo2(
//                                     fontSize: 20,
//                                   ),),
//                                   subtitle: Text(
//                                     fetcheddata.huType=="" || fetcheddata.huType==null ? "HU01" : fetcheddata.huType,
//                                     style: GoogleFonts.exo2(
//
//                                     ),),
//                                 ),
//                               ),
//                             );
//
//                             //return Text("ajskas");
//
//                           } else if (snapshot.hasError) {
//                             return Text("${snapshot.error}");
//                           }
//
//                           return Center(child: Text("No Match"));
//                         },
//                       ),
//                     ),
//                   ),
//                 ),

              ],
            ),
          );
        },
      )
    );
  }
}
