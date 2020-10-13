import 'dart:io';

import 'package:app/UI/CreateDataAcquisition.dart';
import 'package:app/Widgets/DataAcquisitionWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'Home.dart';

class DataAcquisition extends StatefulWidget {
  @override
  _DataAcquisitionState createState() => _DataAcquisitionState();
}

class _DataAcquisitionState extends State<DataAcquisition> {
  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Acquisition",
          style: new TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => BarcodeComparisonSettingsPage()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          )
        ],
      ),

      body: OrientationLayoutBuilder(
        portrait: (context) => DataAcquisitionWidget(height: hp(100),width: wp(100)),

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateDataAcquisitionPage()));
        },
        child: Icon(Icons.add,color: Colors.white),
        backgroundColor: Colors.green.shade500,
      ),
    );
  }
}
