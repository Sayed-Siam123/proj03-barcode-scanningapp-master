import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      margin: EdgeInsets.all(20),
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
          }

//  @override
//  Widget build(BuildContext context) {
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
//                height: 140,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("Product Name:"),
//                    Text("Product Description:"),
//                    Text("Product ID:"),
//                    Text("Packaging weight:"),
//                    Text("Material:"),
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.only(right: 2),
//                width: 150,
//                height: 140,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("Luna Rosato 2019"),
//                    Text("A touch of white peach"),
//                    Text("P10001"),
//                    Text("250 g"),
//                    Text("Glass"),
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
//                height: 80,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("Length:"),
//                    Text("Width:"),
//                    Text("Height:"),
//
//                  ],
//                ),
//              ),
//              Container(
//                margin: EdgeInsets.only(right: 2),
//                width: 150,
//                height: 80,
//                color: Colors.transparent,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text("10 cm"),
//                    Text("5 cm"),
//                    Text("1.5 cm"),
//
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
//  }
//}
          ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 150,
                      height: 250,
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
                          Text("Packaging weight:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Material:",style: TextStyle(fontSize: 20)),
                          Divider(),
                          Text("Length:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Width:",style: TextStyle(fontSize: 20)),
                          SizedBox(height: 6,),
                          Text("Height:",style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Container(
                        margin: EdgeInsets.only(right: 50),
                        width: 150,
                        height: 250,
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
                            Text("",style: TextStyle(fontSize: 20)),
                            SizedBox(height: 6,),
                            Text(""),
                            SizedBox(height: 6,),
                            Divider(),
                            Text("",style: TextStyle(fontSize: 20)),
                            SizedBox(height: 6,),
                            Text("",style: TextStyle(fontSize: 20)),
                            SizedBox(height: 6,),
                            Text("",style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    )
                  ],
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
