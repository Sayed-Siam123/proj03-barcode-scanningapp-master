import 'package:app/UI/BarcodeComparisonSettings.dart';
import 'package:app/UI/SystemSettings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackbarHelper{


  void snackbarshowHome(BuildContext context,String message,int duration, String timestamp,Color color){
    Scaffold.of(context)
        .showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(
            message.toString() + timestamp.toString() ,
            style: GoogleFonts
                .poppins(
              textStyle:
              TextStyle(
                fontSize: 16,
                color: Colors
                    .white,
              ),
            ),
          ),
          duration: Duration(
              seconds: duration),
        ));
  }

  void snackbarshowNormal(BuildContext context,String message,int duration,Color color){
    Scaffold.of(context)
        .showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(
            message.toString(),
            style: GoogleFonts
                .poppins(
              textStyle:
              TextStyle(
                fontSize: 16,
                color: Colors
                    .white,
              ),
            ),
          ),
          duration: Duration(
              seconds: duration),
        ));
  }

  void snackbarshowAction(BuildContext context,String message,int duration,Color color){
    Scaffold.of(context)
        .showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(
            message.toString(),
            style: GoogleFonts
                .poppins(
              textStyle:
              TextStyle(
                fontSize: 16,
                color: Colors
                    .white,
              ),
            ),
          ),
          duration: Duration(
              seconds: duration),
          action: SnackBarAction(
            label: "Settings",
            textColor: Colors.blue.shade600,
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SystemSettingsPage()));
            },
          ),
        ));
  }

  void snackbarshowAction2(BuildContext context,String message,int duration,Color color){
    Scaffold.of(context)
        .showSnackBar(
        SnackBar(
          backgroundColor: color,
          content: Text(
            message.toString(),
            style: GoogleFonts
                .poppins(
              textStyle:
              TextStyle(
                fontSize: 16,
                color: Colors
                    .white,
              ),
            ),
          ),
          duration: Duration(
              seconds: duration),
          action: SnackBarAction(
            label: "Settings",
            textColor: Colors.blue.shade600,
            onPressed: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BarcodeComparisonSettingsPage()));
            },
          ),
        ));
  }


}