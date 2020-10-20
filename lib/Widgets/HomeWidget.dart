import 'package:app/Handler/app_localizations.dart';
import 'package:app/UI/BarcodeCompare.dart';
import 'package:app/UI/BarcodeInfo.dart';
import 'package:app/UI/DataAcquisition.dart';
import 'package:app/UI/Deliveries.dart';
import 'package:app/UI/LevelPrinting.dart';
import 'package:app/UI/PhotoDocumentation.dart';
import 'package:app/UI/PickupDelivery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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
                  Image.asset('assets/images/barcode-info.jpeg', fit: BoxFit.cover),
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
                  Image.asset('assets/images/barcode-info.jpeg', fit: BoxFit.cover),
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
                  Image.asset('assets/images/barcode-info.jpeg', fit: BoxFit.cover),
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
                  Image.asset('assets/images/barcode-info.jpeg', fit: BoxFit.cover),
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
                  Image.asset('assets/images/barcode-info.jpeg', fit: BoxFit.cover),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LevelPrintingPage()));
                },
              )),

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Container(
              child: ListTile(
                title: new Text(
                  "Custom Function",
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
                    "only visible when cusomt application is set",
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

          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
