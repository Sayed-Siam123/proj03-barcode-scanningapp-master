import 'dart:async';

import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemSettingsWidget extends StatefulWidget {
  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  SystemSettingsWidget({this.height, this.width, this.scaffoldKey});

  @override
  _SystemSettingsWidgetState createState() => _SystemSettingsWidgetState();
}

class _SystemSettingsWidgetState extends State<SystemSettingsWidget> {
  SessionManager prefs = SessionManager();

  String _cameraKey = "_camera";
  String _code39Key = "_code39";
  String _code128Key = "_code128";
  String _ean13Key = "_ean13";
  String _datamatrixKey = "_datamatrix";
  String _qrcodeKey = "_qrcode";

  bool _camera = true;



  bool _barcodeInfoActivation = false;
  String _barcodeInfoActivationKey = "barcodeInfoActivationKey";

  bool _showDescription = false;
  String _showDescriptionKey = "_showDescription";
  bool _showPrice = false;
  String _showPriceKey = "_showPrice";
  bool _showPictures = false;
  String _showPicturesKey = "_showPictures";
  bool _showBarcodetype = false;
  String _showBarcodeKey = "_showBarcode";
  bool _showNumberofDigits = false;
  String _showNumberofDigitsKey = "_showNumberofDigits";

  bool _quantityField = false;
  String _quantityFieldKey = "_quantityField";
  bool _allowDuplicateCodes = false;
  String _allowDuplicateCodesKey = "_allowDuplicateCodes";
  bool _timeStamp = false;
  String _timeStampKey = "_timeStamp";
  bool _separator = false;
  String _separatorKey = "_separator";
  bool _fileformat = false;
  String _fileformatKey = "_fileformat";
  bool _name_id = false;
  String _name_idKey = "_name_id";

  bool _documentation = false;
  String _documentationKey = "_documentation";

  bool _managePrices = false;
  String _managePricesKey = "_managePrices";

  bool _showPrices = false;
  String _showPricesKey = "_showPrices";

  var currentSelectedValue;
  final langtype = ["English", "German"];

  String result = "";

  String language = "";

