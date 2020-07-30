import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.getsinglemasterdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
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
            margin: EdgeInsets.only(top:50),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: 300,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20,top: 18),
                        width: 150,
                        height: 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),),
                            SizedBox(height: 6,),
                            Text("Description:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),),
                            SizedBox(height: 6,),
                            Text("Product ID:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),),
                            SizedBox(
                              height: 6,
                            ),
                            Text("Reference No:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Product Weight:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Packaging unit:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Note:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                          ],
                        ),
                      ),

                      SizedBox(width: 40,),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                          width: 150,
                          height: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(data[0].productName,style: GoogleFonts.exo2(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),),
                              SizedBox(height: 6,),
                              Text(data[0].productDescription,style: GoogleFonts.exo2(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),),
                              SizedBox(height: 6,),
                              Text(data[0].id,style: GoogleFonts.exo2(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),),
                              SizedBox(
                                height: 6,
                              ),
                              Text("",style: GoogleFonts.exo2(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),),
                              SizedBox(height: 6,),
                              Text("",style: GoogleFonts.exo2(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),),
                              SizedBox(height: 6,),
                              Text("",style: GoogleFonts.exo2(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),),
                              SizedBox(height: 6,),
                              Text("",style: GoogleFonts.exo2(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width-50,
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 150,
                        height: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Transfer to App",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Orderable via APP:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Created by:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Created on:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Edited by:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Edited on:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                          ],
                        ),
                      ),

                      SizedBox(width: 30,),

                      Container(
                        margin: EdgeInsets.only(right: 2),
                        width: 140,
                        height: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
