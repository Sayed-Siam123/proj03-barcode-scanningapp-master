import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      margin: EdgeInsets.all(20),
      child: StreamBuilder <List<SingleMasterDataModel>>(
        stream: masterdata_bloc.singleMasterData,
          builder: (context, AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
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
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 150,
                      height: 180,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Name:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Description:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Product ID:",style: TextStyle(fontSize: 20)),
                          Divider(),
                          Text("Categorie:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Sub Categorie:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Unit:",style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        margin: EdgeInsets.only(right: 50),
                        width: 150,
                        height: 180,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data[0].productName,style: TextStyle(fontSize: 20)),
                            SizedBox(height: 6,),
                            Text(data[0].productDescription,style: TextStyle(fontSize: 20)),
                            SizedBox(height: 6,),
                            Text(data[0].id,style: TextStyle(fontSize: 20)),
                            Divider(),
                            Text(data[0].categoryName,style: TextStyle(fontSize: 20)),
                            SizedBox(height: 6,),
                            Text(data[0].subCategoryName,style: TextStyle(fontSize: 20)),
                            SizedBox(height: 6,),
                            Text(data[0].packagingUnit,style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),


                    )
                  ],
                ),

                Divider(),

                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 150,
                      height: 180,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Manufacturer:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Manufacturer PN:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("GTIN:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Listprice:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Picture:",style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 60),
                      width: 150,
                      height: 180,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(data[0].manufacturerName,style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text(data[0].referenceNo,style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text(data[0].gtin,style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text(data[0].listPrice,style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("",style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

}
