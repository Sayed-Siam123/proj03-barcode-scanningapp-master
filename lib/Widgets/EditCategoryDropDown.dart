import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class EditCategoryDropDown extends StatefulWidget {
  final String category, previous_id;

  const EditCategoryDropDown({Key key, this.category, this.previous_id}) : super(key: key);
  @override
  _EditCategoryDropDownState createState() => _EditCategoryDropDownState();
}

class _EditCategoryDropDownState extends State<EditCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();


  String _valCategoryName = "";
  String _valCategoryID = "";

  CategoryModel categorySelect;
  List<CategoryModel> data;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllCatDatafromDB();
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
            //return masterdataview(data);

//            return DropdownButton(
//                      hint: Text("Category"),
//                      value: _valCategoryName,
//                      items: data.map((value) {
//                        return DropdownMenuItem(
//                          child: Text(value.categoryName),
//                          value: value,
//                        );
//                      }).toList(),
//                      onChanged: (value) {
//                        // _valFriends = value;
//                        setState(() {
//                          //_valCategoryName = value.categoryName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//                        });
//                        print("id is:"+ value.id.toString());
//                        sublist_bloc.getcategory_id(value.id.toString());
//                      });


            return Container(
              key: scaffoldKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

//                  Text(
//                    "Category",
//                    style: GoogleFonts.exo2(
//                      textStyle: TextStyle(
//                        fontSize: 20,
//                      ),
//                    ),
//                  ),
//
//                  SizedBox(
//                    height: 5,
//                  ),

//                  new Container(
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.grey.withOpacity(0.3),
//                          spreadRadius: 2,
//                          blurRadius: 5,
//                          offset: Offset(0, 3),
//                        ),
//                      ],
//                    ),
//                    height: 50,
//                    width: MediaQuery.of(context).size.width - 40,
//                    child: new DropdownButton<CategoryModel>(
//                      isExpanded: true,
//                      icon: Icon(Icons.arrow_drop_down),
//                      iconSize: 42,
//                      style: GoogleFonts.exo2(
//                        textStyle: TextStyle(
//                          fontSize: 20,
//                        ),
//                      ),
//                      underline: SizedBox(),
//                      value: categorySelect,
//                      onChanged: (CategoryModel newValue) {
//                        FocusScope.of(context).requestFocus(FocusNode());
//                        setState(() {
//                          categorySelect = newValue;
//                        });
//                        print("ID HOITESE: " + categorySelect.id);
//                        sublist_bloc.getCategoryID(categorySelect.id);
//                      },
//                      elevation: 25,
//                      items: data.map((CategoryModel category) {
//                        return new DropdownMenuItem<CategoryModel>(
//                          value: category,
//                          child: Padding(
//                            padding: const EdgeInsets.only(left: 3.0),
//                            child: Text(
//                              category.categoryName,
//                              style: GoogleFonts.exo2(
//                                textStyle: TextStyle(
//                                  color: Colors.black54,
//                                ),
//                              ),
//                            ),
//                          ),
//                        );
//                      }).toList(),
//                    ),
//                  ),

                  //MealSelector(data: _food,label: "Category",),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.only(left: 4),
                        child: Text(
                          AppLocalizations.of(context).translate('category').toString(),
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          decoration: _getShadowDecoration(),
                          child: Card(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width-136,
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
                                      searchHint: AppLocalizations.of(context).translate('select_one').toString(),
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

                  //return Text(data[index].categoryName);

            //TODO:: eikhan theke start hbe

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  //TODO:: eikhan theke kaj shuru hbe

  Widget masterdataview(data) {
  }

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

}
