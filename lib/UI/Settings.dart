import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _camera = false;
  bool _code39 = false;
  bool _code128 = false;
  bool _ean13 = false;
  bool _datamatrix = false;
  bool _qrcode = false;
  var currentSelectedValue;
  final langtype = ["English", "German", "Chinese"];
  String result = "";

  String deviceId,
      serverip,
      serverlog,
      serverport = "";

  //SharedPreferences prefs = await SharedPreferences.getInstance();
  @override
  initState() {
    _camera = Global.shared.isInstructionView;
    _code39 = Global.shared.isCode39;
    _code128 = Global.shared.isCode128;
    _ean13 = Global.shared.isEan13;
    _datamatrix = Global.shared.isDatamatrix;
    _qrcode = Global.shared.isQrcode;

//    deviceId = Global.shared.isDeviceId;
//    serverip = Global.shared.isServerIp;
//    serverlog = Global.shared.isServerLog;
//    serverport = Global.shared.isServerPort;

    super.initState();
  }

//Language widget
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
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
                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 50.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(
                                          Icons.perm_device_information),
                                      placeholder: "Device ID",
                                      onTap: () {
                                        print('Click1');
                                      },
                                      onSubmitted: (data) {
                                        //print(data);

                                        setState(() {
                                          this.deviceId = data;
                                          print(this.deviceId);
                                        });

                                      },
                                    ),
                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 50.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(
                                          Icons.confirmation_number),
                                      placeholder: "Server -IP/Name",
                                      onTap: () {
                                        print('Click2');
                                      },
                                      onSubmitted: (data) {
                                        print(data);
                                        setState(() {
                                          this.serverip = data;
                                          print(this.serverip);
                                        });
                                      },
                                    ),
                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 50.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(Icons.label_important),
                                      placeholder: "Server port",
                                      onTap: () {
                                        print('Click3');
                                      },
                                      onSubmitted: (data) {
                                        print(data);
                                        setState(() {
                                          this.serverport = data;
                                          print(this.serverport);
                                        });
                                      },
                                    ),


                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 50.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(Icons.launch),
                                      placeholder: "Server log",
                                      onTap: () {
                                        print('Click4');
                                      },
                                      onSubmitted: (data) {
                                        print(data);
                                        setState(() {
                                          serverlog = data;
                                          print(this.serverlog);
                                        });
                                      },

                                    ),


                                  ],
                                ),
//                                Row(
//                                  mainAxisAlignment:MainAxisAlignment.end,
//                                  children: <Widget>[
//                                    RaisedButton(
//                                      child: Text("Clear",style: TextStyle(color: Colors.white),),
//                                      color: Colors.black,
//                                      onPressed: (){
//
//
//                                      },
//                                    ),
//
//                                    SizedBox(width: 5,),
//
//                                    RaisedButton(
//                                      child: Text("Save",style: TextStyle(color: Colors.white),),
//                                      color: Colors.black,
//                                      onPressed: (){
//
//
//                                      },
//                                    ),
//                                  ],
//                                ),
                              ]
                          ),
                        )

                    ),

                    Divider(),

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
                                    SwitchListTile(
                                      title: const Text(
                                        'Camera',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.00,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: _camera,
                                      onChanged: (bool value) {
                                        print("Current value" + "" +
                                            value.toString());
                                        setState(() {
                                          Global.shared.isInstructionView =
                                              value;
                                          _camera = value;
                                          value = !value;
                                          print(
                                              "new value" + _camera.toString());
                                        });
                                      },
                                      secondary: const Icon(Icons.camera_alt),
                                    ),
                                    SwitchListTile(
                                      title: const Text(
                                        'Code 39',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.00,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: _code39,
                                      onChanged: (bool value) {
                                        print("Current value" + "" +
                                            value.toString());
                                        setState(() {
                                          Global.shared.isCode39 = value;
                                          _code39 = value;
                                          value = !value;
                                          print(
                                              "new value" + _code39.toString());
                                        });
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text(
                                        'Code 128',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.00,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: _code128,
                                      onChanged: (bool value) {
                                        print("Current value" + "" +
                                            value.toString());
                                        setState(() {
                                          Global.shared.isCode128 = value;
                                          _code128 = value;
                                          value = !value;
                                          print("new value" +
                                              _code128.toString());
                                        });
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text(
                                        'EAN 13',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.00,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: _ean13,
                                      onChanged: (bool value) {
                                        setState(() {
                                          Global.shared.isEan13 = value;
                                          _ean13 = value;
                                        });
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text(
                                        'Datamatrix',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.00,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: _datamatrix,
                                      onChanged: (bool value) {
                                        setState(() {
                                          Global.shared.isDatamatrix = value;
                                          _datamatrix = value;
                                        });
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text(
                                        'QR code',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.00,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      value: _qrcode,
                                      onChanged: (bool value) {
                                        setState(() {
                                          Global.shared.isQrcode = value;
                                          _qrcode = value;
                                        });
                                      },
                                      secondary: const Icon(Icons.view_week),
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
}

class Global {
  static final shared = Global();
  bool isInstructionView = false;
  bool isCode39 = false;
  bool isCode128 = false;
  bool isEan13 = false;
  bool isDatamatrix = false;
  bool isQrcode = false;

  //Connection setting -----------------------------
//  String isDeviceId = "";
//  String isServerIp = "";
//  String isServerPort = "";
//  String isServerLog = "";
}
