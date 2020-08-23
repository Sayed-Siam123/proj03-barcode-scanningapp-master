import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnitList extends StatefulWidget {
  @override
  _UnitListState createState() => _UnitListState();
}

class _UnitListState extends State<UnitList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllUnitDatafromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: StreamBuilder<List<UnitModel>>(
        stream: sublist_bloc.allUnitData,
        builder: (context, AsyncSnapshot<List<UnitModel>> snapshot) {
          if (snapshot.hasData) {
            List<UnitModel> data = snapshot.data;
            print("Data gula:: ");
            print(data.length);
            int lastID = int.parse(data.last.id.toString());
            print(lastID.toString());
            sublist_bloc.getLastID(lastID);
            return masterdataview(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget masterdataview(data) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () {
        return sublist_bloc.fetchAllUnitDatafromDB();
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
                  margin: EdgeInsets.only(left: 6,right: 6,top: 1),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.only(left: 6, right: 6, top: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ListTile(
                        onTap: () {
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                        },
                        title: Text(
                          data[index].unitName.toString(),
                          style: GoogleFonts.exo2(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            //Navigator.of(context).pushNamed('/details');
//                      Navigator.pushReplacement(
//                          context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                            //TODO:: eikhane

                            print("Paisi");

                            print(data[index].id.toString() +
                                data[index].unitName.toString());

                            _showDialogUpdateUnit(
                                data[index].id.toString(),
                                data[index].unitName.toString(),
                                data[index].unitName.toString());
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 1,
                )
              ],
            );
          }),
    );
  }

  _showDialogUpdateUnit(String id, String unit, String unitshort) {
    print("ID:" + id + " " + "Unit:" + " " + "unit short:" + unitshort);
  }
}