  String _sepratorValue = "";
  String _fileformatValue = "";
  final name_id = new TextEditingController();


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
    Timer(Duration(microseconds: 50), () {
      getSepartor();
      getFileformat();
    });
  }


  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return Container(
        child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
          child: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(wp(3)),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                // ExpansionTile(
                //   leading: Icon(Icons.settings_system_daydream),
                //   title: Text(translate('system_setting').toString(),),
                //   trailing: IconButton(
                //       icon: Icon(Icons.arrow_drop_down_circle),
                //       onPressed: null),
                //   children: <Widget>[
                //languageDropDown(hp(10), wp(100), context),
                //Divider(),
                // FutureBuilder(
                //   future: getShared(_cameraKey),
                //   initialData: false,
                //   builder: (context, snapshot) {
                //     return SwitchListTile(
                //       title: const Text(
                //         'Camera',
                //         style: TextStyle(
                //             color: Colors.black,
                //             fontSize: 12.00,
                //             fontWeight: FontWeight.w600),
                //       ),
                //       value: snapshot.data == null ? _camera : snapshot.data,
                //       onChanged: (bool value) {
                //         print("Current value" + " " + value.toString());
                //         setState(() {
                //           _camera = value;
                //           putShared(_cameraKey, _camera);
                //         });
                //       },
                //       secondary: const Icon(Icons.photo_camera),
                //     );
                //   },
                // ),
                // Divider(),

                BarcodeInfo(hp(20), wp(100), context),
                DataAcquisition(hp(20), wp(100), context),
                Data_Synchronization(hp(20), wp(100), context),
                Master_Data(hp(20), wp(100), context),
              ]),
            ),
          )
        ],
      ));
    }));
  }

  Widget BarcodeInfo(height, width, BuildContext context) {
    dynamic hp = Hp(height).hp;
    dynamic wp = Wp(width).wp;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: wp(1.5), top: hp(3), bottom: hp(2)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Barcode Information",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_barcodeInfoActivationKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Function is active',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value:
                  snapshot.data == null ? _barcodeInfoActivation : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _barcodeInfoActivation = value;
                      putShared(_barcodeInfoActivationKey, _barcodeInfoActivation);
                    });
                  },
                );
              },
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_showDescriptionKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Show Description',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value:
                      snapshot.data == null ? _showDescription : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _showDescription = value;
                      putShared(_showDescriptionKey, _showDescription);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_showPriceKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Show Prices',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null ? _showPrice : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _showPrice = value;
                      putShared(_showPriceKey, _showPrice);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_showPicturesKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Show Pictures',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null ? _showPictures : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _showPictures = value;
                      putShared(_showPicturesKey, _showPictures);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_showBarcodeKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Show Barcode Types',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value:
                      snapshot.data == null ? _showBarcodetype : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _showBarcodetype = value;
                      putShared(_showBarcodeKey, _showBarcodetype);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_showNumberofDigitsKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Show Number Of Digits',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null
                      ? _showNumberofDigits
                      : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _showNumberofDigits = value;
                      putShared(_showNumberofDigitsKey, _showNumberofDigits);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget DataAcquisition(height, width, BuildContext context) {
    dynamic hp = Hp(height).hp;
    dynamic wp = Wp(width).wp;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: wp(1.5), top: hp(3), bottom: hp(2)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Data Acquisition",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_quantityFieldKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Quantity Fields',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null ? _quantityField : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _quantityField = value;
                      putShared(_quantityFieldKey, _quantityField);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_allowDuplicateCodesKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Allow Duplicate Codes',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null
                      ? _allowDuplicateCodes
                      : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _allowDuplicateCodes = value;
                      putShared(_allowDuplicateCodesKey, _allowDuplicateCodes);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_timeStampKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Time Stamp',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null ? _timeStamp : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _timeStamp = value;
                      putShared(_timeStampKey, _timeStamp);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(3.5)),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: wp(4)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.view_week,color: Colors.black54,),
                      SizedBox(width: wp(7),),
                      Text("Separator",style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.00,
                          fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                Container(
                  height: hp(23),
                  width: wp(40),
                  margin: EdgeInsets.fromLTRB(wp(2), hp(0), wp(6), 0),
                  padding: EdgeInsets.fromLTRB(wp(4), hp(0), wp(1), 0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(wp(3))),
                  ),
                  child: DropdownButton<String>(
                    underline: Icon(null),
                    isExpanded: true,
                    iconSize: 30,
                    hint: Text(_sepratorValue == "null" ? "Select one" : _sepratorValue.toString()),
                    value: _sepratorValue != "null" ? _sepratorValue : null,
                    items: <String>['/', '-', '|'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _sepratorValue = value;
                        prefs.setData(_separatorKey, _sepratorValue);

                      });
                      print(_sepratorValue);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: hp(10)),
          child: Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: wp(4)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.view_week,color: Colors.black54,),
                      SizedBox(width: wp(7),),
                      Text("File Format",style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.00,
                          fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                Container(
                  height: hp(23),
                  width: wp(40),
                  margin: EdgeInsets.fromLTRB(wp(2), hp(0), wp(6), 0),
                  padding: EdgeInsets.fromLTRB(wp(4), hp(0), wp(1), 0),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.all(Radius.circular(wp(3))),
                  ),
                  child: DropdownButton<String>(
                    underline: Icon(null),
                    isExpanded: true,
                    iconSize: 30,
                    hint: Text(_fileformatValue == "null" ? "Select one" : _fileformatValue.toString()),
                    value: _fileformatValue != "null" ? _fileformatValue : null,
                    items: <String>['pdf', 'csv', 'doc'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _fileformatValue = value;
                        prefs.setData(_fileformatKey, _fileformatValue);
                      });
                      print(_fileformatValue);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: hp(10), bottom: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: wp(3),top: hp(5)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.view_week,color: Colors.black54,),
                      SizedBox(width: wp(7),),
                      Text("Name/ID",style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.00,
                          fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                SizedBox(
                  width: wp(6),
                ),
                FutureBuilder(
                  initialData: false,
                  future: getSharedS(_name_idKey),
                  builder: (context, snapshot)
                  {
                    return Container(
                    margin: EdgeInsets.fromLTRB(wp(12), hp(0), wp(4), 0),
                    padding: EdgeInsets.fromLTRB(wp(3), hp(1), wp(1), 0),
                    width: wp(40),
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
                          controller: name_id,
                          autocorrect: true,
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 0.0, top: hp(9.4)),
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
                            hintText: snapshot.data == null ? "Enter Name/ID" : snapshot.data.toString(),
                            suffixIcon: IconButton(
                              tooltip: "press to save",
                              onPressed: (){
                                // putSharedS(_name_idKey,name_id.text.toString());
                                prefs.setData(_name_idKey, name_id.text.toString());
                                name_id.text = "";
                              },
                              icon: Icon(Icons.check_circle,color: Colors.green.shade500,),
                            )
                          )),
                    ),
                  );
                 },
                ),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget Data_Synchronization(height, width, BuildContext context) {
    dynamic hp = Hp(height).hp;
    dynamic wp = Wp(width).wp;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: wp(1.5), top: hp(3), bottom: hp(2)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Data Synchronization",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_documentationKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Documentation',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null ? _documentation : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _documentation = value;
                      putShared(_documentationKey, _documentation);
                    });
                  },
                );
              },
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget Master_Data(height, width, BuildContext context) {
    dynamic hp = Hp(height).hp;
    dynamic wp = Wp(width).wp;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: wp(1.5), top: hp(3), bottom: hp(2)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Master Data",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hp(1)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FutureBuilder(
              future: getShared(_managePricesKey),
              initialData: false,
              builder: (context, snapshot) {
                return SwitchListTile(
                  title: const Text(
                    'Manage Prices',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.00,
                        fontWeight: FontWeight.w600),
                  ),
                  value: snapshot.data == null ? _managePrices : snapshot.data,
                  onChanged: (bool value) {
                    print("Current value" + " " + value.toString());
                    setState(() {
                      _managePrices = value;
                      putShared(_managePricesKey, _managePrices);
                    });
                  },
                );
              },
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(top: hp(1)),
        //   child: Align(
        //     alignment: Alignment.centerLeft,
        //     child: FutureBuilder(
        //       future: getShared(_showPricesKey),
        //       initialData: false,
        //       builder: (context, snapshot) {
        //         return SwitchListTile(
        //           title: const Text(
        //             'Show Price',
        //             style: TextStyle(
        //                 color: Colors.black,
        //                 fontSize: 12.00,
        //                 fontWeight: FontWeight.w600),
        //           ),
        //           value: snapshot.data == null ? _showPrices : snapshot.data,
        //           onChanged: (bool value) {
        //             print("Current value" + " " + value.toString());
        //             setState(() {
        //               _showPrices = value;
        //               putShared(_showPricesKey, _showPrices);
        //             });
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
        Divider(),
      ],
    );
  }

  // Widget languageDropDown(height, width, BuildContext context) {
  //   //var appLanguage = Provider.of<AppLanguage>(context);
  //
  //   dynamic hp = Hp(height).hp;
  //   dynamic wp = Wp(width).wp;
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.only(top: hp(15), left: wp(2)),
  //         child: Text(
  //           "Select Language",
  //           style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  //         ),
  //       ),
  //       Container(
  //         height: hp(100),
  //         padding: EdgeInsets.all(wp(1)),
  //         margin: EdgeInsets.fromLTRB(wp(2), hp(3), wp(2), 0),
  //         child: FormField<String>(
  //           builder: (FormFieldState<String> state) {
  //             return Builder(
  //               builder: (context) {
  //                 return InputDecorator(
  //                   decoration: InputDecoration(
  //                       border: OutlineInputBorder(
  //                           borderRadius: BorderRadius.circular(5.0))),
  //                   child: DropdownButtonHideUnderline(
  //                     child: DropdownButton<String>(
  //                       hint: Text(
  //                         translate('select_language').toString(),
  //                       ),
  //                       value: currentSelectedValue,
  //                       isDense: true,
  //                       onChanged: (newValue) async {
  //                         // setState(() {
  //                         //   currentSelectedValue = newValue;
  //                         // });
  //                         print(newValue);
  //
  //                         if (newValue == "English") {
  //                           print("English here");
  //                           // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //                           //   appLanguage.changeLanguage(Locale("en"));
  //                           // });
  //                           setState(() {
  //                             currentSelectedValue = "English";
  //                           });
  //                           changeLocale(context, "en"); //change the language
  //                           prefs.setData("language_code", "en");
  //                         }
  //
  //                         if (newValue == "German") {
  //                           print("German here");
  //                           // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //                           //   appLanguage.changeLanguage(Locale("de"));
  //                           // });
  //                           setState(() {
  //                             currentSelectedValue = "German";
  //                           });
  //                           changeLocale(context, "de"); //change the language
  //                           prefs.setData("language_code", "de");
  //                         }
  //                       },
  //                       items: langtype.map((String value) {
  //                         return DropdownMenuItem<String>(
  //                           value: value,
  //                           child: Text(value),
  //                         );
  //                       }).toList(),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
