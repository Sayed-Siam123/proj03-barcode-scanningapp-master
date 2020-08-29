import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';

class ProductGeneralPage extends StatefulWidget {
  @override
  _ProductGeneralPageState createState() => _ProductGeneralPageState();
}

class _ProductGeneralPageState extends State<ProductGeneralPage> {
  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.getsinglemasterdatafromDB();
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
                        child: Container(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(10,120,0,10),
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
                                            child: Text("Category:",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                          ),

                                          SizedBox(height: 5,),

                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Sub Category:",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                          ),

                                          SizedBox(height: 5,),

                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Unit:",
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
                                            child: Text(data[0].categoryName,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                          ),

                                          SizedBox(height: 5,),


                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(data[0].subCategoryName,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),),
                                          ),

                                          SizedBox(height: 5,),


                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(data[0].unitId,
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
                        ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 25),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              'http://202.164.212.238:8054/'+data[0].productPicture, //TODO:: null picture set
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
                    child: Container(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10,10,0,10),
                        child: ResponsiveGridRow(
                          children: [
                            ResponsiveGridCol(
                              xs: 5,
                              md: 3,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Manufacturer:",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                  ),

                                  SizedBox(height: 5,),

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Manufacturer PN:",
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
                                    child: Text("GTIN:",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                  ),

                                  SizedBox(height: 5,),

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Listprice:",
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
                                    child: Text(data[0].manufacturerName,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                  ),

                                  SizedBox(height: 5,),


                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("" ,
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
                                    child: Text(data[0].gtin,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                  ),

                                  SizedBox(height: 5,),


                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(data[0].listPrice,
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
                  ),
                ],
              ),
            );
          }),
    );
  }
}
