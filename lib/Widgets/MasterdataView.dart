import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/Widgets/MastarDataWidget.dart';
import 'package:flutter/material.dart';

class MasterdataView extends StatefulWidget {
  @override
  _MasterdataViewState createState() => _MasterdataViewState();
}

class _MasterdataViewState extends State<MasterdataView> {
  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.fetchAllMasterData();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
//    return FutureBuilder<List<MasteData>>(
//      future: _fetchMasteDatas(),
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          List<MasteData> data = snapshot.data;
//          return _MasterDataListView(data);
//        } else if (snapshot.hasError) {
//          return Text("${snapshot.error}");
//        }
//        return CircularProgressIndicator();
//      },
//    );
    return Container(
      margin: EdgeInsets.all(10),
      child: StreamBuilder<List<MasterDataModel>>(
        stream: masterdata_bloc.allMasterData,
        builder: (context, AsyncSnapshot<List<MasterDataModel>> snapshot) {
          if (snapshot.hasData) {
            List<MasterDataModel> data = snapshot.data;
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

  ListView masterdataview(data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
              children: <Widget>[
                MasterDataWidget(gtin: data[index].gtin,
                  product_name:data[index].productName,
                  category: data[index].categoryName,
                  product_id: data[index].id,
                ),

                SizedBox(height: 6,)

              ],
          );
        });
  }
}
