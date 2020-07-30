import 'package:app/UI/BarcodeInfo.dart';
import 'package:app/UI/Deliveries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.00),
      child: new ListView(
        children: <Widget>[
          new Card(
              child: ListTile(
            title: new Text(
              'Barcode information',
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            isThreeLine: false,
            subtitle:
                new Text('Barcode data display', style: GoogleFonts.exo2()),
            trailing: new Icon(Icons.arrow_forward),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 45,
                minHeight: 45,
                maxWidth: 45,
                maxHeight: 45,
              ),
              child:
                  Image.asset('assets/images/barcode.png', fit: BoxFit.cover),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BarcodeInfo()));
            },
          )),
          new Card(
              child: ListTile(
            title: new Text(
              'Deliveries',
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            isThreeLine: false,
            subtitle: new Text(
              'Create or modifiy a delivery',
              style: GoogleFonts.exo2(),
            ),
            trailing: new Icon(Icons.arrow_forward),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 45,
                minHeight: 45,
                maxWidth: 45,
                maxHeight: 45,
              ),
              child:
                  Image.asset('assets/images/delivery.png', fit: BoxFit.cover),
            ),
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => DeliveriesPage()));
                }
           )
          ),
          new Card(
              child: ListTile(
            title: new Text(
              'Pick up',
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            isThreeLine: false,
            subtitle: new Text('Collect shipment', style: GoogleFonts.exo2()),
            trailing: new Icon(Icons.arrow_forward),
            leading: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 45,
                minHeight: 45,
                maxWidth: 45,
                maxHeight: 45,
              ),
              child: Image.asset('assets/images/pickup.png', fit: BoxFit.cover),
            ),
          )),
        ],
      ),
    );
  }
}
