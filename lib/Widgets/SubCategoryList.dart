import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/unit_model.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EditCategoryDropDown.dart';

class SubCategoryList extends StatefulWidget {
  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  //Toaster toast;

  final _resetKey = GlobalKey<FormState>();
  bool _resetValidate = false;

  bool _validate1;
  bool _validate2 = false;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";
  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllCatDatafromDB();
    sublist_bloc.fetchAllSubCatDatafromDB();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: StreamBuilder<List<SubCategoryModel>>(
        stream: sublist_bloc.allsubcategory,
        builder: (context, AsyncSnapshot<List<SubCategoryModel>> snapshot) {
          if (snapshot.hasData) {
            List<SubCategoryModel> data = snapshot.data;
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

      onRefresh: (){
        return sublist_bloc.fetchAllSubCatDatafromDB();
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
                      margin: EdgeInsets.only(left: 6,right: 6,top: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ListTile(
                        onTap: (){
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                        },
                        title: Text(data[index].subCategoryName.toString(),
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
                            _showDialog(data[index].id.toString(),data[index].categoryName.toString(),
                                data[index].categoryId.toString(),data[index].subCategoryName.toString(),data[index].newFlag.toString());
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

  _showDialog(String id,String categoryName,String categoryID,String subcatName,String newFlag) async {
    await showDialog<String>(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (context, setState) {
            return DirectSelectContainer(
              child: new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    return Container(
                      height: height * 0.4,
                      width: 400,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "UPDATE SUB CATEGORY",
                            style: GoogleFonts.exo2(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          EditCategoryDropDown(category: categoryName,),

                          SizedBox(
                            height: 15,
                          ),

                          Container(
                            child: Column(
                              children: <Widget>[
                                new Text(
                                  "Sub Category",
                                  style: GoogleFonts.exo2(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                new TextField(
                                  autofocus: true,
                                  style: GoogleFonts.exo2(
                                    fontSize: 14,
                                  ),
                                  decoration: new InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    hintText: subcatName,
                                    hintStyle: GoogleFonts.exo2(
                                      fontSize: 14,
                                    ),
                                    errorStyle: GoogleFonts.exo2(
                                      fontSize: 14,
                                    ),
                                    errorText: _validate1 == false
                                        ? errortext1
                                        : null,
                                  ),
                                  controller: _inputcontrol1,
                                  // ignore: missing_return
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    );

                  },
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: Text(
                        'CANCEL',
                        style: GoogleFonts.exo2(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        _inputcontrol1.text = "";
                        //_inputcontrol2.text = "";
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: Text(
                        'UPDATE',
                        style: GoogleFonts.exo2(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {
//                Navigator.pop(context);

                        if (_inputcontrol1.text.isEmpty &&
                            _inputcontrol1.text == "") {
                          print("KHali");

                          setState(() {
                            _validate1 = false;
                          });
                          //TODO:: Toast hobe ekta
                        }

//                  else if (_inputcontrol2.text.isEmpty &&
//                      _inputcontrol2.text == "") {
//                    print("eitao KHali");
//                    //TODO:: Toast hobe ekta
//                  }

                        else {
                          setState(() {
                            _validate1 = true;
                          });

                          print("Vora");

                          print(_inputcontrol1.text);
                          //print(_inputcontrol2.text);

                          sublist_bloc.getsubcategory_id(id); //must
                          sublist_bloc.get_new_sub_category(_inputcontrol1.text);
                          sublist_bloc.previous_category_id(categoryID.toString());
                          sublist_bloc.previous_category_name(categoryName.toString());



                          _inputcontrol1.text = "";
                          //_inputcontrol2.text = "";


                          SubCategoryModel data = SubCategoryModel(
                            newFlag: newFlag.toString(),
                          );
//
                          Navigator.pop(context);
                          sublist_bloc.updateSubCattoDB(data);
                          sublist_bloc.dispose();
                          sublist_bloc.fetchAllSubCatDatafromDB();
                        }

//                      setState(() {
//                        _inputcontrol2.text.isEmpty || _inputcontrol2.text == '' ? _validate = true : _validate = false;
//                      });
                      })
                ],
              ),
            );
          },
        ));
  }

}
