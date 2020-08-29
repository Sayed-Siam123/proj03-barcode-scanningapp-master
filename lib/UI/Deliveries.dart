import 'package:app/Bloc/NewDelivery_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/DeliveriesListModel.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/NewDeliveryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveriesPage extends StatefulWidget {
  @override
  _DeliveriesPageState createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String finalDate = '';
  List<DeliveriesListModel> fetcheddata = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDate();
    print(finalDate);
    ndelivery_bloc.getAllDeliveryList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ndelivery_bloc.dispose();
  }

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
          translate('delivereies').toString(),
          style: GoogleFonts.exo2(
            textStyle: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,
      ),
      body: WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Container(
          width: double.infinity,
          color: Theme
              .of(context)
              .backgroundColor,
          child: StreamBuilder<List<DeliveriesListModel>>(
            stream: ndelivery_bloc.allDelivereiesData,
            builder: (context,
                AsyncSnapshot<List<DeliveriesListModel>> snapshot) {
              if (snapshot.hasData) {
                fetcheddata = snapshot.data;
                //_newData = fetcheddata;
                print("Data gula:: ");

                print(fetcheddata.length);
                return masterdataview(fetcheddata);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(child: CircularProgressIndicator());
            },
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

  Widget masterdataview(data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: fetcheddata.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.only(top: 10),
                  child: Container(
                    height: 70,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        print("Asche");
                      },
                      leading: Container(
                        width: 40,
                        decoration: BoxDecoration(
                          //color: Colors.red,
                          // ignore: unrelated_type_equality_checks
                          color: finalDate == data[index].commissionedOn.toString() ? Colors.green : Colors.red, //TODO:DATE SET KORA LAGBE
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(data[index].deliveryCode.toString(), style: GoogleFonts.exo2(
                        fontSize: 20,
                      ),),
                      subtitle: Text(data[index].commissionedOn.toString(), style: GoogleFonts.exo2(

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
                                  color: Theme
                                      .of(context)
                                      .accentColor,
                                ),
                              ),
                              Text("8"+"/"+data[index].quantity.toString(),
                                style: GoogleFonts.exo2(
                                  fontSize: 15,
                                  color: Theme
                                      .of(context)
                                      .accentColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 0,),
              ]
          );
        });
  }

  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year} ${dateParse.hour}:${dateParse.minute}:${dateParse.second}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

}
