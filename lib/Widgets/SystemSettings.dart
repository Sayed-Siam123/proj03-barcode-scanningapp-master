import 'package:app/UI/Settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemSettingsPage extends StatefulWidget {
  @override
  _SystemSettingsPageState createState() => _SystemSettingsPageState();
}

class _SystemSettingsPageState extends State<SystemSettingsPage> {

  final _formKey = GlobalKey<FormState>();

  String _cameraKey = "_camera";
  String _code39Key = "_code39";
  String _code128Key = "_code128";
  String _ean13Key = "_ean13";
  String _datamatrixKey = "_datamatrix";
  String _qrcodeKey = "_qrcode";

  bool _camera = false;
  bool _code39 = false;
  bool _code128 = false;
  bool _ean13 = false;
  bool _datamatrix = false;
  bool _qrcode = false;
  var currentSelectedValue;
  final langtype = ["English", "German", "Chinese"];

  String result = "";
  @override
  initState() {

//    deviceId = Global.shared.isDeviceId;
//    serverip = Global.shared.isServerIp;
//    serverlog = Global.shared.isServerLog;
//    serverport = Global.shared.isServerPort;

    super.initState();
  }

  Widget languageDropDown() {
    return Container(
      height: 60.00,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Select Language"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                  print(currentSelectedValue);
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "System Settings",
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
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
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
                          child:
                          Column(mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ExpansionTile(
                                  leading: Icon(Icons.settings_system_daydream),
                                  title: Text('System settings'),
                                  trailing: IconButton(
                                      icon: Icon(Icons.arrow_drop_down_circle),
                                      onPressed: null),
                                  children: <Widget>[
                                    languageDropDown(),
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
                                  ],
                                ),
                              ]),
                        ))
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
