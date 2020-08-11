import 'package:app/UI/MasterData.dart';
import 'package:app/Widgets/SublistView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home.dart';

class SublistPage extends StatefulWidget {
  @override
  _SublistPageState createState() => _SublistPageState();
}

class _SublistPageState extends State<SublistPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage())),

      child: Scaffold(
        appBar: AppBar(
          title: Text("Sublist",
            style: GoogleFonts.exo2(
            textStyle: TextStyle(
            color: Colors.black54,
          ),
        ),),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 00.00,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.black54,) ,
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MasterData())),
          ),
        ),

        body: SublistViewPage(),



      ),
    );
  }
}
