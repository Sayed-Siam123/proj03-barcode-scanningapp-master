import 'package:app/UI/SystemSettings.dart';
import 'package:app/Widgets/CreateDataAcquisitionWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'DataAcquisitionSettings.dart';
import 'Home.dart';

class CreateDataAcquisitionPage extends StatefulWidget {
  @override
  _CreateDataAcquisitionPageState createState() => _CreateDataAcquisitionPageState();
}

class _CreateDataAcquisitionPageState extends State<CreateDataAcquisitionPage> {
  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Data Acquisition",
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => DataAcquisitionSettingsPage()));
            },
            icon: Icon(Icons.settings,color: Colors.black54,),
          )
        ],
      ),
      body: OrientationLayoutBuilder(
        portrait: (context) => CreateDataAcquisitionWidget(height: hp(100),width: wp(100),),
      ),
    );
  }
}
