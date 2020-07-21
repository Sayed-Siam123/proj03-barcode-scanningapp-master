import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnitList extends StatefulWidget {
  @override
  _UnitListState createState() => _UnitListState();
}

class _UnitListState extends State<UnitList> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllUnitData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: StreamBuilder<List<UnitModel>>(
        stream: sublist_bloc.allUnitData,
        builder: (context, AsyncSnapshot<List<UnitModel>> snapshot) {
          if (snapshot.hasData) {
            List<UnitModel> data = snapshot.data;
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
        return sublist_bloc.fetchAllUnitData();
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
                    title: Text(data[index].unitName.toString(),
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


                        print("Paisi");

                        print(data[index].id.toString()+data[index].unitName.toString());


                        _showDialogUpdateUnit(data[index].id.toString(),data[index].unitName.toString(),data[index].unitName.toString());



                      },
                      icon: Icon(
                        Icons.edit,
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


  _showDialogUpdateUnit(String id,String unit,String unitshort) {

    print("ID:"+id+" "+"Unit:"+" "+"unit short:"+unitshort);

  }


}
