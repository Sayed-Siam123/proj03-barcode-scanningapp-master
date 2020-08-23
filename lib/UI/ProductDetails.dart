import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool transfertoApp = false;
  bool orderableviaAPP = false;

  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.getsinglemasterdatafromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme
          .of(context)
          .backgroundColor,
      child: StreamBuilder<List<SingleMasterDataModel>>(
          stream: masterdata_bloc.singleMasterData,
          builder:
              (context, AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
            if (snapshot.hasData) {
              List<SingleMasterDataModel> data = snapshot.data;
              print("Data gula:: ");
              print(data.length);
              return master_pro_detail_data_view(data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(child: CircularProgressIndicator());
          }

//    return Container(
//      margin: EdgeInsets.only(top: 10),
//      child: Column(
//        children: <Widget>[
////          first(),
////          SizedBox(height: 12,),
////          second(),
////          SizedBox(height: 12,),
////          third(),
////          SizedBox(height: 12,),
////          fourth(),
////          SizedBox(height: 12,),
////          fifth(),
////          SizedBox(height: 12,),
////          sixth(),
////          SizedBox(height: 8,),
////          Padding(
////            padding:EdgeInsets.symmetric(horizontal: 0.0),
////            child:Container(
////              height:.5,
////              width:MediaQuery.of(context).size.width*1.0,
////              color:Colors.black,),),
////          seventh(),
////          SizedBox(height: 12,),
////          eighth(),
////          SizedBox(height: 12,),
////          nineth(),
////          SizedBox(height: 12,),
////          tenth(),
////          SizedBox(height: 12,),
////          eleventh(),
//
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(left: 10),
//                width: 150,
//                height: 200,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("Product Name:"),
//                    Text("Product Description:"),
//                    Text("Product ID:"),
//                    Text("Reference No:"),
//                    Text("Product Weight:"),
//                    Text("Packaging unit:"),
//                    Text("Note:"),
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.only(right: 2),
//                width: 150,
//                height: 200,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("Luna Rosato 2019"),
//                    Text("A touch of white peach"),
//                    Text("P10001"),
//                    Text(""),
//                    Text("1.200 g"),
//                    Text(""),
//                    Text("FRUITY WINE"),
//                  ],
//                ),
//              ),
//            ],
//          ),
//          SizedBox(height: 10,),
//          Padding(
//            padding:EdgeInsets.symmetric(horizontal: 0.0),
//            child:Container(
//              height:.5,
//              width:MediaQuery.of(context).size.width*1.0,
//              color:Colors.black,),),
//
//          SizedBox(height: 10,),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Container(
//                margin: EdgeInsets.only(left: 10),
//                width: 150,
//                height: 180,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("Transfer to App"),
//                    Text("Orderable via APP:"),
//                    Text("Created by:"),
//                    Text("Created on:"),
//                    Text("Edited by:"),
//                    Text("Edited on:"),
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.only(right: 2),
//                width: 150,
//                height: 180,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(""),
//                    Text(""),
//                    Text("SHOW USERNAME"),
//                    Text("SHOW USERNAME"),
//                    Text("SHOW USERNAME"),
//                    Text("SHOW USERNAME"),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
      ),
    );
  }

  ListView master_pro_detail_data_view(data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  height: 300,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 5,
                          md: 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Product Name:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Description:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Product ID:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Reference No:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Product Unit:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Product Weight:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Note:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                            ],
                          ),
                        ),

                        ResponsiveGridCol(
                          xs: 6,
                          md: 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(data[0].productName,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(data[0].productDescription,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(data[0].id,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("ss",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("ss",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("ss",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("ss",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                            ],

                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 20,
                  height: 300,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: ResponsiveGridRow(
                      children: [
                        ResponsiveGridCol(
                          xs: 5,
                          md: 3,
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Transfer to App:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 40,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Order via App:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 18,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Created by:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Created on:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Edited by:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Edited on:",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                            ],
                          ),
                        ),

                        ResponsiveGridCol(
                          xs: 6,
                          md: 3,
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Switch(
                                  value: transfertoApp,
                                  onChanged: (value){
                                    setState(() {
                                      transfertoApp=value;
                                      print(transfertoApp);
                                    });
                                  },
                                  activeTrackColor: Colors.lightBlueAccent,
                                  activeColor: Colors.blue,
                                ),
                              ),

                              SizedBox(height: 3,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Switch(
                                  value: orderableviaAPP,
                                  onChanged: (value){
                                    setState(() {
                                      orderableviaAPP=value;
                                      print(orderableviaAPP);
                                    });
                                  },
                                  activeTrackColor: Colors.lightBlueAccent,
                                  activeColor: Colors.blue,
                                ),
                              ),

                              SizedBox(height: 3,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(data[0].id,
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),)
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("ss",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("ss",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                              SizedBox(height: 5,),


                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("ss",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),),
                              ),

                            ],

                          ),
                        ),
                      ],
                    ),
                  ),)
              ],
            ),
          );
        });
  }
}
