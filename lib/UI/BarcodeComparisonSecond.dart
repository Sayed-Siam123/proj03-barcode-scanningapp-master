import 'dart:async';

import 'package:app/Widgets/BarcodeComparisonSecondWidget.dart';
import 'package:app/Widgets/BarcodeComparisonWidget.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'BarcodeCompare.dart';
import 'BarcodeComparisonSettings.dart';

class BarcodeComparisonSecond extends StatefulWidget {
  final String mastercode,digits,type;

  BarcodeComparisonSecond({this.digits,this.type,this.mastercode});
  @override
  _BarcodeComparisonSecondState createState() => _BarcodeComparisonSecondState();
}

class _BarcodeComparisonSecondState extends State<BarcodeComparisonSecond> {

  SessionManager prefs = new SessionManager();


  String refernece = "null";
  String _referenceCodeKey = "_referneceCode";

  void getReference() async {
    Future<bool> referenceActivation = prefs.getBoolData(_referenceCodeKey);
    referenceActivation.then((data) async {
      print("reference activation " + data.toString());
      setState(() {
        if (data != null)
          refernece = data.toString();
      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 100),(){
      getReference();
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Barcode Comparison",
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
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BarcodeComparisonSettingsPage()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          )
        ],
      ),

      body: OrientationLayoutBuilder(
        portrait: (context) => BarcodeComparisonSecondWidget(
          height: hp(60),
          width: wp(100),
          mastercode: widget.mastercode,
          digits: widget.digits,
          type: widget.type,
        ),
      ),

      floatingActionButton: refernece == "true" ? FloatingActionButton(
        onPressed: (){
          Navigator.pop(
              context, MaterialPageRoute(builder: (context) => BarcodeComparePage()));
        },
        child: Icon(Icons.repeat),
        backgroundColor: Colors.green.shade500,
      ) : Container(height: 0,width: 0,),

    );
  }
}
