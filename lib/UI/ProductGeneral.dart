import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductGeneralPage extends StatefulWidget {
  @override
  _ProductGeneralPageState createState() => _ProductGeneralPageState();
}

class _ProductGeneralPageState extends State<ProductGeneralPage> {
  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.getsinglemasterdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<SingleMasterDataModel>>(
          stream: masterdata_bloc.singleMasterData,
          builder:
              (context, AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
            if (snapshot.hasData) {
              List<SingleMasterDataModel> data = snapshot.data;
              print("Data gula:: ");
              print(data.length);
              return masterdataview(data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(child: CircularProgressIndicator());
          }

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
//                height: 180,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("Product Name:"),
//                    Text("Product Description:"),
//                    Text("Product ID:"),
//                    Divider(),
//                    Text("Categorie:"),
//                    Text("Sub Categorie:"),
//                    Text("Unit:"),
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.all(10),
//                child: Container(
//                        margin: EdgeInsets.only(right: 2),
//                        width: 150,
//                        height: 180,
//                        color: Colors.transparent,
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text("Plywood"),
//                            Text("A touch of white peach"),
//                            Text("P10001"),
//                            Divider(),
//                            Text("Wines"),
//                            Text("Rose Wine"),
//                            Text("pcs."),
//                          ],
//                        ),
//                      ),
//
//
//              )
//            ],
//          ),
//          SizedBox(
//            height: 10,
//          ),
//
//          Divider(),
//
//          SizedBox(
//            height: 10,
//          ),
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
//                    Text("Manufacturer:"),
//                    Text("Manufacturer PN:"),
//                    Text("GTIN:"),
//                    Text("Listprice:"),
//                    Text("Picture:"),
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
//                    Text("Weingut Wehweck G"),
//                    Text("161430"),
//                    Text("9900002564474"),
//                    Text("14,90 EUR"),
//                    Text(""),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
          ),
    );
  }

  Widget masterdataview(data) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20,top: 130),
                        height: 300,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 25, top: 100),
                              width: 110,
                              height: 150,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Name",
                                      style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Description",
                                      style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,

                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Product ID",
                                      style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,

                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Categorie",
                                      style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,

                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Sub Categorie",
                                      style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,

                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Unit",
                                      style: GoogleFonts.exo2(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,

                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                margin: EdgeInsets.only(right: 0, top: 100),
                                width: 110,
                                height: 150,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        data[0].productName,
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        data[0].productDescription,
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        data[0].id,
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        data[0].categoryName,
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        data[0].subCategoryName,
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        data[0].packagingUnit,
                                        style: GoogleFonts.exo2(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              'assets/images/wine.jpg',
                              width: MediaQuery.of(context).size.width - 280,
                              height: 200.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    height: 150,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25,top: 10),
                          width: 150,
                          height: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Manufacturer:",
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Manufacturer PN:",
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "GTIN:",
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Listprice:",
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
//                              Text(
//                                "Picture:",
//                                style: GoogleFonts.exo2(
//                                  color: Colors.black,
//                                  fontSize: 16,
//                                  fontWeight: FontWeight.w600,
//                                ),
//                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: 50,
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 0,top: 10),
                          width: MediaQuery.of(context).size.width - 300,
                          height: 180,
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data[0].manufacturerName,
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                data[0].referenceNo,
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                data[0].gtin,
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                data[0].listPrice,
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "",
                                style: GoogleFonts.exo2(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
