import 'package:app/UI/Home.dart';
import 'package:app/UI/NewDeliveryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveriesPage extends StatefulWidget {
  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        title: Text(
          "Deliveries",
          style: GoogleFonts.exo2(
            textStyle: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
      ),
      body: WillPopScope(
        // ignore: missing_return
        onWillPop: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: <Widget>[
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,

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
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text("TP 1000009" ,style: GoogleFonts.exo2(
                      fontSize: 20,
                    ),),
                    subtitle: Text("2020.05.11", style: GoogleFonts.exo2(

                    ),),
                    trailing: Container(
                      height: 60,
                      width: 80,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("POS/QTY",
                              style: GoogleFonts.exo2(
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text("4 / 201",
                              style: GoogleFonts.exo2(
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,
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
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text("TP 1000010",style: GoogleFonts.exo2(
                      fontSize: 20,
                    ),),
                    subtitle: Text("2020.05.12",style: GoogleFonts.exo2(

                    ),),
                    trailing: Container(
                      height: 60,
                      width: 80,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("POS/QTY",
                              style: GoogleFonts.exo2(
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text("4 / 201",
                              style: GoogleFonts.exo2(
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,
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
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text("TP 1000011",
                      style: GoogleFonts.exo2(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text("2020.05.12",
                      style: GoogleFonts.exo2(

                      ),),
                    trailing: Container(
                      height: 60,
                      width: 80,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("POS/QTY",
                            style: GoogleFonts.exo2(
                              fontSize: 15,
                              color: Theme.of(context).accentColor,
                            ),
                            ),
                            Text("4 / 201",
                              style: GoogleFonts.exo2(
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text("TP 1000012",style: GoogleFonts.exo2(
                      fontSize: 20,
                    ),),
                    subtitle: Text("2020.05.13",style: GoogleFonts.exo2(

                    ),),
                    trailing: Container(
                      height: 60,
                      width: 80,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("POS/QTY",
                              style: GoogleFonts.exo2(
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Text("4 / 201",
                              style: GoogleFonts.exo2(
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("jabs");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewDeliveryPage()));
          // Add your onPressed code here!
        },
        child: Icon(
          Icons.add,
          size: 50,
        ),
        backgroundColor: Colors.green,
      ),

    );
  }
}
