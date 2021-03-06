import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/HandlerModel.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class EditProductCategoryDropDown extends StatefulWidget {
  String category, previous_id;

  EditProductCategoryDropDown({this.category, this.previous_id});

  @override
  _EditProductCategoryDropDownState createState() =>
      _EditProductCategoryDropDownState();
}

class _EditProductCategoryDropDownState
    extends State<EditProductCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valCategoryName = "";
  String _valCategoryID = "";
  List<CategoryModel> _CategoryDesc = [];

  CategoryModel categorySelect;
  List<CategoryModel> data;

  TextEditingController _categoryController = new TextEditingController();

  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  HandlerClass handle;

  List<String> list= ["sasas"];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _myActivity = '';
    _myActivityResult = '';

    sublist_bloc.fetchAllCatDatafromDB();
    masterdata_bloc.getsinglemasterdatafromDB();
    //_valCategoryName = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<CategoryModel>>(
        stream: sublist_bloc.allcategory,
        builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //eturn masterdataview(data);


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
                          translate('category').toString(),
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
//                                      child: DirectSelectList<CategoryModel>(
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
//                                        itemBuilder: (CategoryModel category) =>
//                                            getDropDownMenuItem(category),
//                                        focusedItemDecoration: _getDslDecoration(),
//                                        onItemSelectedListener: (value, selectedIndex, context) {
//                                          FocusScope.of(context).requestFocus(FocusNode());
//                                          categorySelect = value;
//
////                                          print(categorySelect.categoryName.toString());
////                                          print("ID HOITESE: " + categorySelect.id);
////                                          sublist_bloc.getCategoryID(categorySelect.id);
//
//
//                                        },
//                                      ),
//
//
//                                    //child: Text("Asche"),  //TODO:: eikhan theke kaj shuru hbe
//
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
                                            return new DropdownMenuItem<CategoryModel>(
                                                child: Padding(
                                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                  child: Text(item.categoryName),
                                                ), value: item);
                                          }).toList(),
                                          value: categorySelect,
                                          hint: widget.category.toString(),
                                          searchHint: translate('select_one').toString(),
                                          isCaseSensitiveSearch: true,
                                          onChanged: (value) {
                                            setState(() {
                                              categorySelect = value;
                                              _valCategoryID = value.id.toString();
                                              _valCategoryName = value.categoryName.toString();
                                            });
                                            sublist_bloc.getCategoryID(_valCategoryName);
                                            sublist_bloc.getCategoryName(_valCategoryName);

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
//              //color: Colors.red,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(top: 5.0),
//                    child: Text(
//                      "Category",
//                      style: GoogleFonts.exo2(
//                        textStyle: TextStyle(
//                          fontSize: 20,
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 3.0),
//                    child: Container(
//                      height: 50,
//                      width: 380,
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
//                                      margin: EdgeInsets.only(top: 0, left: 7),
//                                        child: TextField(
//                                          enabled: false,
//                                          style: GoogleFonts.exo2(
//                                            textStyle: TextStyle(
//                                              fontSize: 20,
//                                            ),
//                                          ),
//                                          textAlign: TextAlign.justify,
//                                          controller: _categoryController,
//                                          decoration: InputDecoration(
//                                            hintText: widget.category,
//                                            hintStyle: GoogleFonts.exo2(
//                                              textStyle: TextStyle(
//                                                fontSize: 20,
//                                                color: Colors.black
//                                              ),
//                                            ),
//                                            border: InputBorder.none,
//                                            focusedBorder: InputBorder.none,
//                                            enabledBorder: InputBorder.none,
//                                            errorBorder: InputBorder.none,
//                                            disabledBorder: InputBorder.none,
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                              ),
//                              Container(
//                                padding: EdgeInsets.only(left: 144, top: 3),
//                                child: SizedBox(
//                                  height: 70,
//                                  width: 232,
//                                  child: Container(
//                                    height: 70,
//                                    width: 234,
//                                    decoration: BoxDecoration(
//                                        borderRadius:
//                                            BorderRadius.circular(10)),
//                                    child: DropdownButtonHideUnderline(
//                                      child: DropdownButton(
//                                          underline: SizedBox(),
//                                          isExpanded: true,
//                                          icon: Icon(
//                                            Icons.arrow_drop_down,
//                                            size: 24,
//                                          ),
//                                          //hint: Text("Category"),
//                                          items: data.map((value) {
//                                            return new DropdownMenuItem<
//                                                CategoryModel>(
//                                              child: Text(value.categoryName,style: GoogleFonts.exo2(
//                                                textStyle: TextStyle(
//                                                  fontSize: 20,
//                                                ),
//                                              ),
//                                            ),
//                                              value: value,
//                                            );
//                                          }).toList(),
//                                          onChanged: (value) {
//                                            print("value ta holo: " +
//                                                value.categoryName);
//                                            // _valFriends = value;
//                                            //_valCategoryName = value.categoryName;
//                                            FocusScope.of(context)
//                                                .requestFocus(FocusNode());
//
//                                            setState(() {
//                                              //_valCategoryName = value.categoryName;
//                                              // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                              _categoryController.text =
//                                                  value.categoryName.toString();
//                                              _valCategoryID =
//                                                  value.id.toString();
//                                            });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                            print("CategoryID: " +
//                                                widget.previous_id);
//                                            sublist_bloc.getCategoryID(
//                                                _valCategoryID.toString());
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

  //TODO:: eikhan theke kaj shuru hbe

//  Widget masterdataview(data) {
//    return DropDownFormField();
//    return ListView.builder(
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        itemCount: data.length,
//        // ignore: missing_return
//        itemBuilder: (BuildContext context, int index) {
////          return Text(data[index].productName);
//          //_valCategoryID = data[index].categoryName.toString();
////            productName.text = data[index].productDescription;
//
//          return Container(
//            padding: EdgeInsets.all(0),
//            child: DropDownFormField(
//              titleText: 'Category',
//              hintText: 'Please choose one',
//              value: _myActivity,
//              onSaved: (value) {
//                setState(() {
//                  _myActivity = value;
//                });
//              },
//              onChanged: (value) {
//                setState(() {
//                  _myActivity = value;
//                });
//                print(value);
//              },
//              dataSource: [
//                {
//                  "display": data[index].categoryName,
//                  "value": data[index].id,
//                },
//              ],
//              textField: 'display',
//              valueField: 'value',
//            ),
//          );
//        });
//  }


  DirectSelectItem<CategoryModel> getDropDownMenuItem(CategoryModel value) {
    return DirectSelectItem<CategoryModel>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(value.categoryName,
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


//  Widget _dropDownBox(data){
//    return Container(
//      padding: EdgeInsets.all(0),
//      child: DropDownFormField(
//        titleText: 'Category',
//        hintText: 'Please choose one',
//        value: _myActivity,
//        onSaved: (value) {
//          setState(() {
//            _myActivity = value;
//          });
//        },
//        onChanged: (value) {
//          setState(() {
//            _myActivity = value;
//          });
//        },
//        dataSource: [
//          {
//            "display": "Running",
//            "value": "Running",
//          },
//        ],
//        textField: 'display',
//        valueField: 'value',
//      ),
//    );
//
//  }

}
