import 'package:app/Widgets/SystemSettingWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'CreateDataAcquisition.dart';

class DataAcquisitionSettingsPage extends StatefulWidget {
  @override
  _DataAcquisitionSettingsPageState createState() => _DataAcquisitionSettingsPageState();
}

class _DataAcquisitionSettingsPageState extends State<DataAcquisitionSettingsPage> {
  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Application Settings",
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
                  context, MaterialPageRoute(builder: (context) => CreateDataAcquisitionPage()));
            },
          ),
        ),
        body: OrientationLayoutBuilder(
          portrait: (context) => SystemSettingsWidget(height: hp(100),width: wp(100),),
        )
    );
  }
}
