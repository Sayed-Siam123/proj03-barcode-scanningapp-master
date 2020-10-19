import 'package:app/UI/DataAcquisition.dart';
import 'package:app/Widgets/DataAcquisitionVIewWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'DataAcquisitionSystemSettings.dart';
import 'Home.dart';

class DataAcquisitionViewPage extends StatefulWidget {
  @override
  _DataAcquisitionViewPageState createState() => _DataAcquisitionViewPageState();
}

class _DataAcquisitionViewPageState extends State<DataAcquisitionViewPage> {
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
                context, MaterialPageRoute(builder: (context) => DataAcquisition()));
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DataAcquisitionSystemSettings()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          )
        ],
      ),

      body: OrientationLayoutBuilder(
        portrait: (context) => DataAcquisitionViewWidget(height: hp(100),width: wp(100)),

      ),
    );
  }
}
