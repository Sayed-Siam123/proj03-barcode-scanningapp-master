import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductUnitDropDown extends StatefulWidget {

  @override
  _AddProductUnitDropDownState createState() => _AddProductUnitDropDownState();
}

class _AddProductUnitDropDownState extends State<AddProductUnitDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valUnitName="";
  UnitModel unitSelect;
  List<UnitModel> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllUnitData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<UnitModel>>(
        stream: sublist_bloc.allUnitData,
        builder: (context, AsyncSnapshot<List<UnitModel>> snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

//                      widget.category==null ?
//                      Text("Category",style: TextStyle(color: Colors.black),):Text(widget.category),
//
//                      Container(
//                        child: DropdownButtonHideUnderline(
//                          child: DropdownButton(
//                            //hint: Text("Category"),
//                              items: data.map((value) {
//                                return new DropdownMenuItem<CategoryModel>(
//                                  child: Text(value.categoryName),
//                                  value: value,
//
//                                );
//                              }).toList(),
//                              onChanged: (value) {
//
//                                print("value ta holo: "+ value.categoryName);
//                                // _valFriends = value;
//                                //_valCategoryName = value.categoryName;
//                                setState(() {
//                                    //_valCategoryName = value.categoryName;
//                                  // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                  widget.category = value.categoryName;
//                                  widget.previous_id = value.id.toString();
//
//                                });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                print("CategoryID: "+widget.previous_id);
//                                sublist_bloc.getCategoryID(widget.previous_id);
//
//                              }),
//                        ),
//
//                      ),

                  Text("Unit",style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),),


                  SizedBox(width: 120,),


                  new Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),

                    height: 50,
                    width: 205,
                    child: new DropdownButton<UnitModel>(
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      underline: SizedBox(),
                      value: unitSelect,
                      onChanged: (UnitModel newValue) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          unitSelect = newValue;
                        });
                        print(unitSelect.unitName);
                        sublist_bloc.getUnitID(unitSelect.id);
                      },
                      elevation: 25,
                      items: data.map((UnitModel category) {
                        return new DropdownMenuItem<UnitModel>(
                          value: category,
                          child: new Text(
                            category.unitName,
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),


//
////                      StatefulBuilder(
////                        builder: (context, setState) {
////                          return Container(
////                            margin: EdgeInsets.all(20),
////                            child: StreamBuilder<List<SingleMasterDataModel>>(
////                                stream: masterdata_bloc.singleMasterData,
////                                builder: (context,
////                                    AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
////                                  if (snapshot.hasData) {
////                                    List<SingleMasterDataModel> data = snapshot.data;
////                                    print("Data gula:: ");
////                                    print(data.length);
////                                    return masterdataview(data);
////                                  } else if (snapshot.hasError) {
////                                    return Text("${snapshot.error}");
////                                  }
////
////                                  return Center(child: CircularProgressIndicator());
////                                }),
////                          );
////                        },
////                      ),
//
                ],
              ),
            );



            //return Text(data[index].categoryName);

            //TODO:: eikhan theke start hbe
       //return Text(data[index].categoryName);

            //TODO:: eikhan theke start hbe

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  //TODO:: eikhan theke kaj shuru hbe

  Widget masterdataview(data) {
  }
}
