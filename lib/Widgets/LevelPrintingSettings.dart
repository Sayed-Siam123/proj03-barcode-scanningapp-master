import 'package:app/UI/Home.dart';
import 'package:app/UI/LevelPrinting.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LevelPrintingSettingsPage extends StatefulWidget {
  @override
  _LevelPrintingSettingsPageState createState() => _LevelPrintingSettingsPageState();
}

class _LevelPrintingSettingsPageState extends State<LevelPrintingSettingsPage> {


  String _activateKey = "_LevelPrintActivate";
  String _barcodeformatKey = "_barcodeformat";
  String _printPriceKey = "_printPrice";
  String _referenceCodeKey = "_referenceCode";
  String _datamatrixKey = "_datamatrix";
  String _qrcodeKey = "_qrcode";

  bool _activate = false;
  String _barcodeformatValue;
  bool _printPrice = false;
  bool _referenceCode = false;
  bool _datamatrix = true;
  bool _qrcode = true;

  final _name = new TextEditingController();
  final _description = new TextEditingController();
  final _name_id = new TextEditingController();
  final _separator = new TextEditingController();

  SessionManager prefs = new SessionManager();

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    final orientation = MediaQuery.of(context).orientation;

    dynamic size = MediaQuery.of(context).size;
    dynamic deviceRatio = size.width / size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Level Printing Settings",
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
                context,
                MaterialPageRoute(
                    builder: (context) => LevelPrintingPage()));
          },
        ),
      ),

      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            color: Colors.transparent,
            margin: EdgeInsets.all(hp(2)),
            padding: EdgeInsets.all(hp(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Barcode label",style: TextStyle(
                  fontSize: hp(2),
                ),),
                FutureBuilder(
                  future: getShared(_activateKey),
                  initialData: false,
                  builder: (context, snapshot){
                    return SwitchListTile(
                      title: const Text(
                        'Function activation',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.00,
                            fontWeight: FontWeight.w600),
                      ),
                      value: snapshot.data == null ? _activate : snapshot.data,
                      onChanged: (bool value) {
                        print("Current value" + "" +
                            value.toString());
                        setState(() {
                          _activate = value;
                          putShared(_activateKey, _activate);
                        });
                      },
                      secondary: const Icon(Icons.view_week),
                    );
                  },
                ),

                SizedBox(height: hp(1),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: wp(4)),
                      child: Row(
                        children: [
                          Icon(Icons.view_week,color: Colors.black45,),
                          SizedBox(width: wp(7.5),),
                          Text("Barcode type",style: TextStyle(
                            fontSize: hp(1.5),
                            fontWeight: FontWeight.w600
                          ),
                         ),
                        ],
                      ),
                    ),
                    Container(
                      height: hp(6),
                      width: wp(30),
                      margin: EdgeInsets.fromLTRB(wp(2), hp(0), wp(6), 0),
                      padding: EdgeInsets.fromLTRB(wp(4), hp(.5), wp(1), 0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(wp(3))),
                      ),
                      child: DropdownButton<String>(
                        underline: Icon(null),
                        isExpanded: true,
                        iconSize: 30,
                        value: _barcodeformatValue != "null" ? _barcodeformatValue : null,
                        items: <String>['code 128', '2D Datamatrix'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _barcodeformatValue = value;
                            prefs.setData(_barcodeformatKey, _barcodeformatValue);
                          });
                          print(_barcodeformatValue);
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: hp(1),),

                FutureBuilder(
                  future: getShared(_printPriceKey),
                  initialData: false,
                  builder: (context, snapshot){
                    return SwitchListTile(
                      title: const Text(
                        'Show price',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.00,
                            fontWeight: FontWeight.w600),
                      ),
                      value: snapshot.data == null ? _printPrice : snapshot.data,
                      onChanged: (bool value) {
                        print("Current value" + "" +
                            value.toString());
                        setState(() {
                          _printPrice = value;
                          putShared(_printPriceKey, _printPrice);
                        });
                      },
                      secondary: const Icon(Icons.view_week),
                    );
                  },
                ),

                SizedBox(height: hp(1),),
                Divider(),
                SizedBox(height: hp(1),),
                Text("Reference Label",style: TextStyle(
                  fontSize: hp(2),
                ),),

                FutureBuilder(
                  future: getShared(_referenceCodeKey),
                  initialData: false,
                  builder: (context, snapshot){
                    return SwitchListTile(
                      title: const Text(
                        'Use reference code',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.00,
                            fontWeight: FontWeight.w600),
                      ),
                      value: snapshot.data == null ? _referenceCode : snapshot.data,
                      onChanged: (bool value) {
                        print("Current value" + "" +
                            value.toString());
                        setState(() {
                          _referenceCode = value;
                          putShared(_referenceCodeKey, _referenceCode);
                        });
                      },
                      secondary: const Icon(Icons.view_week),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      )
    );
  }

  void putShared(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  void putSharedS(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
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
