import 'package:app/Widgets/AboutPageWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'Home.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.9),
      appBar: AppBar(
        title: Text(
          "About",
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
          portrait: (context) => AboutPageWidget(height: hp(80), width: wp(100)),
          landscape: (context) => AboutPageWidget(height: hp(150),width: wp(100),),
      ),
    );
  }
}
