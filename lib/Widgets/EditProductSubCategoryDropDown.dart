import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class EditProductSubCategoryDropDown extends StatefulWidget {
  String subcat, previous_id;

  EditProductSubCategoryDropDown({this.subcat, this.previous_id});

  @override
  _EditProductSubCategoryDropDownState createState() =>
      _EditProductSubCategoryDropDownState();
}

class _EditProductSubCategoryDropDownState
    extends State<EditProductSubCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valSubCategoryName = "";
  String _valSubCategoryID = "";

  SubCategoryModel subcategorySelect;
  List<SubCategoryModel> data;

  TextEditingController _subcatController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllSubCatDatafromDB();
    masterdata_bloc.getsinglemasterdatafromDB();
  }

  @override
  Widget build(BuildContext context) {
//    return Container(
//      child: StreamBuilder<List<SubCategoryModel>>(
//        stream: sublist_bloc.allsubcategory,
//        builder: (context, AsyncSnapshot<List<SubCategoryModel>> snapshot) {
//          if (snapshot.hasData) {
//            List<SubCategoryModel> data = snapshot.data;
//            print("Cat er Data gula:: ");
//            print(data.length);
//            //return masterdataview(data);
//
//            return Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  widget.subcat!="" && _valSubCategoryName==""?
//                  Text(widget.subcat,style: TextStyle(color: Colors.black),):Text(_valSubCategoryName),
//
//                  SizedBox(width: 0,),
//
//                  Container(
//                    child: DropdownButtonHideUnderline(
//                      child: DropdownButton(
//                          items: data.map((value) {
//                            return DropdownMenuItem(
//                              child: Text(value.subCategoryName),
//                              value: value,
//                            );
//                          }).toList(),
//                          onChanged: (value) {
//                            // _valFriends = value;
//                            setState(() {
//                              _valSubCategoryName = value.subCategoryName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//                               widget.previous_id = value.id.toString();
//                            });
//                            print("id is:"+ widget.previous_id );
//                            sublist_bloc.getSubCategoryID(widget.previous_id );
//                          }),
//                    ),
//                  ),
//                ],
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

    return Container(
      child: StreamBuilder<List<SubCategoryModel>>(
        stream: sublist_bloc.allsubcategory,
        builder: (context, AsyncSnapshot<List<SubCategoryModel>> snapshot) {
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
//                            margin: EdgeInsets.only(top: 18),
//                            child: Text(
//                              "Sub Category",
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
//                                  margin: EdgeInsets.only(top: 18),
//                                  child: Text(
//                                    widget.subcat,
//                                    textAlign: TextAlign.justify,
//                                    style: TextStyle(fontSize: 16),
//                                  ),
//                                )),
//                          );
//                        },
//                      ),
//                      Container(
//                        padding: EdgeInsets.only(left: 312),
//                        child: SizedBox(
//                          height: 70,
//                          width: 83,
//                          child: Container(
//                            child: DropdownButtonHideUnderline(
//                              child: DropdownButton(
//                                //hint: Text("Category"),
//                                  items: data.map((value) {
//                                    return new DropdownMenuItem<SubCategoryModel>(
//                                      child: Text(value.subCategoryName),
//                                      value: value,
//                                    );
//                                  }).toList(),
//                                  onChanged: (value) {
//                                    print(
//                                        "value ta holo: " + value.subCategoryName);
//                                    // _valFriends = value;
//                                    //_valCategoryName = value.categoryName;
//                                    setState(() {
//                                      //_valCategoryName = value.categoryName;
//                                      // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                      widget.subcat = value.subCategoryName;
//                                      widget.previous_id = value.id.toString();
//                                    });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                    print("SubCategoryID: " + widget.previous_id);
//                                    sublist_bloc
//                                        .getSubCategoryID(widget.previous_id);
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
//                      "Sub Category",
//                      style: GoogleFonts.exo2(
//                        textStyle: TextStyle(
//                          fontSize: 18,
//                          color: Colors.black,
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 3.0),
//                    child: Container(
//                      height: 50,
//                      width: 370,
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
//                                        controller: _subcatController,
//                                        decoration: InputDecoration(
//                                          hintText: widget.subcat,
//                                          hintStyle:
//                                              TextStyle(color: Colors.black),
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
//                                padding: EdgeInsets.only(left: 166, top: 3),
//                                child: SizedBox(
//                                  height: 70,
//                                  width: 200,
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
//                                                SubCategoryModel>(
//                                              child:
//                                                  Text(value.subCategoryName,style: GoogleFonts.exo2(
//                                                    textStyle: TextStyle(
//                                                      fontSize: 18,
//                                                      color: Colors.black,
//                                                    ),
//                                                  ),),
//                                              value: value,
//                                            );
//                                          }).toList(),
//                                          onChanged: (value) {
//                                            print("value ta holo: " +
//                                                value.subCategoryName);
//                                            // _valFriends = value;
//                                            //_valCategoryName = value.categoryName;
//
//                                            FocusScope.of(context)
//                                                .requestFocus(FocusNode());
//                                            setState(() {
//                                              //_valCategoryName = value.categoryName;
//                                              // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                              _subcatController.text = value
//                                                  .subCategoryName
//                                                  .toString();
//                                              _valSubCategoryName =
//                                                  value.id.toString();
//                                            });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                            print("subcatID: " +
//                                                widget.previous_id);
//
//                                            sublist_bloc.getSubCategoryID(
//                                                _valSubCategoryName);
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
//                    ),
//                  ),
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
                          "Sub Category",
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
//                                      child: DirectSelectList<SubCategoryModel>(
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
//                                        itemBuilder: (SubCategoryModel category) =>
//                                            getDropDownMenuItem(category),
//                                        focusedItemDecoration: _getDslDecoration(),
//                                        onItemSelectedListener: (value, selectedIndex, context) {
//                                          FocusScope.of(context).requestFocus(FocusNode());
//                                          subcategorySelect = value;
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
                                      items: data.map((item) {
                                        return new DropdownMenuItem<SubCategoryModel>(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Text(item.subCategoryName),
                                            ), value: item);
                                      }).toList(),
                                      value: subcategorySelect,
                                      hint: widget.subcat.toString(),
                                      searchHint: "Select one",
                                      isCaseSensitiveSearch: true,
                                      onChanged: (value) {
                                        setState(() {
                                          subcategorySelect = value;
                                          _valSubCategoryID = value.id.toString();
                                          _valSubCategoryName = value.subCategoryName.toString();
                                        });
                                        sublist_bloc.getSubCategoryID(_valSubCategoryID);
                                        sublist_bloc.getSubCategoryName(_valSubCategoryName);
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

  DirectSelectItem<SubCategoryModel> getDropDownMenuItem(SubCategoryModel value) {
    return DirectSelectItem<SubCategoryModel>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(value.subCategoryName,
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
