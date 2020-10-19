import 'dart:async';
import 'dart:io';

import 'package:app/UI/DataAcquision_barcodeAdd.dart';
import 'package:app/UI/Home.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_screen/responsive_screen.dart';

class CreateDataAcquisitionWidget extends StatefulWidget {
  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  CreateDataAcquisitionWidget({this.height, this.width, this.scaffoldKey});

  @override
  _CreateDataAcquisitionWidgetState createState() =>
      _CreateDataAcquisitionWidgetState();
}

class _CreateDataAcquisitionWidgetState extends State<CreateDataAcquisitionWidget> {

  String _separatorKey = "_separator";
  String _fileformatKey = "_fileformat";
  String _sepratorValue,_fileformatValue;

  final filename = new TextEditingController();

  SessionManager prefs = new SessionManager();
  SnackbarHelper snackbar = new SnackbarHelper();

  void getSepartor() async {
    Future<String> serverip = prefs.getData(_separatorKey);
    serverip.then((data) async {
      print('separator status pabo');
      print("separator status " + data.toString());

      setState(() {
        _sepratorValue = data.toString();
      });
      print(_sepratorValue.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  void getFileformat() async {
    Future<String> serverip = prefs.getData(_fileformatKey);
    serverip.then((data) async {
      print('format status pabo');
      print("file format status " + data.toString());

      setState(() {
        _fileformatValue = data.toString();
      });
      print(_fileformatValue.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(microseconds: 50), (){
      getSepartor();
      getFileformat();
    });

  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(top: hp(5),left: wp(2)),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: wp(2)),
                      child: Text("File Name",style: TextStyle(
                        fontSize: hp(2),
                      ),),
                    ),
                    SizedBox(height: hp(1),),
                    Container(
                      margin: EdgeInsets.fromLTRB(wp(2), hp(0), wp(4), hp(1)),
                      padding: EdgeInsets.fromLTRB(wp(3), hp(0), wp(1), 0),
                      width: wp(90),
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
                            autocorrect: true,
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            controller: filename,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0.0, top: hp(0)),
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
                              hintText: "Enter file name",
                            )),
                      ),
                    ),
                    SizedBox(height: hp(2),),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: hp(20),bottom: hp(1)),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: hp(5),
                  width: wp(80),
                  child: RaisedButton(
                    onPressed: (){

                      if(_fileformatValue == "null"){
                        snackbar.snackbarshowAction(context, "Set the file format first", 4, Colors.black87);
                      }

                      else{
                        createFiles(filename.text.toString(),_fileformatValue.toString());
                        snackbar.snackbarshowNormal(context, filename.text.toString()+"."+_fileformatValue.toString()+" created", 4, Colors.black87);

                        Timer(Duration(seconds: 2),(){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => DataAcquisition_barcodeAddPage(file_name: filename.text.toString(),file_format: _fileformatValue.toString(),)));
                        });
                      }

                      //filename.text = "";

                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(wp(2))),
                    ),
                    child: Text("Create",style: TextStyle(
                      fontSize: hp(2),
                      color: Colors.white
                    ),),
                    color: Colors.green.shade500,
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  void createFiles(String name,String format) async { //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir+"/Indentit"; //storageInfo[1] for SD card, getting the root directory

    print(root.toString()+","+name.toString()+","+format.toString());

    final file = await File(root.toString()+"/"+name.toString()+"."+format.toString());
    file.create();
  }
}
