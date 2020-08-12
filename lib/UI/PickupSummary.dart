import 'package:app/Bloc/NewDelivery_bloc.dart';
import 'package:app/Bloc/PickupDelivey_bloc.dart';
import 'package:app/Model/DeliveriesListModel.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/NewDeliveryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupSummary extends StatefulWidget {
  @override
  _PickupSummaryState createState() => _PickupSummaryState();
}

class _PickupSummaryState extends State<PickupSummary> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String finalDate = '';
  List<PickupListModel> fetcheddata = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentDate();
    print(finalDate);
    pdelivery_bloc.getAllPickupList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pdelivery_bloc.dispose();
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
          "Direct Pick up - Summary",
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
          child: StreamBuilder<List<PickupListModel>>(
            stream: pdelivery_bloc.allPickupData,
            builder: (context,
                AsyncSnapshot<List<PickupListModel>> snapshot) {
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
                      title: Text(data[index].deliveryId.toString(), style: GoogleFonts.exo2(
                        fontSize: 20,
                      ),),
                      subtitle: Text(data[index].huTypeID.toString(), style: GoogleFonts.exo2(

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
                              Text(data[index].position.toString()+"/"+data[index].quantity.toString(),
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

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    setState(() {
      finalDate = formattedDate.toString();
    });
  }

}
