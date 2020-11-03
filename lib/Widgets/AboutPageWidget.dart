import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

class AboutPageWidget extends StatefulWidget {

  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  AboutPageWidget({this.height,this.width,this.scaffoldKey});

  @override
  _AboutPageWidgetState createState() => _AboutPageWidgetState();
}

class _AboutPageWidgetState extends State<AboutPageWidget> {
  @override
  Widget build(BuildContext context) {

    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: wp(100),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(wp(4))),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: 2,
                  color: Colors.grey.shade700.withOpacity(0.3),
                )
              ]
          ),
          padding: EdgeInsets.fromLTRB(wp(3), wp(2), wp(3), 0),
          margin: EdgeInsets.fromLTRB(wp(2), wp(5), wp(2), hp(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Company Information",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),),


              Padding(
                padding: EdgeInsets.only(top: hp(2),left: wp(0),right: wp(0)),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: wp(100),
                      height: hp(20),
                      color: Colors.transparent,
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("NAME"),
                              Text("STREET"),
                              Text("ZIP CITY"),
                              Text("COUNTRY"),
                              Text("PHONE"),
                              Text("EMAIL"),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: wp(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("ABC Company"),
                                Text("9C"),
                                Text("DEFG"),
                                Text("Bangladesh"),
                                Text("+880152346782"),
                                Text("ABC@demo.com"),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),

              Divider(),

              Padding(
                padding: EdgeInsets.only(top: hp(2),left: wp(0),right: wp(0)),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: wp(100),
                      height: hp(20),
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Version"),
                              Text("Update"),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: wp(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("V1.02"),
                                    SizedBox(height: hp(2)),
                                    Text("2020.10.20"),
                                  ],
                                ),
                                Text(""),
                              ],
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
