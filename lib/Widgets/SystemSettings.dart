import 'dart:async';

import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/AppLanguage.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/Settings.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemSettingsPage extends StatefulWidget {
  @override
  _SystemSettingsPageState createState() => _SystemSettingsPageState();
}

class _SystemSettingsPageState extends State<SystemSettingsPage> {


  SessionManager prefs = SessionManager();
  Color button_color = HexColor("#b72b45");
  final _formKey = GlobalKey<FormState>();

  String _cameraKey = "_camera";
  String _code39Key = "_code39";
  String _code128Key = "_code128";
  String _ean13Key = "_ean13";
  String _datamatrixKey = "_datamatrix";
  String _qrcodeKey = "_qrcode";

  bool _camera = true;
  bool _code39 = true;
  bool _code128 = true;
  bool _ean13 = true;
  bool _datamatrix = true;
  bool _qrcode = true;
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

  Widget languageDropDown(BuildContext context) {
    //var appLanguage = Provider.of<AppLanguage>(context);
    return Container(
      height: 60.00,
      margin: EdgeInsets.fromLTRB(5,5,5,0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return Builder(
            builder: (context) {
              return InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(translate('select_language').toString(),),
                    value: currentSelectedValue,
                    isDense: true,
                    onChanged: (newValue) async{
                      // setState(() {
                      //   currentSelectedValue = newValue;
                      // });
                      print(newValue);

                      if(newValue == "English"){
                        print("English here");
                        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        //   appLanguage.changeLanguage(Locale("en"));
                        // });
                        setState(() {
                          currentSelectedValue = "English";
                        });
                        changeLocale(context, "en"); //change the language
                        prefs.setData("language_code", "en");
                      }

                      if(newValue == "German"){
                        print("German here");
                        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        //   appLanguage.changeLanguage(Locale("de"));
                        // });
                        setState(() {
                          currentSelectedValue = "German";
                        });
                        changeLocale(context, "de"); //change the language
                        prefs.setData("language_code", "de");
                      }

                    },
                    items: langtype.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate('system_setting').toString(),
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
      body: Container(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // ExpansionTile(
                                  //   leading: Icon(Icons.settings_system_daydream),
                                  //   title: Text(translate('system_setting').toString(),),
                                  //   trailing: IconButton(
                                  //       icon: Icon(Icons.arrow_drop_down_circle),
                                  //       onPressed: null),
                                  //   children: <Widget>[
                                      languageDropDown(context),
                                      Divider(),
                                      FutureBuilder(
                                        future: getShared(_cameraKey),
                                        initialData: false,
                                        builder: (context, snapshot) {
                                          return SwitchListTile(
                                            title: const Text(
                                              'Camera',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.00,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            value: snapshot.data == null ? _camera : snapshot.data,
                                            onChanged: (bool value) {
                                              print("Current value" + " " +
                                                  value.toString());
                                              setState(() {
                                                 _camera = value;
                                                 putShared(_cameraKey, _camera);
                                              });

                                            },
                                            secondary: const Icon(Icons.camera_alt),
                                          );
                                        },
                                      ),
                                      FutureBuilder(
                                        future: getShared(_code39Key),
                                        initialData: false,
                                        builder: (context, snapshot){
                                          return SwitchListTile(
                                            title: const Text(
                                              'Code 39',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.00,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            value: snapshot.data == null ? _code39 : snapshot.data,
                                            onChanged: (bool value) {
                                              print("Current value" + "" +
                                                  value.toString());
                                              setState(() {
                                                _code39 = value;
                                                putShared(_code39Key, _code39);
                                              });
                                            },
                                            secondary: const Icon(Icons.view_week),
                                          );
                                        },
                                      ),
                                      FutureBuilder(
                                        future: getShared(_code128Key),
                                        initialData: null,
                                        builder: (context, snapshot) {
                                          return SwitchListTile(
                                            title: const Text(
                                              'Code 128',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.00,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            value: snapshot.data == null ? _code128 : snapshot.data,
                                            onChanged: (bool value) {
                                              print("Current value" + "" +
                                                  value.toString());
                                              setState(() {
                                                _code128 = value;
                                                putShared(_code128Key, _code128);
                                              });
                                            },
                                            secondary: const Icon(Icons.view_week),
                                          );
                                        },
                                      ),
                                      FutureBuilder(
                                        future: getShared(_ean13Key),
                                        initialData: null,
                                        builder: (context, snapshot) {
                                          return SwitchListTile(
                                            title: const Text(
                                              'EAN 13',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.00,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            value: snapshot.data == null ? _ean13 : snapshot.data,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _ean13 = value;
                                                putShared(_ean13Key, _ean13);
                                              });
                                            },
                                            secondary: const Icon(Icons.view_week),
                                          );
                                        },
                                      ),
                                      FutureBuilder(
                                        future: getShared(_datamatrixKey),
                                        initialData: null,
                                        builder: (context, snapshot) {
                                          return SwitchListTile(
                                            title: const Text(
                                              'Datamatrix',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.00,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            value: snapshot.data == null ? _datamatrix : snapshot.data,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _datamatrix = value;
                                                putShared(_datamatrixKey, _datamatrix);
                                              });
                                            },
                                            secondary: const Icon(Icons.view_week),
                                          );
                                        },
                                      ),
                                      FutureBuilder(
                                        future: getShared(_qrcodeKey),
                                        initialData: null,
                                        builder: (context, snapshot) {
                                          return SwitchListTile(
                                            title: const Text(
                                              'QR code',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12.00,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            value: snapshot.data == null ? _qrcode : snapshot.data,
                                            onChanged: (bool value) {
                                              setState(() {
                                                _qrcode = value;
                                                putShared(_qrcodeKey, _qrcode);
                                              });
                                            },
                                            secondary: const Icon(Icons.view_week),
                                          );
                                        },
                                      ),
                                      Divider(),
                                  //   ],
                                  // ),
                                ]),
                          ),
                    )
                  ],
                ));
          })),
    );
  }

  void putShared(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  Future getShared(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool(key);
    return val;
  }

}
