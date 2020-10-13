import 'package:app/Widgets/BarcodeComparisonWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'BarcodeComparisonSettings.dart';
import 'Home.dart';

class BarcodeComparePage extends StatefulWidget {
  @override
  _BarcodeComparePageState createState() => _BarcodeComparePageState();
}

class _BarcodeComparePageState extends State<BarcodeComparePage> {
  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Barcode Comparison",
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
                  context, MaterialPageRoute(builder: (context) => BarcodeComparisonSettingsPage()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          )
        ],
      ),

    body: OrientationLayoutBuilder(
        portrait: (context) => BarcodeComparisonWidget(
          height: hp(60),
          width: wp(100),
        ),
    ),

    );
  }
}
