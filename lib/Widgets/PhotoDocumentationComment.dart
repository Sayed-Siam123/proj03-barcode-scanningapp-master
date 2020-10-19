import 'package:app/UI/Home.dart';
import 'package:app/Widgets/PhotoDocumentationSettings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'PhotoDocumentationSingnature.dart';

class PhotoDocumentationCommentsPage extends StatefulWidget {
  @override
  _PhotoDocumentationCommentsPageState createState() => _PhotoDocumentationCommentsPageState();
}

class _PhotoDocumentationCommentsPageState extends State<PhotoDocumentationCommentsPage> {

  final comment = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    final orientation = MediaQuery.of(context).orientation;

    dynamic size = MediaQuery.of(context).size;
    dynamic deviceRatio = size.width / size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Photo Documentation",
          style: new TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhotoDocumetationSettings()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("Next");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhotoDocumentationSingnature()));
          //PhotoDocumentationSingnature
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.green.shade500,
      ),


      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(hp(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Comment",style: TextStyle(
                  fontSize: hp(2),
                ),),

                Container(
                  height: hp(15),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                      top: hp(1), left: 0, right: 0,bottom: hp(.5)),
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
                    padding: EdgeInsets.only(left: hp(1.5), top: hp(0)),
                    child: TextField(
                        autocorrect: true,
                        style: GoogleFonts.exo2(
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, hp(1), wp(1), 0),
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
                          hintText: "Enter comment",
                        ),
                      maxLines: 7,
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      )
    );
  }
}
