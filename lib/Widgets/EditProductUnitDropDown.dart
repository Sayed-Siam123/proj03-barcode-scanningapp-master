import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/unit_model.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class EditProductUnitDropDown extends StatefulWidget {
  String unit, previous_id;

  EditProductUnitDropDown({this.unit, this.previous_id});

  @override
  _EditProductUnitDropDownState createState() =>
      _EditProductUnitDropDownState();
}

class _EditProductUnitDropDownState extends State<EditProductUnitDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valUnitID = "";
  String _valUnitName = "";

  UnitModel unitSelect;
  List<UnitModel> data;

  TextEditingController _unitController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllUnitDatafromDB();
    masterdata_bloc.getsinglemasterdatafromDB();
  }

  @override
  Widget build(BuildContext context) {
//    return Container(
//      child: StreamBuilder<List<UnitModel>>(
//        stream: sublist_bloc.allUnitData,
//        builder: (context, AsyncSnapshot<List<UnitModel>> snapshot) {
//          if (snapshot.hasData) {
//            List<UnitModel> data = snapshot.data;
//            print("Cat er Data gula:: ");
//            print(data.length);
//            //return masterdataview(data);
//
//            return Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//
//                  widget.unit!="" && _valUnitName==""?
//                  Text(widget.unit,style: TextStyle(color: Colors.black),):Text(_valUnitName),
//
//                  Container(
//                    child: DropdownButtonHideUnderline(
//                      child: DropdownButton(
//                          items: data.map((value) {
//                            return DropdownMenuItem(
//                              child: Text(value.unitName),
//                              value: value,
//                            );
//                          }).toList(),
//                          onChanged: (value) {
//                            // _valFriends = value;
//                            setState(() {
//                              _valUnitName = value.unitName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//                              widget.previous_id = value.id.toString();
//                            });
//                            print("id is:"+ widget.previous_id);
//                            sublist_bloc.getUnitID(widget.previous_id);
//                          }),
//                    ),
//                  ),
//                ],
//              ),
//            );
//                  //return Text(data[index].categoryName);
//
//            //TODO:: eikhan theke start hbe
//
//          } else if (snapshot.hasError) {
//            return Text("${snapshot.error}");
//          }
//
//          return Center(child: CircularProgressIndicator());
//        },
//      ),
//    );
//  }
//
//  //TODO:: eikhan theke kaj shuru hbe
//
//  Widget masterdataview(data) {
//  }
//}
    return Container(
      child: StreamBuilder<List<UnitModel>>(
        stream: sublist_bloc.allUnitData,
        builder: (context, AsyncSnapshot<List<UnitModel>> snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //eturn masterdataview(data);

//            return Container(
//              child: Row(
//                children: <Widget>[
//                  Stack(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.only(left: 0),
//                        child: SizedBox(
//                          height: 70,
//                          width: 130,
//                          child: Container(
//                            margin: EdgeInsets.only(top: 20),
//                            child: Text(
//                              "Select Unit",
//                              textAlign: TextAlign.start,
//                              style: TextStyle(fontSize: 16),
//                            ),
//                          ),
//                        ),
//                      ),
//                      StatefulBuilder(
//                        builder: (context, setState) {
//                          return Container(
//                            padding: EdgeInsets.only(left: 155),
//                            child: SizedBox(
//                                height: 70,
//                                width: 140,
//                                child: Container(
//                                  margin: EdgeInsets.only(top: 20),
//                                  child: Text(
//                                    widget.unit,
//                                    textAlign: TextAlign.justify,
//                                    style: TextStyle(fontSize: 16),
//                                  ),
//                                )),
//                          );
//                        },
//                      ),
//                      Container(
//                        padding: EdgeInsets.only(left: 303),
//                        child: SizedBox(
//                          height: 70,
//                          width: 92,
//                          child: Container(
//                            child: DropdownButtonHideUnderline(
//                              child: DropdownButton(
//                                //hint: Text("Category"),
//                                  items: data.map((value) {
//                                    return new DropdownMenuItem<UnitModel>(
//                                      child: Text(value.unitName),
//                                      value: value,
//                                    );
//                                  }).toList(),
//                                  onChanged: (value) {
//                                    print(
//                                        "value ta holo: " + value.unitName);
//                                    // _valFriends = value;
//                                    //_valCategoryName = value.categoryName;
//                                    setState(() {
//                                      //_valCategoryName = value.categoryName;
//                                      // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                      widget.unit = value.unitName;
//                                      widget.previous_id = value.id.toString();
//                                    });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                    print("SubCategoryID: " + widget.previous_id);
//                                    sublist_bloc.getUnitID(widget.previous_id);
//                                  }),
//                            ),
//                          ),
//                        ),
//                      ),
//                      Container(),
//                    ],
//                  ),
//
////                      Text("Select Category"),
////
////
////                      SizedBox(width: 2,),
////
////
////                      new Container(
////                        padding:
////                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
////                        decoration: BoxDecoration(
////                            color: Colors.white,
////                            borderRadius: BorderRadius.circular(10)),
////
////                        height: 50,
////                        width: 250,
////                        child: new DropdownButton<CategoryModel>(
////                          isExpanded: true,
////                          icon: Icon(Icons.arrow_drop_down),
////                          iconSize: 42,
////                          underline: SizedBox(),
////                          value: categorySelect,
////                          onChanged: (CategoryModel newValue) {
////                            setState(() {
////                              categorySelect = newValue;
////                            });
////                            print(categorySelect.categoryName);
////                          },
////                          elevation: 25,
////                          items: data.map((CategoryModel category) {
////                            return new DropdownMenuItem<CategoryModel>(
////                              value: category,
////                              child: new Text(
////                                category.categoryName,
////                                style: new TextStyle(color: Colors.black),
////                              ),
////                            );
////                          }).toList(),
////                        ),
////                      ),
//
////
//////                      StatefulBuilder(
//////                        builder: (context, setState) {
//////                          return Container(
//////                            margin: EdgeInsets.all(20),
//////                            child: StreamBuilder<List<SingleMasterDataModel>>(
//////                                stream: masterdata_bloc.singleMasterData,
//////                                builder: (context,
//////                                    AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
//////                                  if (snapshot.hasData) {
//////                                    List<SingleMasterDataModel> data = snapshot.data;
//////                                    print("Data gula:: ");
//////                                    print(data.length);
//////                                    return masterdataview(data);
//////                                  } else if (snapshot.hasError) {
//////                                    return Text("${snapshot.error}");
//////                                  }
//////
//////                                  return Center(child: CircularProgressIndicator());
//////                                }),
//////                          );
//////                        },
//////                      ),
////
//                ],
//              ),
//            );
//
//            //return Text(data[index].categoryName);
//
//            //TODO:: eikhan theke start hbe
//
//          } else if (snapshot.hasError) {
//            return Text("${snapshot.error}");
//          }
//
//          return Center(child: CircularProgressIndicator());
//        },
//      ),
//    );
//            return Container(
//              //color: Colors.red,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(top: 5.0),
//                    child: Text(
//                      "Unit",
//                      style: GoogleFonts.exo2(
//                        textStyle: TextStyle(
//                          fontSize: 20,
//                          color: Colors.black,
//                        ),
//                      ),
//                    ),
//                  ),
//                 Container(
//                   height: 50,
//                   width: 370,
//                      decoration: BoxDecoration(
//                          border: Border.all(),
//                          borderRadius: BorderRadius.circular(5)),
//                      child: Row(
//                        children: <Widget>[
//                          Stack(
//                            children: <Widget>[
//                              Container(
//                                child: SizedBox(
//                                    height: 70,
//                                    width: 140,
//                                    child: Container(
//                                      padding: const EdgeInsets.only(
//                                          left: 6, bottom: 3),
//                                      child: TextField(
//                                        enabled: false,
//                                        style: GoogleFonts.exo2(
//                                          textStyle: TextStyle(
//                                            fontSize: 18,
//                                            color: Colors.black,
//                                          ),
//                                        ),
//                                        controller: _unitController,
//                                        decoration: InputDecoration(
//                                          hintText: widget.unit,
//                                          hintStyle: GoogleFonts.exo2(
//                                            textStyle: TextStyle(
//                                              fontSize: 20,
//                                              color: Colors.black,
//                                            ),
//                                          ),
//                                          border: InputBorder.none,
//                                          focusedBorder: InputBorder.none,
//                                          enabledBorder: InputBorder.none,
//                                          errorBorder: InputBorder.none,
//                                          disabledBorder: InputBorder.none,
//                                        ),
//                                      ),
//                                    )),
//                              ),
//                              Container(
//                                padding: EdgeInsets.only(left: 155, top: 3),
//                                child: SizedBox(
//                                  height: 70,
//                                  width: 210,
//                                  child: Container(
//                                    child: DropdownButtonHideUnderline(
//                                      child: DropdownButton(
//                                          isExpanded: true,
//                                          icon: Icon(
//                                            Icons.arrow_drop_down,
//                                            size: 24,
//                                          ),
//                                          //hint: Text("Category"),
//                                          items: data.map((value) {
//                                            return new DropdownMenuItem<
//                                                UnitModel>(
//                                              child: Text(
//                                                value.unitName,
//                                                style: GoogleFonts.exo2(
//                                                  textStyle: TextStyle(
//                                                    fontSize: 20,
//                                                    color: Colors.black,
//                                                  ),
//                                                ),
//                                              ),
//                                              value: value,
//                                            );
//                                          }).toList(),
//                                          onChanged: (value) {
//                                            print("value ta holo: " +
//                                                value.unitName);
//                                            // _valFriends = value;
//                                            //_valCategoryName = value.categoryName;
//                                            FocusScope.of(context)
//                                                .requestFocus(FocusNode());
//
//                                            setState(() {
//                                              //_valCategoryName = value.categoryName;
//                                              // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                              _unitController.text =
//                                                  value.unitName.toString();
//                                              _valUnitID = value.id.toString();
//                                            });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                            print("UnitID: " +
//                                                widget.previous_id);
//                                            sublist_bloc.getUnitID(_valUnitID);
//                                            sublist_bloc.getUnitID(_valUnitID);
////                                    sublist_bloc.getCategoryID(widget.previous_id);
//                                          }),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                 ),
//                ],
//              ),
//            );

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.only(left: 0),
                        child: Text(
                          "Unit",
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
//                        child: Container(
//                          decoration: _getShadowDecoration(),
//                          child: Card(
//                              child: Row(
//                                mainAxisSize: MainAxisSize.min,
//                                children: <Widget>[
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: SizedBox(
//                                      width: MediaQuery.of(context).size.width-60,
//                                      height: 50,
//                                      child: DirectSelectList<UnitModel>(
//                                        onUserTappedListener: () {
//                                          Scaffold.of(context).showSnackBar(SnackBar(
//                                            content: Text(
//                                              'Hold and drag the item',
//                                              style: GoogleFonts.exo2(
//                                                textStyle: TextStyle(
//                                                  fontSize: 16,
//                                                ),
//                                              ),
//                                            ),
//                                            duration: Duration(seconds: 2),
//                                          ));
//                                        },
//                                        values: data,
//                                        itemBuilder: (UnitModel category) =>
//                                            getDropDownMenuItem(category),
//                                        focusedItemDecoration: _getDslDecoration(),
//                                        onItemSelectedListener: (value, selectedIndex, context) {
//                                          FocusScope.of(context).requestFocus(FocusNode());
//                                          unitSelect = value;
//
////                                          print(categorySelect.categoryName.toString());
////                                          print("ID HOITESE: " + categorySelect.id);
////                                          sublist_bloc.getCategoryID(categorySelect.id);
//
//
//                                        },
//                                      ),
//                                    ),
//                                  ),
//                                  Padding(
//                                    padding: EdgeInsets.only(right: 8),
//                                    child: _getDropdownIcon(),
//                                  )
//                                ],
//                              )),
//                        ),
//                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          decoration: _getShadowDecoration(),
                          child: Card(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width-30,
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,2,0,0),
                                    child: SearchableDropdown.single(
                                      clearIcon: null,
                                      items: data.map((item) {
                                        return new DropdownMenuItem<UnitModel>(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Text(item.unitName),
                                            ), value: item);
                                      }).toList(),
                                      value: unitSelect,
                                      hint: widget.unit.toString(),
                                      searchHint: "Select one",
                                      isCaseSensitiveSearch: true,
                                      onChanged: (value) {
                                        setState(() {
                                          unitSelect = value;
                                          _valUnitID = value.id.toString();
                                          _valUnitName = value.unitName.toString();
                                        });
                                        sublist_bloc.getUnitID(_valUnitID);
                                        sublist_bloc.getUnitName(_valUnitName);
                                      },
                                      isExpanded: true,
                                      underline: Container(
                                        height: 0.0,
                                        decoration: BoxDecoration(
                                            border:
                                            Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))),
                                      ),
                                    ),
                                  ),

                                  //child: Text("Asche"),  //TODO:: eikhan theke kaj shuru hbe
                                )],
                            ),
                          ),

                        ),
                      ),
                    ],
                  ),

                ],
              ),
            );

