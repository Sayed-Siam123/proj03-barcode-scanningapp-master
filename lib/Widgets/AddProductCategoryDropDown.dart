import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AddProductCategoryDropDown extends StatefulWidget {
  @override
  _AddProductCategoryDropDownState createState() =>
      _AddProductCategoryDropDownState();
}

class _AddProductCategoryDropDownState
    extends State<AddProductCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  List<String> _food = ["Chicken", "Pork", "Vegetables", "Cheese", "Bread"];

  String _valCategoryName = "";
  List<CategoryModel> _CategoryDesc = [];

  CategoryModel categorySelect;
  List<CategoryModel> data;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: AlignmentDirectional.centerStart,
                          margin: EdgeInsets.only(left: 4),
                          child: Text(
                            "Category",
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

//                      Padding(
//                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
//                        child: Container(
//                          decoration: _getShadowDecoration(),
//                          child: Card(
//                              child: Row(
//                                mainAxisSize: MainAxisSize.min,
//                                children: <Widget>[
//                                  Flexible(
//                                    fit: FlexFit.loose,
//                                    child: SizedBox(
//                                      width: MediaQuery.of(context).size.width-72,
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
//                                          print(categorySelect.categoryName.toString());
//                                          print("ID HOITESE: " + categorySelect.id);
//                                          sublist_bloc.getCategoryID(categorySelect.id);
//                                          sublist_bloc.getCategoryName(categorySelect.categoryName);
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
                                        return new DropdownMenuItem<CategoryModel>(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                              child: Text(item.categoryName),
                                            ), value: item);
                                      }).toList(),
                                      value: categorySelect,
                                      hint: "Select Category",
                                      searchHint: "Select one",
                                      isCaseSensitiveSearch: true,
                                      onChanged: (value) {
                                        setState(() {
                                          categorySelect = value;
                                        });
                                        sublist_bloc.getCategoryID(categorySelect.id);
                                        sublist_bloc.getCategoryName(categorySelect.categoryName);

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

  Widget masterdataview(data) {}

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

  void _showScaffold() {
    final snackBar = SnackBar(content: Text('Hold and drag instead of tap'));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

}

