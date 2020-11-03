import 'dart:async';

import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/CustomFunctionModel.dart';
import 'package:app/UI/BarcodeCompare.dart';
import 'package:app/UI/BarcodeInfo.dart';
import 'package:app/UI/DataAcquisition.dart';
import 'package:app/UI/Deliveries.dart';
import 'package:app/UI/LevelPrinting.dart';
import 'package:app/UI/PhotoDocumentation.dart';
import 'package:app/UI/PickupDelivery.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  String _customdataJSON = "_customdata";
  String _activateKey = "_activate";
  bool status = false;


  SessionManager prefs = new SessionManager();
  CustomFunctionModel custom_load;
  String name,desc;

  loadSharedPrefs() async {
    try {
      CustomFunctionModel result = CustomFunctionModel.fromJson(await prefs.read(_customdataJSON));

      print("name from pref: "+result.name.toString());
      print("Length of pref: "+result.field_list.length.toString());

      setState(() {
        name = result.name.toString();
        desc = result.desc.toString();
        //print("name of pref: "+name.toString());
      });

      print(name.toString() + " found");



    } catch (Excepetion) {
      setState(() {
        name = "";
        desc = "";
      });
      print(name.toString() + " found");
    }
  }

  void getstatus() async {
    Future<bool> stauts = prefs.getBoolData(_activateKey);
    stauts.then((data) async {
      print('status pabo');
      print("status " + data.toString());

      setState(() {
        status = data;
      });
      print(status.toString());

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

    Timer(Duration(milliseconds: 50),(){
      loadSharedPrefs();
      getstatus();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:10.00),
      child: new ListView(
        children: <Widget>[
           Container(
              child: ListTile(
            title: new Text(
              translate('barcode_info'),
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            isThreeLine: false,
            subtitle: new Text(
                translate('barcode_info_desc'),
                style: GoogleFonts.exo2()),
            //trailing: new Icon(Icons.arrow_forward),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 45,
                minHeight: 45,
                maxWidth: 45,
                maxHeight: 45,
              ),
              child: Image.asset('assets/images/barcode-info.jpeg',
                  fit: BoxFit.cover),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BarcodeInfo()));
            },
          )),
          // Divider(
          //   thickness: 1,
          //   color: Colors.black54,
          // ),
          // Container(
          //     child: ListTile(
          //         title: new Text(
          //           translate('delivereies'),
          //           style: GoogleFonts.exo2(
          //             textStyle: TextStyle(
          //               fontSize: 20,
          //               color: Colors.black,
          //                 fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //         isThreeLine: false,
          //         subtitle: new Text(
          //           translate('delivereies_desc'),
          //           style: GoogleFonts.exo2(),
          //         ),
          //         //trailing: new Icon(Icons.arrow_forward),
          //         leading: ConstrainedBox(
          //           constraints: BoxConstraints(
          //             minWidth: 45,
          //             minHeight: 45,
          //             maxWidth: 45,
          //             maxHeight: 45,
          //           ),
          //           child: Image.asset('assets/images/Delivery-icon.jpeg',
          //               fit: BoxFit.cover),
          //         ),
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => DeliveriesPage()));
          //         })),
          // Divider(
          //   thickness: 1,
          //   color: Colors.black54,
          // ),
          //  Container(
          //     child: ListTile(
          //   title: new Text(
          //     translate('pickup'),
          //     style: GoogleFonts.exo2(
          //       textStyle: TextStyle(
          //         fontSize: 20,
          //         color: Colors.black,
          //           fontWeight: FontWeight.bold
          //       ),
          //     ),
          //   ),
          //   isThreeLine: false,
          //   subtitle: new Text(
          //       translate('pickup_desc'),
          //       style: GoogleFonts.exo2()),
          //   //trailing: new Icon(Icons.arrow_forward),
          //   leading: ConstrainedBox(
          //     constraints: BoxConstraints(
          //       minWidth: 45,
          //       minHeight: 45,
          //       maxWidth: 45,
          //       maxHeight: 45,
          //     ),
          //     child:
          //         Image.asset('assets/images/pickup.jpeg', fit: BoxFit.cover),
          //   ),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => PickupDelivery()));
          //   },
          // )),

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Container(
              child: ListTile(
                title: new Text(
                  "Barcode Comparison",
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                isThreeLine: false,
                subtitle: new Text(
                    "Compare Barcode",
                    style: GoogleFonts.exo2()),
                //trailing: new Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 45,
                    minHeight: 45,
                    maxWidth: 45,
                    maxHeight: 45,
                  ),
                  child:
                  Image.asset('assets/images/compare.jpeg', fit: BoxFit.cover),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BarcodeComparePage()));
                },
              )),

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Container(
              child: ListTile(
                title: new Text(
                  "Data Acquisition",
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                isThreeLine: false,
                subtitle: new Text(
                    "Save barcode data in CSV",
                    style: GoogleFonts.exo2()),
                //trailing: new Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 45,
                    minHeight: 45,
                    maxWidth: 45,
                    maxHeight: 45,
                  ),
                  child:
                  Image.asset('assets/images/acqui.jpeg', fit: BoxFit.cover),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DataAcquisition()));
                },
              )),

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Container(
              child: ListTile(
                title: new Text(
                  "Data Synchronization",
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                isThreeLine: false,
                subtitle: new Text(
                    "Match barcode data to a list",
                    style: GoogleFonts.exo2()),
                //trailing: new Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 45,
                    minHeight: 45,
                    maxWidth: 45,
                    maxHeight: 45,
                  ),
                  child:
                  Image.asset('assets/images/sync.jpeg', fit: BoxFit.cover),
                ),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => BarcodeComparePage()));
                },
              )),

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Container(
              child: ListTile(
                title: new Text(
                  "Photo documentation",
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                isThreeLine: false,
                subtitle: new Text(
                    "Link barcode data with images",
                    style: GoogleFonts.exo2()),
                //trailing: new Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 45,
                    minHeight: 45,
                    maxWidth: 45,
                    maxHeight: 45,
                  ),
                  child:
                  Image.asset('assets/images/photo.jpeg', fit: BoxFit.cover),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PhotoDocumentationPage()));
                },
              )),

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Container(
              child: ListTile(
                title: new Text(
                  "Label Printing",
                  style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                isThreeLine: false,
                subtitle: new Text(
                    "Print barcode label",
                    style: GoogleFonts.exo2()),
                //trailing: new Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 45,
                    minHeight: 45,
                    maxWidth: 45,
                    maxHeight: 45,
                  ),
                  child:
                  Image.asset('assets/images/print.jpeg', fit: BoxFit.cover),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LevelPrintingPage()));
                },
              )),



          name.isNotEmpty && status == true ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Divider(
                thickness: 1,
                color: Colors.black54,
              ),
              Container(
                  child: ListTile(
                    title: new Text(
                      name.toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    isThreeLine: false,
                    subtitle: new Text(
                        desc.toString(),
                        style: GoogleFonts.exo2()),
                    //trailing: new Icon(Icons.arrow_forward),
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 45,
                        minHeight: 45,
                        maxWidth: 45,
                        maxHeight: 45,
                      ),
                      child:
                      Image.asset('assets/images/barcode-info.jpeg', fit: BoxFit.cover),
                    ),
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => BarcodeComparePage()));
                    },
                  )),
            ],
          ) : Container(
            width: 0,
            height: 0,
          ),

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
