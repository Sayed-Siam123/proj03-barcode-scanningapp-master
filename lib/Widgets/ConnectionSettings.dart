import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionSettingsPage extends StatefulWidget {
  @override
  _ConnectionSettingsPageState createState() => _ConnectionSettingsPageState();
}

class _ConnectionSettingsPageState extends State<ConnectionSettingsPage> {
  String deviceid, server_ip, server_log, server_port;

  Color button_color = HexColor("#b72b45");

  TextEditingController device_id = new TextEditingController();
  TextEditingController serverip = new TextEditingController();
  TextEditingController serverlog = new TextEditingController();
  TextEditingController serverport = new TextEditingController();

  String data = "";

  String _deviceid = "_deviceid";
  String _serverip = "_serverip";
  String _serverport = "_serverport";
  String _serverlog = "_serverlog";

  // ignore: non_constant_identifier_names

  @override
  void initState() {
    super.initState();
//    const MethodChannel('plugins.flutter.io/shared_preferences')
//        .setMockMethodCallHandler(
//          (MethodCall methodcall) async {
//        if (methodcall.method == 'getAll') {
//          return {"flutter." + _deviceid: "[ No Name Saved ]"};
//        }
//        return null;
//      },
//    );
//    setData();
  }

//  Future<bool> saveData() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    return await preferences.setString(_deviceid, deviceId.toString());
//  }
//
//  Future<String> loadData() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    return preferences.getString(_deviceid);
//  }
//
//  setData() {
//    loadData().then((value) {
//      setState(() {
//        data = value;
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            translate('connection_settings_title').toUpperCase().toString(),
            style: GoogleFonts.exo2(
              textStyle: TextStyle(color: Theme.of(context).accentColor),
            ),
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
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                      padding: EdgeInsets.all(20),
                        child: Column(mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                          // ExpansionTile(
                          //   backgroundColor: Colors.white,
                          //   leading: Icon(Icons.link),
                          //   title: Text(
                          //     'Connection settings',
                          //     style: GoogleFonts.exo2(
                          //       textStyle: TextStyle(
                          //         fontSize: 18,
                          //       ),
                          //     ),
                          //   ),
                          //   trailing: IconButton(
                          //       icon: Icon(Icons.arrow_drop_down_circle),
                          //       onPressed: null),
                          //   children: <Widget>[
                              FutureBuilder(
                                  future: getShared(_deviceid),
                                  initialData: false,
                                  builder: (context, snapshot) {
//                                          return BeautyTextfield(
//                                            width: double.maxFinite,
//                                            height: 50.00,
//                                            duration: Duration(milliseconds: 300),
//                                            inputType: TextInputType.text,
//                                            prefixIcon: Icon(
//                                                Icons.perm_device_information),
//                                            placeholder: snapshot.data==null?"Device ID":snapshot.data.toString(),
//                                            onTap: () {
//                                              print('Click1');
//                                            },
//                                            onSubmitted: (data) {
//                                              //print(data);
//
//                                              setState(() {
//                                                this.deviceId = data;
//                                                putShared(_deviceid, this.deviceId);
//                                                print(this.deviceId);
//                                              });
//                                            },
//                                          );

                                    return Container(
                                      height: 58,
                                      width:
                                          MediaQuery.of(context).size.width - 87,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 13, right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: TextField(
                                            controller: device_id,
                                            autocorrect: true,
                                            style: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              labelStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              prefixIcon: Icon(
                                                  Icons.perm_device_information),
                                              hintText: snapshot.data == null
                                                  ? translate('device_id').toString()
                                                  : snapshot.data.toString(),
                                            )),
                                      ),
                                    );

//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                  }),
                              FutureBuilder(
                                  future: getShared(_serverip),
                                  initialData: false,
                                  builder: (context, snapshot) {
//                                          return BeautyTextfield(
//                                            width: double.maxFinite,
//                                            height: 50.00,
//                                            duration: Duration(milliseconds: 300),
//                                            inputType: TextInputType.text,
//                                            prefixIcon: Icon(
//                                                Icons.perm_device_information),
//                                            placeholder: snapshot.data==null?"Server -IP/Name":snapshot.data.toString(),
//                                            onTap: () {
//                                              print('Click1');
//                                            },
//                                            onSubmitted: (data) {
//                                              //print(data);
//
//                                              setState(() {
//                                                this.serverip = data;
//                                                putShared(_serverip, this.serverip);
//                                                print(this.serverip);
//                                              });
//                                            },
//                                          );

                                    return Container(
                                      height: 58,
                                      width:
                                          MediaQuery.of(context).size.width - 87,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 13, right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: TextField(
                                            controller: serverip,
                                            autocorrect: true,
                                            style: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            decoration: new InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.confirmation_number),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              labelStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              hintText: snapshot.data == null
                                                  ? translate('server_ip').toString()
                                                  : snapshot.data.toString(),
                                            )),
                                      ),
                                    );

//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                  }),
                              FutureBuilder(
                                  future: getShared(_serverport),
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    return Container(
                                      height: 58,
                                      width:
                                          MediaQuery.of(context).size.width - 87,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 13, right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: TextField(
                                            controller: serverport,
                                            autocorrect: true,
                                            style: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            decoration: new InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.label_important),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              labelStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              hintText: snapshot.data == null
                                                  ? translate('server_port').toString()
                                                  : snapshot.data.toString(),
                                            )),
                                      ),
                                    );

