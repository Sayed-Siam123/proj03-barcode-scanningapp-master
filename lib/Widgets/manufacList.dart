import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManufacList extends StatefulWidget {
  @override
  _ManufacListState createState() => _ManufacListState();
}

class _ManufacListState extends State<ManufacList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllManufacData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: StreamBuilder<List<ManufactureModel>>(
        stream: sublist_bloc.allmanufac,
        builder: (context, AsyncSnapshot<List<ManufactureModel>> snapshot) {
          if (snapshot.hasData) {
            List<ManufactureModel> data = snapshot.data;
            print("Data gula:: ");
            print(data.length);
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
        return sublist_bloc.fetchAllManufacData();
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
                      margin: EdgeInsets.only(left: 6,right: 6,top: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ListTile(
                        onTap: () {
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                        },
                        title: Text(data[index].manufacturerName.toString(),
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
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
}
