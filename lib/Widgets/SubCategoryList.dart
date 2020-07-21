import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoryList extends StatefulWidget {
  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllSubCatagoryData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: StreamBuilder<List<SubCategoryModel>>(
        stream: sublist_bloc.allsubcategory,
        builder: (context, AsyncSnapshot<List<SubCategoryModel>> snapshot) {
          if (snapshot.hasData) {
            List<SubCategoryModel> data = snapshot.data;
            print("Data gula:: ");
            print(data.length);
            return masterdataview(data);

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget masterdataview(data) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,

      onRefresh: (){
        return sublist_bloc.fetchAllSubCatagoryData();
      },
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
//              MasterDataWidget(gtin: data[index].gtin,
//                product_name:data[index].productName,
//                category: data[index].categoryName,
//                product_id: data[index].id,
//              ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2.0,
                          //spreadRadius: 3.0,
                          color: Colors.grey.shade400),
                    ],
                  ),
                  child: ListTile(
                    onTap: (){
                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                    },
                    title: Text(data[index].subCategoryName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        )),

                    trailing: IconButton(
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/details');
//                      Navigator.pushReplacement(
//                          context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                        //TODO:: eikhane
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),


                SizedBox(height: 6,)

              ],
            );
          }),
    );
  }


}
