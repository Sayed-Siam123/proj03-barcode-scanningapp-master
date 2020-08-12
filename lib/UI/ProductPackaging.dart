import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPackagingPage extends StatefulWidget {
  @override
  _ProductPackagingPageState createState() => _ProductPackagingPageState();
}

class _ProductPackagingPageState extends State<ProductPackagingPage> {
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
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 8),
                  color: Colors.white,
                  height: 800,
                  width: MediaQuery.of(context).size.width-20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 70),
                        width: 150,
                        height: 750,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Name:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Description:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Product ID:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 20,),
                            Text("Packaging weight:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Material:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 20,),
                            Text("Length:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Width:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                            SizedBox(height: 6,),
                            Text("Height:",style: GoogleFonts.exo2(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),),
                          ],
                        ),
                      ),

                      SizedBox(
                        width: 0,
                      ),


                      Container(
                        child: Container(
                          margin: EdgeInsets.only(right: 0),
                          width: 170,
                          height: 750,
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
                              SizedBox(height: 20,),
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
                              SizedBox(height: 20,),
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