//                                          return BeautyTextfield(
//                                            width: double.maxFinite,
//                                            height: 50.00,
//                                            duration: Duration(milliseconds: 300),
//                                            inputType: TextInputType.text,
//                                            prefixIcon: Icon(
//                                                Icons.perm_device_information),
//                                            placeholder: snapshot.data==null?"Server port":snapshot.data.toString(),
//                                            onTap: () {
//                                              print('Click1');
//                                            },
//                                            onSubmitted: (data) {
//                                              //print(data);
//
//                                              setState(() {
//                                                this.serverport = data;
//                                                putShared(_serverport, this.serverport);
//                                                print(this.serverport);
//                                              });
//                                            },
//                                          );

//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                  }),
                              FutureBuilder(
                                  future: getShared(_serverlog),
                                  initialData: false,
                                  builder: (context, snapshot) {
//                                          return BeautyTextfield(
//                                            width: double.maxFinite,
//                                            height: 50.00,
//                                            duration: Duration(milliseconds: 300),
//                                            inputType: TextInputType.text,
//                                            prefixIcon: Icon(
//                                                Icons.perm_device_information),
//                                            placeholder: snapshot.data==null?"Server Log":snapshot.data.toString(),
//                                            onTap: () {
//                                              print('Click1');
//                                            },
//                                            onSubmitted: (data) {
//                                              //print(data);
//
//                                              setState(() {
//                                                this.serverlog = data;
//                                                putShared(_serverlog, this.serverlog);
//                                                print(this.serverlog);
//                                              });
//                                            },
//                                          );

                                    return Container(
                                      height: 58,
                                      width:
                                          MediaQuery.of(context).size.width - 87,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          top: 10, left: 13, right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: TextField(
                                            controller: serverlog,
                                            autocorrect: true,
                                            style: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            decoration: new InputDecoration(
                                              prefixIcon: Icon(Icons.launch),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              labelStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              hintText: snapshot.data == null
                                                  ? translate('server_log').toString()
                                                  : snapshot.data.toString(),
                                            )),
                                      ),
                                    );

//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                  }),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width - 90,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Text(
                                    translate('save').toUpperCase().toString(),
                                    style: GoogleFonts.exo2(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  color: button_color,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  onPressed: () {
                                    //print(device_id.text);

                                    if (device_id.text.isNotEmpty) {
                                      print(device_id.text);

                                      setState(() {
                                        deviceid = device_id.text;
                                      });

                                      putShared(
                                          _deviceid, device_id.text.toString());
                                      device_id.text = "";
                                    }

                                    if (serverip.text.isNotEmpty) {
                                      print(serverip.text);
                                      setState(() {
                                        server_ip = serverip.text;
                                      });
                                      putShared(
                                          _serverip, serverip.text.toString());
                                      serverip.text = "";
                                    }

                                    if (serverport.text.isNotEmpty) {
                                      print(serverport.text);
                                      setState(() {
                                        server_port = serverport.text;
                                      });
                                      putShared(_serverport,
                                          serverport.text.toString());
                                      serverport.text = "";
                                    }

                                    if (serverlog.text.isNotEmpty) {
                                      print(serverlog.text);

                                      setState(() {
                                        server_log = serverlog.text;
                                      });

                                      putShared(
                                          _serverlog, serverlog.text.toString());
                                      serverlog.text = "";
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                          //   ],
                          // ),
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.end,
//                                  children: <Widget>[
//
////                                    FutureBuilder(
////                                        future: getShared(_deviceid),
////                                        initialData: false,
////                                        builder: (context, snapshot) {
////
////
////
//////                                          return Text(
//////                                            snapshot.data.toString()
//////                                          );
////                                        }),
//
////
//
//                                  ],
//                                ),
                        ]),
                      ),
                ),
              ],
            ),
          );
        })));
  }

  void putShared(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  Future getShared(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String val = prefs.getString(key);
    return val;
  }
}
