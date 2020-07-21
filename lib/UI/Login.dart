import 'dart:io';

import 'package:app/UI/Settings.dart';
import 'package:app/Widgets/ConnectionSettings.dart';
import 'package:app/Widgets/LoginWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text('L O G I N',
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          leading: new IconButton(
            icon: new Icon(Icons.settings, color: Colors.black54,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnectionSettingsPage()),
              );
            },

          ),
          backgroundColor: Colors.white,
          actions: [
            new IconButton(
                icon: new Icon(Icons.language, color: Colors.black54,),
                onPressed: null),
            new IconButton(
                icon: new Icon(Icons.exit_to_app, color: Colors.black54,),
                onPressed: () {
                  exit(0);

                  //Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.pop(
                      context, true); // It worked for me instead of above line
//                  Navigator.pushReplacement(
//                    context, MaterialPageRoute(builder: (context) => MyApp()),);
                }


            ),

          ],
          centerTitle: true,
          elevation: 0.0,
        ),

        body: Center(

            child: LoginWidget()
        )

    );
  }
}
