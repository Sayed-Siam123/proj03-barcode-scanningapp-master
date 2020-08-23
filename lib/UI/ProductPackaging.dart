import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ProductPackagingPage extends StatefulWidget {
  @override
  _ProductPackagingPageState createState() => _ProductPackagingPageState();
}

class _ProductPackagingPageState extends State<ProductPackagingPage> {
  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.getsinglemasterdatafromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: StreamBuilder<List<SingleMasterDataModel>>(
          stream: masterdata_bloc.singleMasterData,
          builder: (context, AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
            if (snapshot.hasData) {
              List<SingleMasterDataModel> data = snapshot.data;
              print("Data gula:: ");
              print(data.length);
              return master_pro_detail_data_view(data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  ListView master_pro_detail_data_view(data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10,top: 5),
            height: 800,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              child: Container(
                margin: EdgeInsets.fromLTRB(10,10,10,0),
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
                            child: Text("Packaging weight:",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                          ),

                          SizedBox(height: 5,),

                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Material:",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                          ),

                          SizedBox(height: 5,),

                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Length:",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                          ),

                          SizedBox(height: 5,),

                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Width:",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                          ),


                          SizedBox(height: 5,),

                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("Height:",
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
                            child: Text("",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                          ),

                          SizedBox(height: 5,),


                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("",
                              style: TextStyle(
                                fontSize: 16,
                              ),),
                          ),

                          SizedBox(height: 5,),


                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text("",
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



//            child: Column(
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.only(top: 8),
//                  color: Colors.white,
//                  height: 800,
//                  width: MediaQuery.of(context).size.width-20,
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.only(left: 70),
//                        width: 150,
//                        height: 750,
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text("Name:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                            SizedBox(height: 6,),
//                            Text("Description:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                            SizedBox(height: 6,),
//                            Text("Product ID:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                            SizedBox(height: 20,),
//                            Text("Packaging weight:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                            SizedBox(height: 6,),
//                            Text("Material:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                            SizedBox(height: 20,),
//                            Text("Length:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                            SizedBox(height: 6,),
//                            Text("Width:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                            SizedBox(height: 6,),
//                            Text("Height:",style: GoogleFonts.exo2(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w600,
//                              fontSize: 16,
//                            ),),
//                          ],
//                        ),
//                      ),
//
//                      SizedBox(
//                        width: 0,
//                      ),
//
//
//                      Container(
//                        child: Container(
//                          margin: EdgeInsets.only(right: 0),
//                          width: 170,
//                          height: 750,
//                          child: Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              Text(data[0].productName,style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                              SizedBox(height: 6,),
//                              Text(data[0].productDescription,style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                              SizedBox(height: 6,),
//                              Text(data[0].id,style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                              SizedBox(height: 20,),
//                              Text("",style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                              SizedBox(height: 6,),
//                              Text("",style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                              SizedBox(height: 20,),
//                              Text("",style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                              SizedBox(height: 6,),
//                              Text("",style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                              SizedBox(height: 6,),
//                              Text("",style: GoogleFonts.exo2(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w600,
//                                fontSize: 16,
//                              ),),
//                            ],
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//              ],
//            ),
          );
        });
  }
}
