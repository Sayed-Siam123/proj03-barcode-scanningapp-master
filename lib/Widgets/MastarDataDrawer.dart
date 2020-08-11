import 'package:app/UI/MasterData.dart';
import 'package:app/UI/Sublist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MasterDataDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('App name',style: GoogleFonts.exo2(
                fontSize: 20,
             ),),
            decoration: BoxDecoration(
              color: Colors.amberAccent,
            ),
          ),
          ListTile(
            title: Text('Product',style: GoogleFonts.exo2(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),),
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
            title: Text('Sublist',style: GoogleFonts.exo2(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),),
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
          Text("Version 1.0.1",style: GoogleFonts.exo2(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),),
        ],
      ),
    );
  }
}
