import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFunctionSetWidget extends StatefulWidget {

  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  CustomFunctionSetWidget({this.height,this.width,this.scaffoldKey});

  @override
  _CustomFunctionSetWidgetState createState() => _CustomFunctionSetWidgetState();
}

class _CustomFunctionSetWidgetState extends State<CustomFunctionSetWidget> {

  String _activateKey = "_activate";
  String _timestampKey = "_timestamp";
  String _code128Key = "_code128";
  String _ean13Key = "_ean13";
  String _datamatrixKey = "_datamatrix";
  String _qrcodeKey = "_qrcode";

  bool _activate = false;
  bool _timestamp = true;
  bool _code128 = true;
  bool _ean13 = true;
  bool _datamatrix = true;
  bool _qrcode = true;

  final _name = new TextEditingController();
  final _description = new TextEditingController();
  final _name_id = new TextEditingController();
  final _separator = new TextEditingController();

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
            margin: EdgeInsets.fromLTRB(wp(3),hp(3),wp(3),hp(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Custom Function",style: TextStyle(
                    fontSize: 15,
                  fontWeight: FontWeight.w600
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Name",
                      style: GoogleFonts.exo2(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          top: 0, left: 0, right: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                        padding: const EdgeInsets.only(left: 8.0, top: 3),
                        child: TextField(
                            controller: _name,
                            autocorrect: true,
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 14,
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
                                  fontSize: 14,
                                ),
                              ),
                              labelStyle: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              hintText: "Name",
                            )),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: hp(2),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Description",
                      style: GoogleFonts.exo2(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          top: 0, left: 0, right: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                        padding: const EdgeInsets.only(left: 8.0, top: 3),
                        child: TextField(
                            controller: _description,
                            autocorrect: true,
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 14,
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
                                  fontSize: 14,
                                ),
                              ),
                              labelStyle: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              hintText: "Description",
                            )),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: hp(1),),

                Divider(),

                SizedBox(height: hp(2),),

                FutureBuilder(
                  future: getShared(_timestampKey),
                  initialData: false,
                  builder: (context, snapshot){
                    return SwitchListTile(
                      title: const Text(
                        'Timestamp',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.00,
                            fontWeight: FontWeight.w600),
                      ),
                      value: snapshot.data == null ? _timestamp : snapshot.data,
                      onChanged: (bool value) {
                        print("Current value" + "" +
                            value.toString());
                        setState(() {
                          _timestamp = value;
                          putShared(_timestampKey, _timestamp);
                        });
                      },
                      secondary: const Icon(Icons.view_week),
                    );
                  },
                ),

                SizedBox(
                  height: hp(2),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Separator",
                      style: GoogleFonts.exo2(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          top: 0, left: 0, right: 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
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
                        padding: const EdgeInsets.only(left: 8.0, top: 3),
                        child: TextField(
                            controller: _separator,
                            autocorrect: true,
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 14,
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
                                  fontSize: 14,
                                ),
                              ),
                              labelStyle: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              hintText: "Separator",
                            )),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: hp(3.5)),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("File Format",style: TextStyle(
                            fontSize: 13
                        ),),
                        Container(
                          height: hp(8),
                          width: wp(50),
                          margin: EdgeInsets.fromLTRB(wp(2), hp(0), wp(2), 0),
                          padding: EdgeInsets.fromLTRB(wp(4), hp(1.5), wp(1), 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(wp(3))),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 2,
                                color: Colors.grey.shade400.withOpacity(0.3),
                              )
                            ]
                          ),
                          child: DropdownButton<String>(
                            underline: Icon(null),
                            isExpanded: true,
                            iconSize: 30,
                            items: <String>['jpg', 'pdf', 'csv', 'docx'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: hp(1),),

                Divider(),

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

}
