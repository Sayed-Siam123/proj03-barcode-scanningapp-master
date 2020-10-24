import 'dart:async';

import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/AppLanguage.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/Settings.dart';
import 'package:app/Widgets/SystemSettingWidget.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemSettingsPage extends StatefulWidget {
  @override
  _SystemSettingsPageState createState() => _SystemSettingsPageState();
}

class _SystemSettingsPageState extends State<SystemSettingsPage> {


  SessionManager prefs = SessionManager();
  Color button_color = HexColor("#b72b45");
  final _formKey = GlobalKey<FormState>();


  var currentSelectedValue;
  final langtype = ["English", "German"];

  String result = "";

  String language = "";

  void getLang() async {
    Future<String> lang = prefs.getData("language_code");
    lang.then((data) async {
      print('lang status pabo');
      print("lang status " + data.toString());

      setState(() {
        language = data.toString();
      });
      print(language.toString());

      if(language =="null"){
        setState(() {
          currentSelectedValue = "English";
        });
        print(currentSelectedValue);
      }

      else if(language == "en"){
        setState(() {
          currentSelectedValue = "English";
        });
        print(currentSelectedValue);
      }

      else if(language == "de"){
        setState(() {
          currentSelectedValue = "German";
        });
        print(currentSelectedValue);
      }

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }


  @override
  initState() {

//    deviceId = Global.shared.isDeviceId;
//    serverip = Global.shared.isServerIp;
//    serverlog = Global.shared.isServerLog;
//    serverport = Global.shared.isServerPort;

    super.initState();
    Timer(Duration(seconds: 1), () {
      getLang();
    });
  }

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
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: OrientationLayoutBuilder(
        portrait: (context) => SystemSettingsWidget(height: hp(100),width: wp(100),),
      )
    );
  }

}
