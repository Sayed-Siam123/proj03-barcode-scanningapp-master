import 'dart:io';

import 'package:app/Bloc/user_bloc.dart';
import 'package:app/Handler/AppLanguage.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/UI/Settings.dart';
import 'package:app/Widgets/ConnectionSettings.dart';
import 'package:app/Widgets/LoginWidget.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLang();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userbloc.dispose();
  }

  void getLang() async {
    Future<String> lang = prefs.getData("language_code");
    lang.then((data) async {
      print('lang status pabo');
      print("lang status " + data.toString());

      setState(() {
        language = data.toString();
      });
      print(language.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }



  SessionManager prefs = SessionManager();
  String language = "";

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
        appBar: AppBar(
          title: new Text(AppLocalizations.of(context).translate('login_title').toString(),
            style: GoogleFonts.exo2(
              textStyle: TextStyle(color: Theme
                  .of(context)
                  .accentColor),
            ),),
          leading: new IconButton(
            icon: new Icon(Icons.settings, color: Colors.black54,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConnectionSettingsPage()),
              );
            },

          ),
          backgroundColor: Colors.white,
          actions: [
            new IconButton(
                icon: new Icon(Icons.language, color: Colors.black54,),
                onPressed: () {
                  print("hahas");

                  _showDialog();

                }

            ),
            new IconButton(
                icon: new Icon(Icons.exit_to_app, color: Colors.black54,),
                onPressed: () {
                  exit(0);

                  //Navigator.popUntil(context, ModalRoute.withName('/'));
                  Navigator.pop(
                      context, true); // It worked for me instead of above line
//                  Navigator.pushReplacement(
//                    context, MaterialPageRoute(builder: (context) => MyApp()),);
                }


            ),

          ],
          centerTitle: true,
          elevation: 0.0,
        ),

        body: Center(

            child: LoginWidget()
        )

    );
  }

  _showDialog() async {
    var appLanguage = Provider.of<AppLanguage>(context);
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
                                      onTap:(){
                                        print("English Lang");
                                        appLanguage.changeLanguage(Locale("en"));
                                        setState(() {
                                          language = "en";
                                        });
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
                                        appLanguage.changeLanguage(Locale("de"));
                                        setState(() {
                                          language = "de";
                                        });
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
                          AppLocalizations.of(context).translate('cancel').toString(),
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
}