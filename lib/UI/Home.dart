import 'dart:io';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/UI/Settings.dart';
import 'package:app/Widgets/HomeWidget.dart';
import 'package:app/Widgets/SystemSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  SessionManager prefs = SessionManager();

  String loginKey="loginKey";

  void logout() async {

    prefs.setData(loginKey,"false");

  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const snackBarDuration = Duration(seconds: 3);
  final snackBar = SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );
  DateTime backButtonPressTime;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            DrawerHeader(
              child: Text("IDENTIT",style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),),
              decoration: BoxDecoration(
                color: Colors.amberAccent,
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).translate('system_setting').toString(),style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),),
              trailing: new Icon(Icons.arrow_forward),
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
              title: Text(AppLocalizations.of(context).translate('masterdata').toString(),style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),),
              trailing: new Icon(Icons.arrow_forward),
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
              title: Text(AppLocalizations.of(context).translate('logout').toString(),style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),),
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
            ),

            Divider(),
            Text("Version 1.0.1",style: GoogleFonts.exo2(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),),
          ],
        ),

      ),

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
              'assets/images/logo.jpeg',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
                padding: const EdgeInsets.all(15.0), child: Text(AppLocalizations.of(context).translate('home').toString(),))
          ],

        ),

        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        leading: new IconButton(
          icon: new Icon(Icons.menu, color: Colors.black54,),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),

      body: WillPopScope(
        child: HomeWidget(),
        onWillPop: _onBackPressed,
      ),

    );
  }

  // ignore: missing_return
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm',style: GoogleFonts.exo2(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),),
          content: Text('Do you want to exit the App',style: GoogleFonts.exo2(
            textStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),),
          actions: <Widget>[
            FlatButton(
              child: Text('No',style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),),
              onPressed: () {
                Navigator.of(context).pop(false); //Will not exit the App
              },
            ),
            FlatButton(
              child: Text('Yes',style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),),
              onPressed: () {
                //Navigator.of(context).pop(true); // Will exit the App
                SystemNavigator.pop();
                exit(0);
              },
            )
          ],
        );
      },
    ) ?? false;
  }
}
