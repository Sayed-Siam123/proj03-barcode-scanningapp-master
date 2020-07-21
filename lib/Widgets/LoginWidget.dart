import 'dart:convert';

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

  bool visible = false ;
  String fontname_lato= "Lato";
  String fontname_popins= "Popins";

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async{
//
//    String deviceId,
//        serverip,
//        serverlog,
//        serverport = "";
//
//
//    String data = "";
//
//
//    String _deviceid = "_deviceid";
//    String _serverip = "_serverip";
//    String _serverport = "_serverport";
//    String _serverlog = "_serverlog";
//
//    // Showing CircularProgressIndicator.
//    setState(() {
//      visible = true ;
//    });
//
//    // Getting value from Controller
//    String email = emailController.text;
//    String password = passwordController.text;
//
//
//    // ignore: missing_return
//
//
//    );
//
//
//
//    // SERVER LOGIN API URL
//    //var url = 'https://flutter-examples.000webhostapp.com/login_user.php';
//    var url = 'http://202.164.212.238:8055/api/Users/'+email+'/'+password;
//
//    // Store all data with Param Name.
////    var data = {'email': email, 'password' : password};
////
////    // Starting Web API Call.
//
//    final response = await http.get(url);
//    if (response.statusCode == 200) {
//      print(json.decode(response.body));
//
//      if(json.decode(response.body)==true){
//
//      }
//
//      else{
//        print("Ashe nai");
//      }
//
//    } else {
//      throw Exception('Failed to load masterdata from API');
//    }
//    // Getting Server response into variable.
//    //var message = jsonDecode(response.body);
//
//
//    void putShared(String key, String val) async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      prefs.setString(key, val);
//    }
//
//    Future getShared(String key) async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
//      String val = prefs.getString(key);
//      return val;
//    }


//
//    // SERVER LOGIN API URL
//    //var url = 'https://flutter-examples.000webhostapp.com/login_user.php';
//    var url = 'http://localhost:8080/flutterlogin/login_user.php';
//
//    // Store all data with Param Name.
//    var data = {'email': email, 'password' : password};
//
//    // Starting Web API Call.
//
//    var response = await http.post(url, body: json.encode(data));
//
//    // Getting Server response into variable.
//    var message = jsonDecode(response.body);
//
//    // If the Response Message is Matched.
//    if(message == 'Login Matched')
//    {
//
//      // Hiding the CircularProgressIndicator.
//      setState(() {
//        visible = false;
//      });
//
//      // Navigate to Profile Screen & Sending Email to Next Screen.
//      Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => HomePage())
//      );
//    }else{
//
//      // If Email or Password did not Matched.
//      // Hiding the CircularProgressIndicator.
//
//      //Bypass login  -----------development purpose only
//      Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => HomePage())
//      );
//
//      setState(() {
//        visible = false;
//      });
//
//      // Showing Alert Dialog with Response JSON Message.
//      showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: new Text(message),
//            actions: <Widget>[
//              FlatButton(
//                child: new Text("OK"),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        },
//      );}
//
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              children: <Widget>[

                Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text('Sign in',

                      style: GoogleFonts.lato(
                        textStyle: TextStyle(color: Colors.black54,
                            letterSpacing: .5,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),


                    )
                ),

                Container(
                  width: 400.00,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.00),
                  child: new Text("Please fill out the below fields to login"),

                ),

                Divider(),

                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      autocorrect: true,
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Email Here'),
                    )
                ),

                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      autocorrect: true,
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Password Here'),
                    )
                ),
                FlatButton(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                    ),
                    color: Colors.white,
                    textColor: Colors.black54,

                    onPressed: () {

                      print(emailController.text);
                      print(passwordController.text);

                      //userLogin();

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                    },

                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Login".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    )
                ),

              ]
          ),
        ),
      ),
    );
  }

}
