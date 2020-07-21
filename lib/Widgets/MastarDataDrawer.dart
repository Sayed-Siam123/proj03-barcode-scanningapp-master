import 'package:app/UI/MasterData.dart';
import 'package:app/UI/Sublist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MasterDataDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('App name'),
            decoration: BoxDecoration(
              color: Colors.amberAccent,
            ),
          ),
          ListTile(
            title: Text('Product'),
            trailing:  new Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MasterData()),
            );
            },
          ),
          ListTile(
            title: Text('Sublist'),
            trailing:  new Icon(Icons.arrow_forward),
            onTap: () {
              // Update the state of the app.
              // ...
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SublistPage()),
            );
            },
          ),
          Divider(),
          Text("Version 1.0.1"),
        ],
      ),
    );
  }
}
