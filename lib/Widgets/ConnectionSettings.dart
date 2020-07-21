import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionSettingsPage extends StatefulWidget {
  @override
  _ConnectionSettingsPageState createState() => _ConnectionSettingsPageState();
}

class _ConnectionSettingsPageState extends State<ConnectionSettingsPage> {

  String deviceId,
      serverip,
      serverlog,
      serverport = "";


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
            "Connection Settings",
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
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(child: LayoutBuilder(
            builder: (BuildContext context,
                BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    //  Flexible(
                    Container(
                      width: 500.00,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Change your settings",
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ExpansionTile(
                                  backgroundColor: Colors.black,
                                  leading: Icon(Icons.link),
                                  title: Text('Connection settings'),
                                  trailing: IconButton(
                                      icon: Icon(Icons.arrow_drop_down_circle),
                                      onPressed: null),
                                  children: <Widget>[

                                    FutureBuilder(
                                        future: getShared(_deviceid),
                                        initialData: false,
                                        builder: (context, snapshot) {


                                          return BeautyTextfield(
                                            width: double.maxFinite,
                                            height: 50.00,
                                            duration: Duration(milliseconds: 300),
                                            inputType: TextInputType.text,
                                            prefixIcon: Icon(
                                                Icons.perm_device_information),
                                            placeholder: snapshot.data==null?"Device ID":snapshot.data.toString(),
                                            onTap: () {
                                              print('Click1');
                                            },
                                            onSubmitted: (data) {
                                              //print(data);

                                              setState(() {
                                                this.deviceId = data;
                                                putShared(_deviceid, this.deviceId);
                                                print(this.deviceId);
                                              });
                                            },
                                          );



//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                        }),


                                    FutureBuilder(
                                        future: getShared(_serverip),
                                        initialData: false,
                                        builder: (context, snapshot) {


                                          return BeautyTextfield(
                                            width: double.maxFinite,
                                            height: 50.00,
                                            duration: Duration(milliseconds: 300),
                                            inputType: TextInputType.text,
                                            prefixIcon: Icon(
                                                Icons.perm_device_information),
                                            placeholder: snapshot.data==null?"Server -IP/Name":snapshot.data.toString(),
                                            onTap: () {
                                              print('Click1');
                                            },
                                            onSubmitted: (data) {
                                              //print(data);

                                              setState(() {
                                                this.serverip = data;
                                                putShared(_serverip, this.serverip);
                                                print(this.serverip);
                                              });
                                            },
                                          );



//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                        }),

                                    FutureBuilder(
                                        future: getShared(_serverport),
                                        initialData: false,
                                        builder: (context, snapshot) {


                                          return BeautyTextfield(
                                            width: double.maxFinite,
                                            height: 50.00,
                                            duration: Duration(milliseconds: 300),
                                            inputType: TextInputType.text,
                                            prefixIcon: Icon(
                                                Icons.perm_device_information),
                                            placeholder: snapshot.data==null?"Server port":snapshot.data.toString(),
                                            onTap: () {
                                              print('Click1');
                                            },
                                            onSubmitted: (data) {
                                              //print(data);

                                              setState(() {
                                                this.serverport = data;
                                                putShared(_serverport, this.serverport);
                                                print(this.serverport);
                                              });
                                            },
                                          );



//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                        }),

                                    FutureBuilder(
                                        future: getShared(_serverlog),
                                        initialData: false,
                                        builder: (context, snapshot) {
                                          return BeautyTextfield(
                                            width: double.maxFinite,
                                            height: 50.00,
                                            duration: Duration(milliseconds: 300),
                                            inputType: TextInputType.text,
                                            prefixIcon: Icon(
                                                Icons.perm_device_information),
                                            placeholder: snapshot.data==null?"Server Log":snapshot.data.toString(),
                                            onTap: () {
                                              print('Click1');
                                            },
                                            onSubmitted: (data) {
                                              //print(data);

                                              setState(() {
                                                this.serverlog = data;
                                                putShared(_serverlog, this.serverlog);
                                                print(this.serverlog);
                                              });
                                            },
                                          );



//                                          return Text(
//                                            snapshot.data.toString()
//                                          );
                                        }),

                                  ],
                                ),
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
////                                    SizedBox(width: 5,),
////
//
//                                  ],
//                                ),
                              ]
                          ),
                        )

                    ),

                  ],

                ),
              );
            }
        )
        )
    );
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
