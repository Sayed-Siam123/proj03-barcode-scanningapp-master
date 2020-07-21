import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/MaterialPackModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MaterialPackList extends StatefulWidget {
  @override
  _MaterialPackListState createState() => _MaterialPackListState();
}

class _MaterialPackListState extends State<MaterialPackList> {


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllMateralPackData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: StreamBuilder<List<MaterialPackModel>>(
        stream: sublist_bloc.allmaterialpack,
        builder: (context, AsyncSnapshot<List<MaterialPackModel>> snapshot) {
          if (snapshot.hasData) {
            List<MaterialPackModel> data = snapshot.data;
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
        return sublist_bloc.fetchAllMateralPackData();
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
                    title: Text(data[index].materialName.toString(),
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
