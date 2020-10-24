import 'dart:async';
import 'dart:io';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/UI/Sublist.dart';
import 'package:app/Widgets/HomeWidget.dart';
import 'package:app/UI/SystemSettings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'About.dart';
import 'BarcodeSettings.dart';
import 'CustomFunctionSettings.dart';
import 'Login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SessionManager prefs = SessionManager();

  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;

  Color drawer_color = HexColor("#333333");
  DateTime backbuttonpressedTime;
  String loginKey = "loginKey";
  String useridKey = "userid";
  String userid = "";

  void getUserid() async {
    Future<String> _userid = prefs.getData(useridKey);
    _userid.then((data) {
      print("userid " + data.toString());
      this.userid = data.toString();

      print("USerid: " + userid);
    }, onError: (e) {
      print(e);
    });
  }

  void logout() async {
    prefs.setData(loginKey, "false");
    prefs.setData(useridKey, "-1");
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();
  static const snackBarDuration = Duration(seconds: 3);

  DateTime backButtonPressTime;

  bool status = true;
  bool status1 = false;

  final snackBar = SnackBar(
    content: Text(
      'Double Click to exit app',
      style: GoogleFonts.exo2(
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    duration: snackBarDuration,
  );

  void _openFileExplorer() async {
    try {
      _paths = null;
      _path = await FilePicker.getFilePath(type: FileType.any);
    }
    on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    setState(() {
      _fileName = _path != null ? _path
          .split('/')
          .last : _paths != null ? _paths.keys.toString() : '...';
    });
    print(_fileName.toString());
    print(_path.toString());
  }

  String language = "";

  void getLang() async {
    Future<String> lang = prefs.getData("language_code");
    lang.then((data) async {
      print('lang status pabo');
      print("lang status " + data.toString());

      setState(() {
        language = data.toString();
      });
      print(language.toString());

      if(language == "null"){
        setState(() {
          language = "en";
        });
      }

      else if(language == "en"){
        setState(() {
          language = "en";
        });
      }

      else if(language == "de"){
        setState(() {
          language = "de";
        });
      }

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
    getUserid();

    Timer(Duration(seconds: 1), () {
      getLang();
    });
    print(language);

    masterdata_bloc.fetchAllMasterData();
    masterdata_bloc.fetchAllMasterdatafromDB();

    sublist_bloc.fetchAllManufacData();
    sublist_bloc.fetchAllManufacDatafromDB();

    sublist_bloc.fetchAllCatagoryData();
    sublist_bloc.fetchAllCatDatafromDB();

    sublist_bloc.fetchAllSubCatagoryData();
    sublist_bloc.fetchAllSubCatDatafromDB();

    sublist_bloc.fetchAllUnitData();
    sublist_bloc.fetchAllUnitDatafromDB();

    sublist_bloc.fetchAllMateralPackData();
    sublist_bloc.fetchAllMateralPackDatafromDB();
    status = true;
  }

  @override
  Widget build(BuildContext context) {
//    return WillPopScope(
//      // ignore: missing_return
//      onWillPop: (){
//        SystemNavigator.pop();
//        exit(0);
//      },

  dynamic hp = Screen(context).hp;
  dynamic wp = Screen(context).wp;

  return Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(
        child: Container(
          color: Colors.black87,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                color: Colors.black87,
                child: Container(
                  margin: EdgeInsets.only(top: hp(5)),
                  padding: EdgeInsets.only(bottom: hp(1),left: wp(1)),
                  child: status == true ? InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.arrow_back,size: hp(2),color: Colors.white,),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Back",
                                style: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: hp(2),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            if (_scaffoldKey.currentState.isDrawerOpen) {
                              _scaffoldKey.currentState.openEndDrawer();
                            }
                          }): status1 == true ? InkWell(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_back,size: hp(2),color: Colors.white,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Back",
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: hp(2),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          status = true;
                          status1 = false;
                        });

                      }) : InkWell(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.arrow_back,size: hp(2),color: Colors.white,),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Back",
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: hp(2),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {

                      }),
                ),
              ),

              status == true ? main_options(hp(100),wp(100)): Container(width: 0,height: 0,),
              status1 == true ? settings_options(hp(100),wp(100)): Container(width: 0,height: 0,),
            ],
          ),
        ),
      ),





      // drawer: MultiLevelDrawer(
      //   backgroundColor: drawer_color,
      //   rippleColor: Colors.white,
      //   subMenuBackgroundColor: drawer_color,
      //   divisionColor: Colors.grey,
      //   header: Container(
      //     height: MediaQuery.of(context).size.height * 0.30,
      //     child: Center(
      //         child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Image.asset(
      //           "assets/images/logo.png",
      //           width: 100,
      //           height: 100,
      //         ),
      //         SizedBox(
      //           height: 10,
      //         ),
      //         Text("Version 1.0.1",style: GoogleFonts.exo2(
      //           textStyle: TextStyle(
      //             color: Colors.white,
      //           ),),),
      //       ],
      //     )),
      //   ),
      //   children: [
      //     MLMenuItem(
      //         leading: Icon(Icons.table_chart,color: Colors.white,),
      //         trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //         content: Text(
      //           translate('masterdata'),
      //           style: GoogleFonts.exo2(
      //         textStyle: TextStyle(
      //         color: Colors.white,
      //         ),),
      //         ),
      //         subMenuItems: [
      //           MLSubmenu(
      //               onClick: () {
      //                 Navigator.of(context).pop();
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => MasterData()),
      //                 );
      //               },
      //               submenuContent: Text(
      //                 translate('product'),
      //                 style: GoogleFonts.exo2(
      //                   textStyle: TextStyle(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               ),
      //           ),
      //           MLSubmenu(
      //               onClick: () {
      //                 Navigator.of(context).pop();
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) => SublistPage()));
      //               },
      //               submenuContent: Text(
      //                 translate('sublist'),
      //                 style: GoogleFonts.exo2(
      //                   textStyle: TextStyle(
      //                     color: Colors.white,
      //                   ),
      //                 ),
      //               )),
      //         ],
      //         onClick: () {}),
      //     MLMenuItem(
      //       subMenuItems: [
      //         MLSubmenu(
      //             onClick: () {
      //               Navigator.of(context).pop();
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => SystemSettingsPage()));
      //             },
      //             submenuContent: Text(
      //               "Application Settings",
      //               style: GoogleFonts.exo2(
      //                 textStyle: TextStyle(
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             )
      //         ),
      //         MLSubmenu(
      //             onClick: () {
      //               Navigator.of(context).pop();
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => BarcodeSettings()));
      //             },
      //             submenuContent: Text(
      //               "Barcode Settings",
      //               style: GoogleFonts.exo2(
      //                 textStyle: TextStyle(
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             )),
      //
      //         MLSubmenu(
      //             onClick: () {
      //               Navigator.of(context).pop();
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => CustomFunctionSettingsPage()));
      //             },
      //             submenuContent: Text(
      //               "Custom Application",
      //               style: GoogleFonts.exo2(
      //                 textStyle: TextStyle(
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             )),
      //       ],
      //       leading: Icon(Icons.settings,color: Colors.white,),
      //       trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //       content: Text(
      //         translate('system_setting'),
      //         style: GoogleFonts.exo2(
      //           textStyle: TextStyle(
      //             color: Colors.white,
      //           ),),
      //       ),
      //       onClick: () {},
      //     ),
      //
      //     MLMenuItem(
      //       leading: Icon(Icons.attach_file,color: Colors.white,),
      //       trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //       content: Text(
      //         translate('file_upload'),
      //         style: GoogleFonts.exo2(
      //           textStyle: TextStyle(
      //             color: Colors.white,
      //           ),),
      //       ),
      //       onClick: () {
      //         Navigator.of(context).pop();
      //         _openFileExplorer();
      //         // Navigator.push(
      //         //     context,
      //         //     MaterialPageRoute(
      //         //         builder: (context) => SystemSettingsPage()));
      //       },
      //     ),
      //
      //     MLMenuItem(
      //       leading: Icon(Icons.language,color: Colors.white,),
      //       trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //       content: Text(
      //         "Language",
      //         style: GoogleFonts.exo2(
      //           textStyle: TextStyle(
      //             color: Colors.white,
      //           ),),
      //       ),
      //       onClick: () {
      //         Navigator.of(context).pop();
      //         _showDialog(context);
      //         // Navigator.push(
      //         //     context,
      //         //     MaterialPageRoute(
      //         //         builder: (context) => SystemSettingsPage()));
      //       },
      //     ),
      //
      //     MLMenuItem(
      //       leading: Icon(Icons.language,color: Colors.white,),
      //       trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //       content: Text(
      //         "About",
      //         style: GoogleFonts.exo2(
      //           textStyle: TextStyle(
      //             color: Colors.white,
      //           ),),
      //       ),
      //       onClick: () {
      //         Navigator.of(context).pop();
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => AboutPage()));
      //       },
      //     ),
      //
      //     // MLMenuItem(
      //     //   leading: Icon(Icons.power_settings_new,color: Colors.white,),
      //     //   trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //     //   content: Text(
      //     //     translate('logout'),
      //     //     style: GoogleFonts.exo2(
      //     //       textStyle: TextStyle(
      //     //         color: Colors.white,
      //     //       ),),
      //     //   ),
      //     //   onClick: () {
      //     //     logout();
      //     //
      //     //     Navigator.push(context,
      //     //         MaterialPageRoute(builder: (context) => LoginPage()));
      //     //   },
      //     // ),
      //   ],
      // ),
      appBar: AppBar(
//        title: Text("Home", style: GoogleFonts.exo2(
//          textStyle: TextStyle(
//            fontSize: 20,
//            color: Colors.black54,
//          ),
//        ),),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  translate('home'),
                ))
          ],
        ),

        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        leading: new IconButton(
          icon: new Icon(
            Icons.menu,
            color: Colors.black54,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      body: WillPopScope(
        onWillPop: () => onWillPop(),
        child: HomeWidget(),
      ),
    );
  }

  // ignore: missing_return
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Confirm',
                style: GoogleFonts.exo2(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              content: Text(
                'Do you want to exit the App',
                style: GoogleFonts.exo2(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'No',
                    style: GoogleFonts.exo2(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false); //Will not exit the App
                  },
                ),
                FlatButton(
                  child: Text(
                    'Yes',
                    style: GoogleFonts.exo2(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pop(true); // Will exit the App
                    SystemNavigator.pop();
                    exit(0);
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    //Statement 1 Or statement2
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

    if (backButton) {
      backbuttonpressedTime = currentTime;
      // Fluttertoast.showToast(
      //     msg: "Double Click to exit app",
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white);
      await _scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }
    SystemNavigator.pop();
    exit(0);
    return true;
  }

  _showDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (_) =>

            StatefulBuilder(
              builder: (context, setState) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var height = MediaQuery
                          .of(context)
                          .size
                          .height;
                      var width = MediaQuery
                          .of(context)
                          .size
                          .width;

                      return Container(
                        height: height * 0.3,
                        width: 400,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "CHOOSE LANGUAGE",
                              style: GoogleFonts.exo2(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Card(
                                    child: ListTile(
                                      title: Text("English",
                                        style: GoogleFonts.exo2(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: language== "en"? Colors.white: Colors.black54,
                                        ),),
                                      leading: Image.asset('assets/images/en.png'),
                                      onTap:() {
                                        print("English Lang");
                                        // appLanguage.changeLanguage(Locale("en"));
                                        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                        setState(() {
                                          language = "en";
                                        });
                                        // });
                                        // Navigator.of(context).pop();
                                        // Navigator.pop(context);
                                        changeLocale(context, "en");
                                        prefs.setData("language_code", "en");
                                        Navigator.pop(context);
                                      },
                                    ),
                                    color: language== "en"? Colors.blue: null,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text("German",
                                        style: GoogleFonts.exo2(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: language== "de"? Colors.white: Colors.black54,
                                        ),),
                                      leading: Image.asset('assets/images/de.png'),
                                      onTap:(){
                                        print("German Lang");

                                        // appLanguage.changeLanguage(Locale("de"));
                                        //
                                        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                        setState(() {
                                          language = "de";
                                        });
                                        // });
                                        // Navigator.of(context).pop();
                                        //
                                        // Navigator.pop(context);

                                        changeLocale(context, "de"); //change the language
                                        prefs.setData("language_code", "de");
                                        Navigator.pop(context);

                                      },
                                    ),
                                    color: language== "de"? Colors.blue: null,
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: Text(
                          translate('cancel').toString(),
                          style: GoogleFonts.exo2(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          //_inputcontrol2.text = "";
                          Navigator.pop(context);
                        }),
                  ],
                );
              },
            )

    );
  }

  Widget main_options(height,width) {
    dynamic hp = Hp(height).hp;
    dynamic wp = Wp(width).wp;
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              translate('masterdata').toString(),
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MasterData()),
              );
            },
          ),

          ListTile(
            title: Text(
              "Settings",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MasterData()),
              // );
              setState(() {
                status = false;
                status1 = true;
              });
            },
          ),

          ListTile(
            title: Text(
              "File upload",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MasterData()),
              // );

              Navigator.of(context).pop();
              _openFileExplorer();
            },
          ),


          ListTile(
            title: Text(
              "Language",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.of(context).pop();
              _showDialog(context);
            },
          ),
          Divider(color: Colors.white70,),
          SizedBox(height: hp(1),),
          ListTile(
            title: Text(
              "About",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget settings_options(height,width){
    dynamic hp = Hp(height).hp;
    dynamic wp = Wp(width).wp;
    return Container(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Barcode settings",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarcodeSettings()),
              );
            },
          ),

          ListTile(
            title: Text(
              "Application Settings",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SystemSettingsPage()),
              );
            },
          ),

          ListTile(
            title: Text(
              "Custom settings",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: hp(2),
                  color: Colors.white,
                ),
              ),
            ),
            trailing: new Icon(Icons.arrow_forward,color: Colors.white,size: hp(2),),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomFunctionSettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
