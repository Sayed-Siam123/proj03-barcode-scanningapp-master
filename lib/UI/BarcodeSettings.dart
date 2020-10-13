import 'package:app/UI/Home.dart';
import 'package:app/Widgets/BarcodeSettingsWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeSettings extends StatefulWidget {
  @override
  _BarcodeSettingsState createState() => _BarcodeSettingsState();
}

class _BarcodeSettingsState extends State<BarcodeSettings> {



  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      appBar: AppBar(
        title: Text(
          "Barcode Settings",
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
      ),
      body: OrientationLayoutBuilder(
        portrait: (context) => BarcodeSettingsWidget(height: hp(80), width: wp(100)),
        landscape: (context) => BarcodeSettingsWidget(height: hp(150),width: wp(100),),
      ),
    );
  }

}
