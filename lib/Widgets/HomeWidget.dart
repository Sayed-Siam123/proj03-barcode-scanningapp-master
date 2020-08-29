import 'package:app/Handler/app_localizations.dart';
import 'package:app/UI/BarcodeInfo.dart';
import 'package:app/UI/Deliveries.dart';
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
          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Container(
              child: ListTile(
                  title: new Text(
                    translate('delivereies'),
                    style: GoogleFonts.exo2(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  isThreeLine: false,
                  subtitle: new Text(
                    translate('delivereies_desc'),
                    style: GoogleFonts.exo2(),
                  ),
                  //trailing: new Icon(Icons.arrow_forward),
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 45,
                      minHeight: 45,
                      maxWidth: 45,
                      maxHeight: 45,
                    ),
                    child: Image.asset('assets/images/Delivery-icon.jpeg',
                        fit: BoxFit.cover),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliveriesPage()));
                  })),
          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
           Container(
              child: ListTile(
            title: new Text(
              translate('pickup'),
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
                translate('pickup_desc'),
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
                  Image.asset('assets/images/pickup.jpeg', fit: BoxFit.cover),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PickupDelivery()));
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
