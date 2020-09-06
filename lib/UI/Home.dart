import 'dart:io';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/UI/Sublist.dart';
import 'package:app/Widgets/HomeWidget.dart';
import 'package:app/Widgets/SystemSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

import 'Login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SessionManager prefs = SessionManager();

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

  bool status = false;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserid();
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
    status = false;
  }

  @override
  Widget build(BuildContext context) {
//    return WillPopScope(
//      // ignore: missing_return
//      onWillPop: (){
//        SystemNavigator.pop();
//        exit(0);
//      },
    return Scaffold(
      key: _scaffoldKey,
      drawer: new Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 35,left:10),
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: status == false
                    ? InkWell(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Back",
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (_scaffoldKey.currentState.isDrawerOpen) {
                            _scaffoldKey.currentState.openEndDrawer();
                          };
                        })
                    : InkWell(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Back",
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            status = false;
                          });
                        }),
                margin: EdgeInsets.only(top: 0),
              ),
              color: Colors.amberAccent,
            ),
            status
                ? ListTile(
                    title: Text(
                      translate('product').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: new Icon(Icons.arrow_forward),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MasterData()),
                      );
                    },
                  )
                : Text(""),
            status
                ? ListTile(
                    title: Text(
                      translate('sublist').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: new Icon(Icons.arrow_forward),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SublistPage()),
                      );
                    },
                  )
                : Text(""),
            status == false
                ? ListTile(
                    title: Text(
                      translate('system_setting').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: new Icon(Icons.arrow_forward),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SystemSettingsPage()),
                      );
                    },
                  )
                : Text(""),
            status == false
                ? ListTile(
                    title: Text(
                      translate('masterdata').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: new Icon(Icons.arrow_forward),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => MasterData()),
                      // );

                      setState(() {
                        status = true;
                      });
                    },
                  )
                : Text(""),
            status == false
                ? ListTile(
                    title: Text(
                      translate('logout').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: new Icon(Icons.power_settings_new),
                    onTap: () {
                      // Update the state of the app.
                      // ...

                      logout();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  )
                : Text(""),
            status ==true ? Divider(): Text(""),
            status ==false
                ? Text(
                    "Version 1.0.1",
                    style: GoogleFonts.exo2(
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                : Text(""),
          ],
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
      //           "assets/images/logo.jpeg",
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
      //               )
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
      //       leading: Icon(Icons.settings,color: Colors.white,),
      //       trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //       content: Text(
      //         translate('system_setting'),
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
      //                 builder: (context) => SystemSettingsPage()));
      //       },
      //     ),
      //     MLMenuItem(
      //       leading: Icon(Icons.power_settings_new,color: Colors.white,),
      //       trailing: Icon(Icons.arrow_right,color: Colors.white,),
      //       content: Text(
      //         translate('logout'),
      //         style: GoogleFonts.exo2(
      //           textStyle: TextStyle(
      //             color: Colors.white,
      //           ),),
      //       ),
      //       onClick: () {
      //         logout();
      //
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => LoginPage()));
      //       },
      //     ),
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
}