//            return Container(
//              child: Row(
//                children: <Widget>[
//                  Stack(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.only(left: 0),
//                        child: SizedBox(
//                          height: 70,
//                          width: 130,
//                          child: Container(
//                            margin: EdgeInsets.only(top: 25),
//                            child: Text(
//                              "Category",
//                              textAlign: TextAlign.start,
//                              style: TextStyle(fontSize: 16),
//                            ),
//                          ),
//                        ),
//                      ),
//
//                       Container(
//                         height: 50,
//                         width: 262,
//                         margin: EdgeInsets.only(left: 133),
//                         decoration:BoxDecoration(
//                            color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Stack(
//                           children: <Widget>[
//                             Container(
//                               padding: EdgeInsets.only(left: 23),
//                               child: SizedBox(
//                                   height: 70,
//                                   width: 140,
//                                   child: Container(
//                                     margin: EdgeInsets.only(top: 22),
//                                     child: Text(
//                                       widget.category,
//                                       textAlign: TextAlign.start,
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                   )),
//                             ),
//
////                             Container(
////                               padding: EdgeInsets.only(left: 200,top: 7),
////                               child: SizedBox(
////                                 height: 70,
////                                 width: 70,
////                                 child: Container(
////                                   child: DropdownButtonHideUnderline(
////                                     child: DropdownButton(
////                                       //hint: Text("Category"),
////                                         items: data.map((value) {
////                                           return new DropdownMenuItem<CategoryModel>(
////                                             child: Text(value.categoryName),
////                                             value: value,
////                                           );
////                                         }).toList(),
////                                         onChanged: (value) {
////                                           print(
////                                               "value ta holo: " + value.categoryName);
////                                           // _valFriends = value;
////                                           //_valCategoryName = value.categoryName;
////                                           setState(() {
////                                             //_valCategoryName = value.categoryName;
////                                             // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
////
////                                             widget.category = value.categoryName.toString();
//////                                      widget.previous_id = value.id.toString();
////                                           });
//////                      print("id is:"+ value.categoryName.toString());
//////                      print("id is:"+ value.id.toString());
////                                           print("CategoryID: " + _valCategoryName);
//////                                    sublist_bloc.getCategoryID(widget.previous_id);
////                                         }),
////                                   ),
////                                 ),
////                               ),
////                             ),
////                           ],
////                         ),
////                       ),
//
//                             new Container(
//                               padding:
//                               EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10)),
//
//                               height: 50,
//                               width: 150,
//                               margin: EdgeInsets.only(left: 160,top: 5),
//                               child: new DropdownButton<CategoryModel>(
//                                 isExpanded: true,
//                                 icon: Icon(Icons.arrow_drop_down),
//                                 iconSize: 42,
//                                 underline: SizedBox(),
//                                 onChanged: (CategoryModel newValue) {
//                                   FocusScope.of(context).requestFocus(FocusNode());
//                                   //FocusManager.instance.primaryFocus.unfocus();
//                                   setState(() {
//                                     widget.category = newValue.categoryName;
//                                   });
//                                   print("ID HOITESE: " + categorySelect.id);
//                                   sublist_bloc.getCategoryID(categorySelect.id);
//
//                                 },
//                                 elevation: 25,
//                                 items: data.map((CategoryModel category) {
//                                   return new DropdownMenuItem<CategoryModel>(
//                                     value: category,
//                                     child: new Text(
//                                       category.categoryName,
//                                       style: new TextStyle(color: Colors.black),
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             ),
//
//                      Container(),
//                    ],
//                  ),
//
////                      Text("Select Category"),
////
////
////                      SizedBox(width: 2,),
////
////
////                      new Container(
////                        padding:
////                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
////                        decoration: BoxDecoration(
////                            color: Colors.white,
////                            borderRadius: BorderRadius.circular(10)),
////
////                        height: 50,
////                        width: 250,
////                        child: new DropdownButton<CategoryModel>(
////                          isExpanded: true,
////                          icon: Icon(Icons.arrow_drop_down),
////                          iconSize: 42,
////                          underline: SizedBox(),
////                          value: categorySelect,
////                          onChanged: (CategoryModel newValue) {
////                            setState(() {
////                              categorySelect = newValue;
////                            });
////                            print(categorySelect.categoryName);
////                          },
////                          elevation: 25,
////                          items: data.map((CategoryModel category) {
////                            return new DropdownMenuItem<CategoryModel>(
////                              value: category,
////                              child: new Text(
////                                category.categoryName,
////                                style: new TextStyle(color: Colors.black),
////                              ),
////                            );
////                          }).toList(),
////                        ),
////                      ),
//
////
//////                      StatefulBuilder(
//////                        builder: (context, setState) {
//////                          return Container(
//////                            margin: EdgeInsets.all(20),
//////                            child: StreamBuilder<List<SingleMasterDataModel>>(
//////                                stream: masterdata_bloc.singleMasterData,
//////                                builder: (context,
//////                                    AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
//////                                  if (snapshot.hasData) {
//////                                    List<SingleMasterDataModel> data = snapshot.data;
//////                                    print("Data gula:: ");
//////                                    print(data.length);
//////                                    return masterdataview(data);
//////                                  } else if (snapshot.hasError) {
//////                                    return Text("${snapshot.error}");
//////                                  }
//////
//////                                  return Center(child: CircularProgressIndicator());
//////                                }),
//////                          );
//////                        },
//////                      ),
////
//          )],
//              ),
//            ]));

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


  DirectSelectItem<UnitModel> getDropDownMenuItem(UnitModel value) {
    return DirectSelectItem<UnitModel>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(value.unitName,
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 14,
                ),
              ),),
          );
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(1, 1),
          blurRadius: 15.0,
        ),
      ],
    );
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Colors.grey.shade700,
    );
  }
}
