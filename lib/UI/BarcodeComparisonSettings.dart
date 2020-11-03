import 'package:app/UI/BarcodeCompare.dart';
import 'package:app/Widgets/BarcodeComparisonSettingsWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'Home.dart';

class BarcodeComparisonSettingsPage extends StatefulWidget {
  @override
  _BarcodeComparisonSettingsPageState createState() => _BarcodeComparisonSettingsPageState();
}

class _BarcodeComparisonSettingsPageState extends State<BarcodeComparisonSettingsPage> {
  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings Barcode comparison",
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
                context, MaterialPageRoute(builder: (context) => BarcodeComparePage()));
          },
        ),
      ),

      body: OrientationLayoutBuilder(
        portrait: (context) => BarcodeComparisonSettingsWidget(height: hp(100),width: wp(100)),
      ),

    );
  }
}
