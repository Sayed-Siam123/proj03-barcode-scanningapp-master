import 'package:app/UI/Home.dart';
import 'package:app/Widgets/DataAcquisition_barcodeAddWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

class DataAcquisition_barcodeAddPage extends StatefulWidget {

  String file_name;

  DataAcquisition_barcodeAddPage({this.file_name});

  @override
  _DataAcquisition_barcodeAddPageState createState() => _DataAcquisition_barcodeAddPageState();
}

class _DataAcquisition_barcodeAddPageState extends State<DataAcquisition_barcodeAddPage> {
  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Data Acquisition",
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
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(Icons.settings,color: Colors.black54,),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.description,color: Colors.white),
        backgroundColor: Colors.green.shade500,
      ),
      body: OrientationLayoutBuilder(
        portrait: (context) => DataAcquisition_barcodeAddWidget(height: hp(100),width: wp(100),file_name: widget.file_name,),
      ),
    );
  }
}
