import 'package:app/resources/AudioClass.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeSettingsWidget extends StatefulWidget {

  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  BarcodeSettingsWidget({this.height,this.width,this.scaffoldKey});


  @override
  _BarcodeSettingsWidgetState createState() => _BarcodeSettingsWidgetState();
}

class _BarcodeSettingsWidgetState extends State<BarcodeSettingsWidget> {


  String _cameraKey = "_camera";
  String _code39Key = "_code39";
  String _code128Key = "_code128";
  String _ean13Key = "_ean13";
  String _datamatrixKey = "_datamatrix";
  String _qrcodeKey = "_qrcode";
  String _audioKey = "_audio";


  bool _camera = false;
  bool _code39 = false;
  bool _code128 = false;
  bool _ean13 = false;
  bool _datamatrix = false;
  bool _qrcode = false;

  String _value;

  AudioClass audio = new AudioClass();
  SessionManager prefs =new SessionManager();


  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: wp(100),
            color: Colors.transparent,
            margin: EdgeInsets.fromLTRB(wp(3),hp(3),wp(3),0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Barcode Information Settings",style: TextStyle(
                  fontSize: hp(2),
                  fontWeight: FontWeight.w600,
                ),),
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
                    );
                  },
                ),
              ],
            ),
          ),


          Container(
            width: wp(100),
            color: Colors.transparent,
            margin: EdgeInsets.fromLTRB(wp(3),hp(3),wp(3),0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Read Confirmation",style: TextStyle(
                    fontSize: hp(2),
                    fontWeight: FontWeight.w600,
                ),),

                Padding(
                  padding: EdgeInsets.only(top: hp(3.5)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Select Sound",style: TextStyle(
                            fontSize: 13
                        ),),
                        FutureBuilder(
                          initialData: false,
                          future: getSharedS(_audioKey),
                          builder: (context, snapshot) => Container(
                            height: hp(8),
                            width: wp(50),
                            margin: EdgeInsets.fromLTRB(wp(2), hp(0), wp(2), 0),
                            padding: EdgeInsets.fromLTRB(wp(4), hp(0), wp(1), 0),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(wp(3))),
                            ),
                            child: DropdownButton<String>(
                              underline: Icon(null),
                              isExpanded: true,
                              hint: Text(snapshot.data == null ? "Select Tone" : snapshot.data.toString()),
                              iconSize: 30,
                              value: _value,
                              items: <String>['Tune 1', 'Tune 2', 'Tune 3'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                                print(_value);

                                prefs.setData(_audioKey, _value);

                                if(_value == 'Tune 1'){
                                  audio.play('audios/Tone_1.ogg');
                                }

                                else if(_value == 'Tune 2'){
                                  audio.play('audios/Tone_2.ogg');
                                }

                                else{
                                  audio.play('audios/Tone_3.ogg');
                                }

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ],
      ),
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

  Future getSharedS(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String val = prefs.getString(key);
    return val;
  }

}
