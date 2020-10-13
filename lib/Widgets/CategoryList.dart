import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';

import '../UI/SystemSettings.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  bool _validate1;
  bool _validate2;

  String errortext1 = "*value can\'t be empty";
  String errortext2 = "*value can\'t be empty";

  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllCatDatafromDB();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: StreamBuilder<List<CategoryModel>>(
        stream: sublist_bloc.allcategory,
        builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            List<CategoryModel> data = snapshot.data;
            print("Data gula:: ");
            print(data.length);

            int lastID = int.parse(data.last.id.toString());
            print(lastID.toString());
            sublist_bloc.getLastID(lastID);
            return masterdataview(data,context);

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget masterdataview(data,BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: (){
        return sublist_bloc.fetchAllCatDatafromDB();
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
                        onTap: (){
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                        },
                        title: Text(data[index].categoryName.toString(),
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
                            _showDialog(data[index].id.toString(),data[index].categoryName.toString());
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


                SizedBox(height: 1,)

              ],
            );
          }),
    );
  }

  _showDialog(String id, String category) async {
    await showDialog<String>(
        context: context,
        builder: (_) =>

            StatefulBuilder(
              builder: (context, setState) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;

                      return Container(
                        height: height * 0.20,
                        width: 400,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Text(translate('update_category').toString(),style: GoogleFonts.exo2(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),),

                            Divider(
                              thickness: 1,
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            Container(
                              child: Column(
                                children: <Widget>[
                                  new Text(translate('category').toString(),style: GoogleFonts.exo2(
                                    fontSize: 16,
                                  ),),
                                  SizedBox(height: 2,),
                                  new TextField(
                                    autofocus: true,
                                    style: GoogleFonts.exo2(
                                      fontSize: 14,
                                    ),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                      ),
                                      hintText: category,
                                      hintStyle: GoogleFonts.exo2(
                                        fontSize: 14,
                                      ),
                                      errorStyle: GoogleFonts.exo2(
                                        fontSize: 14,
                                      ),
                                      errorText:
                                      _validate1 == false ? errortext1 : null,
                                    ),
                                    controller: _inputcontrol1,
                                    // ignore: missing_return
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: Text(
                          translate('cancel').toString(),
                          style: GoogleFonts.exo2(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          //_inputcontrol2.text = "";
                          Navigator.pop(context);
                        }),

                    new FlatButton(
                        child: Text(
                          translate('update').toString(),
                          style: GoogleFonts.exo2(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          if (_inputcontrol1.text.isEmpty &&
                              _inputcontrol1.text == "") {
                            print("KHali");

                            setState(() {
                              _validate1 = false;
                            });

                            //TODO:: Toast hobe ekta
                          } else {
                            setState(() {
                              _validate1 = true;
                            });

                            print("Vora");

                            print(_inputcontrol1.text);
                            //print(_inputcontrol2.text);

                            sublist_bloc.getCategoryID(id.toString());
                            sublist_bloc.getCategoryName(_inputcontrol1.text);
//                            sublist_bloc.getUnitShort(_inputcontrol2.text);
                            sublist_bloc.updateCatDatafromDB();

                            _inputcontrol1.text = "";

//                            Fluttertoast.showToast(
//                                msg: "Manufacturer Added!",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.BOTTOM,
//                                timeInSecForIosWeb: 1,
//                                backgroundColor: Colors.green,
//                                textColor: Colors.white,
//                                fontSize: 16.0);

                            Navigator.pop(context);
                            sublist_bloc.dispose();
                            sublist_bloc.fetchAllCatDatafromDB();
                          }

                        }),
                  ],
                );
              },
            )

    );


 }
}
