import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeComparisonSettingsWidget extends StatefulWidget {

  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  BarcodeComparisonSettingsWidget({this.height,this.width,this.scaffoldKey});

  @override
  _BarcodeComparisonSettingsWidgetState createState() => _BarcodeComparisonSettingsWidgetState();
}

class _BarcodeComparisonSettingsWidgetState extends State<BarcodeComparisonSettingsWidget> {

  String _activateKey = "_bar_com_activateKey";
  String _referenceCodeKey = "_referneceCode";
  String _quantityKey = "_quantityKey";

  bool _activate = true;
  bool _referenceCode = true;

  final quantity = new TextEditingController();

  SessionManager prefs = new SessionManager();


  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(hp(3)),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Barcode Comparison",style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                      ),),


                      FutureBuilder(
                        future: getShared(_activateKey),
                        initialData: false,
                        builder: (context, snapshot){
                          return SwitchListTile(
                            title: const Text(
                              'Function is active',
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

                      FutureBuilder(
                        future: getShared(_referenceCodeKey),
                        initialData: false,
                        builder: (context, snapshot){
                          return SwitchListTile(
                            title: const Text(
                              'Reference code',
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

                      Padding(
                        padding: EdgeInsets.only(top: hp(5)),
                        child: Row(
                          children: <Widget>[
                            Text("Quantity of codes to check",style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.00,
                            fontWeight: FontWeight.w600),),
                            SizedBox(width: wp(2),),

                            FutureBuilder(
                              initialData: false,
                              future: getSharedS(_quantityKey),
                              builder: (context, snapshot)
                              {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(wp(2), hp(0), wp(4), 0),
                                  padding: EdgeInsets.fromLTRB(wp(3), hp(1), wp(1), 0),
                                  width: wp(50),
                                  height: hp(6.5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0.0, top: hp(0)),
                                    child: TextField(
                                        controller: quantity,
                                        autocorrect: true,
                                        style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: new InputDecoration(
                                            contentPadding: EdgeInsets.only(left: 0.0, top: hp(1)),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            hintStyle: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            labelStyle: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                            hintText: snapshot.data.toString() == "null" ? "Enter total quantity" : snapshot.data.toString(),
                                            suffixIcon: Padding(
                                              padding: EdgeInsets.only(bottom: hp(1)),
                                              child: IconButton(
                                                tooltip: "press to save",
                                                onPressed: (){
                                                  // putSharedS(_name_idKey,name_id.text.toString());
                                                  setState(() {
                                                    prefs.setData(_quantityKey, quantity.text.toString());
                                                  });
                                                  quantity.text = "";
                                                },
                                                icon: Icon(Icons.check_circle,color: Colors.green.shade500,size: wp(5),),
                                              ),
                                            ),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.only(bottom: hp(1)),
                                            child: IconButton(
                                              tooltip: "Clear Data",
                                              padding: EdgeInsets.only(top: 1),
                                              onPressed: (){
                                                print("clear");
                                                setState(() {
                                                  prefs.setData(_quantityKey,"null");
                                                });
                                              },
                                              icon: Icon(AntDesign.closecircle,color: Colors.red.shade500,size: wp(4),),
                                            ),
                                          )
                                        )),
                                  ),
                                );
                              },
                            ),

                          ],
                        ),
                      )

                    ],
                  )
                ),
              ),
            ],
          ),
        ),
      ),
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

  Future getSharedInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int val = prefs.getInt(key);
    return val;
  }

}
