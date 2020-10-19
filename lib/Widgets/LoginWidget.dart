import 'dart:async';
import 'dart:convert';

import 'package:app/Bloc/user_bloc.dart';
import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/UserLogin_Success_Model.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/UI/Home.dart';
import 'package:app/Widgets/ConnectionSettings.dart';
import 'package:app/resources/ApiProvider.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Color button_color = HexColor("#b72b45");

  @override
  SessionManager prefs = SessionManager();

  UserLogin_Success_Model fetchedData;

  String loginKey = "loginKey";
  String useridKey = "userid";

  bool loginPress = false;
  bool loginErrorMessage = false;

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();



  String deviceID = "", serverIP = "", serverPort = "", serverLog = "";

  UserLogin_Success_Model success;

  bool _validate1;
  bool _validate2;

  String errortext1 = "*username can\'t be empty";
  String errortext2 = "*password can\'t be empty";

  void getIP() async {
    Future<String> serverip = prefs.getData("_serverip");
    serverip.then((data) {
      print('serverip pabo');
      print("serverip " + data.toString());
      this.serverIP = data.toString();

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  void getPort() async {
    Future<String> serverport = prefs.getData("_serverport");
    serverport.then((data) {
      print("serverport " + data.toString());
      this.serverPort = data.toString();
    }, onError: (e) {
      print(e);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      getIP();
      getPort();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ResponsiveGridRow(
          children: [
            ResponsiveGridCol(
              xs: 12,
              md: 9,
              child: loginPress == false
                  ? Center(
                      child: Column(children: <Widget>[
                        // Padding(
                        //     padding: EdgeInsets.all(10),
                        //     child: Text(
                        //       AppLocalizations.of(context).translate('signin').toString(),
                        //       //'Sign in',
                        //       style: GoogleFonts.exo2(
                        //         fontSize: 35,
                        //         textStyle:
                        //             TextStyle(color: Theme.of(context).accentColor),
                        //       ),
                        //     )),
                        //
                        // Container(
                        //   padding: EdgeInsets.all(10),
                        //   child: new Text(
                        //       AppLocalizations.of(context).translate('signin_desc').toString(),
                        //     style: GoogleFonts.exo2(
                        //       fontSize: 17,
                        //       textStyle:
                        //           TextStyle(color: Theme.of(context).accentColor),
                        //     ),
                        //   ),
                        // ),

                        Container(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          // child: new Text(
                          //     AppLocalizations.of(context).translate('signin_desc').toString(),
                          //   style: GoogleFonts.exo2(
                          //     fontSize: 17,
                          //     textStyle:
                          //         TextStyle(color: Theme.of(context).accentColor),
                          //   ),
                          // ),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 350.0,
                          ),
                        ),

                        SizedBox(
                          height: 70,
                        ),

                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width - 70,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              top: 20, left: 13, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                                controller: emailController,
                                autocorrect: true,
                                style: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 20,
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
                                      fontSize: 16,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  errorText:
                                      _validate1 == false ? errortext1 : null,
                                  prefixIcon: Icon(Icons.account_circle),
                                  hintText: translate('userid_hint').toString(),
                                )),
                          ),
                        ),

                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width - 70,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(
                              top: 20, left: 13, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                                controller: passwordController,
                                autocorrect: true,
                                style: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                obscureText: true,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  errorText:
                                      _validate2 == false ? errortext2 : null,
                                  prefixIcon: Icon(Icons.lock),
                                  hintText:
                                      translate('password_hint').toString(),
                                )),
                          ),
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        Builder(
                          builder: (context) => Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 80,
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                color: button_color,
                                textColor: Colors.white,
                                onPressed: () {
                                  if (emailController.text.isEmpty &&
                                      emailController.text == "") {
                                    print("KHali");

                                    setState(() {
                                      _validate2 = true;
                                      _validate1 = false;
                                    });

                                    //TODO:: Toast hobe ekta
                                  } else if (passwordController.text.isEmpty &&
                                      passwordController.text == "") {
                                    print("eitao KHali");

                                    setState(() {
                                      _validate1 = true;
                                      _validate2 = false;
                                    });

                                    //TODO:: Toast hobe ekta
                                  } else {
                                    setState(() {
                                      _validate1 = true;
                                      _validate2 = true;
                                    });
                                  }
                                  print("Vora");

                                  if (serverIP == "null" &&
                                      serverPort == "null") {
                                    print("Please enter ip and port first");
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      action: SnackBarAction(
                                        label: 'Connection Settings',
                                        textColor: Colors.blue,
                                        onPressed: () {
                                          // some code
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ConnectionSettingsPage()));
                                        },
                                      ),
                                      content: Text(
                                        'Please set Connection Settings First',
                                        style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      duration: Duration(seconds: 4),
                                    ));
                                  } else {
                                    print("Server ip and port remains");

                                    print(emailController.text);
                                    print(passwordController.text);
                                    // userbloc.getemail(emailController.text);
                                    // userbloc.getpass(passwordController.text);

                                    if (_validate1 && _validate2) {
                                      // Navigator.push(context,
                                      //   MaterialPageRoute(builder: (context) => HomePage()),
                                      // );
                                      ApiProvider apiprovider = new ApiProvider();
                                      Timer(Duration(microseconds: 50), () async {
                                        success = await apiprovider.userLogin(emailController.text.toString(), passwordController.text.toString());

                                        Timer(Duration(microseconds: 100), () async {
                                          print(success.success.toString());

                                          // SweetAlert.show(
                                          //   context,
                                          //   title: "Singing In",
                                          //   subtitle: "Please wait.. logging in",
                                          //   //TODO:: SWEET ALERT EXAMPLE
                                          //   style: SweetAlertStyle.loading,
                                          // );


                                          if (success != null) {
                                              if (success.success == true) {
                                                  prefs.setData(loginKey, "true");
                                                  prefs.setData(useridKey, success.id==null ? "-1" : success.id.toString());
                                                  SnackbarHelper snackbar = new SnackbarHelper();
                                                  snackbar.snackbarshowNormal(context, 'Logging in, Please wait...', 4, Colors.black87);
                                                  print('Email / pass matched successfully');
                                                  emailController.text = "";
                                                  passwordController.text = "";
                                                  Timer(Duration(seconds: 2), () {
                                                    Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => HomePage()),
                                                    );
                                                  });
                                              }

                                              else{
                                                print('Email / pass not matched');
                                                emailController.text = "";
                                                passwordController.text = "";

                                                setState(() {
                                                  loginPress = false;
                                                });

                                                // Scaffold.of(context)
                                                //     .showSnackBar(
                                                //     SnackBar(
                                                //       content: Text(
                                                //         'Email / pass not matched',
                                                //         style: GoogleFonts
                                                //             .exo2(
                                                //           textStyle:
                                                //           TextStyle(
                                                //             fontSize: 16,
                                                //             color: Colors
                                                //                 .white,
                                                //           ),
                                                //         ),
                                                //       ),
                                                //       duration: Duration(
                                                //           seconds: 4),
                                                //     ));

                                                SnackbarHelper snackbar = new SnackbarHelper();
                                                snackbar.snackbarshowNormal(context, 'Email / pass not matched', 4, Colors.black87);
                                              }
                                            }
                                            else{
                                              emailController.text = "";
                                              passwordController.text = "";
                                              print('Empty');
                                            }
                                        });

                                      });



                                      // Timer(Duration(seconds: 2), () async {
                                      //   if (success != null) {
                                      //     if (success.success == true) {
                                      //         prefs.setData(loginKey, "true");
                                      //         prefs.setData(useridKey, success.id==null ? "-1" : success.id.toString());
                                      //         print('Email / pass matched successfully');
                                      //         emailController.text = "";
                                      //         passwordController.text = "";
                                      //
                                      //         SnackbarHelper snackbar = new SnackbarHelper();
                                      //         snackbar.snackbarshowNormal(context, 'Logging in, Please wait...', 4, Colors.black87);
                                      //         Timer(Duration(seconds: 1), () {
                                      //           Navigator.push(context,
                                      //             MaterialPageRoute(builder: (context) => HomePage()),
                                      //           );
                                      //         });
                                      //     }
                                      //
                                      //     else{
                                      //       print('Email / pass not matched');
                                      //       emailController.text = "";
                                      //       passwordController.text = "";
                                      //
                                      //       // setState(() {
                                      //       //   loginPress = false;
                                      //       // });
                                      //
                                      //       // Scaffold.of(context)
                                      //       //     .showSnackBar(
                                      //       //     SnackBar(
                                      //       //       content: Text(
                                      //       //         'Email / pass not matched',
                                      //       //         style: GoogleFonts
                                      //       //             .exo2(
                                      //       //           textStyle:
                                      //       //           TextStyle(
                                      //       //             fontSize: 16,
                                      //       //             color: Colors
                                      //       //                 .white,
                                      //       //           ),
                                      //       //         ),
                                      //       //       ),
                                      //       //       duration: Duration(
                                      //       //           seconds: 4),
                                      //       //     ));
                                      //
                                      //       SnackbarHelper snackbar = new SnackbarHelper();
                                      //       snackbar.snackbarshowNormal(context, 'Email / pass not matched', 4, Colors.black87);
                                      //     }
                                      //   }
                                      //   else{
                                      //     emailController.text = "";
                                      //     passwordController.text = "";
                                      //     print('Empty');
                                      //   }
                                      // });



                                    } else {
                                      print("set your connection first");
                                    }
                                  }

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => HomePage()),);
                                },
                                child: Text(
                                  translate('login_button')
                                      .toString()
                                      .toUpperCase(),
                                  style: GoogleFonts.exo2(
                                    fontSize: 17,
                                    textStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //loginErrorMessage==true? Text("*Incorrect UserID or Password!",style:TextStyle(color: Colors.red),) : Text(""),
                      ]),
                    )
                  : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Logging in...")
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
