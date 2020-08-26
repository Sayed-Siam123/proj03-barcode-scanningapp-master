import 'dart:convert';

import 'package:app/Bloc/user_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/UserLogin_Success_Model.dart';
import 'package:app/Resources/SharedPrefer.dart';
import 'package:app/UI/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  SessionManager prefs = SessionManager();

  UserLogin_Success_Model fetchedData;

  String loginKey = "loginKey";

  bool loginPress = false;

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _validate1;
  bool _validate2;

  String errortext1 = "*username can\'t be empty";
  String errortext2 = "*password can\'t be empty";

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: loginPress == false
            ? Center(
                child: Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        AppLocalizations.of(context).translate('title').toString(),
                        //'Sign in',
                        style: GoogleFonts.exo2(
                          fontSize: 35,
                          textStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                        ),
                      )),

                  Container(
                    padding: EdgeInsets.all(10),
                    child: new Text(
                      "Please fill out the below fields to login",
                      style: GoogleFonts.exo2(
                        fontSize: 17,
                        textStyle:
                            TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 70,
                  ),

                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 70,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, left: 13, right: 10),
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
                            errorText: _validate1 == false ? errortext1 : null,
                            prefixIcon: Icon(Icons.account_circle),
                            hintText: "Enter Your User ID Here",
                          )),
                    ),
                  ),

                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 70,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, left: 13, right: 10),
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
                            errorText: _validate2 == false ? errortext2 : null,
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter Your password Here",
                          )),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 80,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Colors.green,
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

                          print(emailController.text);
                          print(passwordController.text);

                          userbloc.getemail(emailController.text);
                          userbloc.getpass(passwordController.text);
//
//

                          if (_validate1 && _validate2) {
                            setState(() {
                              loginPress = true;
                            });
                            userbloc.userlogin();
                            print(loginPress);

                            prefs.setData(loginKey, "true");
                          }

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),);
                        },
                        child: Text(
                          "Login".toUpperCase(),
                          style: GoogleFonts.exo2(
                            fontSize: 17,
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),

//                loginPress ? Container(
//                  child: Container(
//                      child: Container(
//                        margin: EdgeInsets.all(10),
//                        child: StreamBuilder<UserLogin_Success_Model>(
//                          stream: userbloc.LoginSuccessData,
//                          builder: (context, AsyncSnapshot<UserLogin_Success_Model> snapshot) {
//                            if (snapshot.hasData) {
//                              UserLogin_Success_Model data = snapshot.data;
//                              print("User Data: ");
//                              print(data.message.toString());
//                              //print(data.length);
//                        //      return masterdataview(data);
//
//                            } else if (snapshot.hasError) {
//                              return Text("${snapshot.error}");
//                            }
//
//                            return CircularProgressIndicator();
//                          },
//                        ),
//                      ),
//                  ),
//                ) : Text("sakjsak"),
                ]),
              )
            :
//        Column(
//          children: <Widget>[
//            Center(
//              child: Text("Login Pressed"),
//            ),
//            SizedBox(height: 10,),
//
//            Container(
//              height: 50,
//              width: MediaQuery
//                  .of(context)
//                  .size
//                  .width - 80,
//              child: FlatButton(
//
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                  ),
//                  color: Colors.green,
//                  textColor: Colors.white,
//
//                  onPressed: () {
//
//                    setState(() {
//                      loginPress = false;
//                    });
//
//                    print(loginPress);
//
//
//
////                      Navigator.push(
////                          context,
////                          MaterialPageRoute(builder: (context) => HomePage()),);
//                  },
//
//                  child: Text(
//                    "Login Back".toUpperCase(),
//                    style: GoogleFonts.exo2(
//                      fontSize: 17,
//                      textStyle: TextStyle(color: Colors.white),
//                    ),
//                  )
//              ),
//            ),
//
//            SizedBox(height: 10,),
//
//            Container(
//              height: 50,
//              width: MediaQuery
//                  .of(context)
//                  .size
//                  .width - 80,
//              child: FlatButton(
//
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(18.0),
//                  ),
//                  color: Colors.green,
//                  textColor: Colors.white,
//
//                  onPressed: () {
//
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => HomePage()),);
//                  },
//
//                  child: Text(
//                    "Home".toUpperCase(),
//                    style: GoogleFonts.exo2(
//                      fontSize: 17,
//                      textStyle: TextStyle(color: Colors.white),
//                    ),
//                  )
//              ),
//            ),
//
//
//          ],
//        ),

            StreamBuilder<UserLogin_Success_Model>(
                stream: userbloc.LoginSuccessData,
                builder:
                    (context, AsyncSnapshot<UserLogin_Success_Model> snapshot) {
                  if (snapshot.hasData) {
                    fetchedData = snapshot.data;
                    //_newData = fetcheddata;
                    print("Login:: " + snapshot.data.success.toString());

                    if (snapshot.data.success.toString() == "true") {
                      print("Login:: " + snapshot.data.success.toString());

                    } else if (snapshot.data.success.toString() == "false") {
                      print("Login:: " + snapshot.data.success.toString());
                        loginPress = false;
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
      ),
    );
  }
}
