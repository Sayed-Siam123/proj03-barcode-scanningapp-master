import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container (
      padding: EdgeInsets.all(10.00),
      child: new ListView (
        children: <Widget>[
          new  Card (
              child: ListTile(

                title: new Text('Barcode information'),
                isThreeLine: false,
                subtitle: new Text('Barcode data display'),
                trailing: new Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 45,
                    minHeight: 45,
                    maxWidth: 45,
                    maxHeight: 45,
                  ),
                  child: Image.asset('assets/images/barcode.png', fit: BoxFit.cover),
                ),

              )

          ),
          new  Card (
              child: ListTile(
                title: new Text('Deliveries'),
                isThreeLine: false,
                subtitle: new Text('Create or modifiy a delivery'),
                trailing: new Icon(Icons.arrow_forward),
                leading: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 45,
                    minHeight: 45,
                    maxWidth: 45,
                    maxHeight: 45,
                  ),
                  child: Image.asset('assets/images/delivery.png', fit: BoxFit.cover),
                ),
              )

          ),
          new  Card (
              child: ListTile(
                title: new Text('Pick up'),
                isThreeLine: false,
                subtitle: new Text('Collect shipment'),
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
              )

          ),

        ],

      ),






    );
  }
}
