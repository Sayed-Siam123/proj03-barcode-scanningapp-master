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
          }),
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
                        margin: EdgeInsets.only(left: 10,top: 130),
                        height: 300,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 70, top: 100),
                              width: 100,
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
                              width: 0,
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Container(
                                margin: EdgeInsets.only(right: 0, top: 100),
                                width: 150,
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
                              width: 150,
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
                    height: 250,
                    width: MediaQuery.of(context).size.width - 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 80,top: 10),
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
                          width: 00,
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 0,top: 10),
                          width: 170,
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
