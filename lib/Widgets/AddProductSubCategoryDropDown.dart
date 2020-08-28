import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class AddProductSubCategoryDropDown extends StatefulWidget {

  @override
  _AddProductSubCategoryDropDownState createState() => _AddProductSubCategoryDropDownState();
}

class _AddProductSubCategoryDropDownState extends State<AddProductSubCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valSubCategoryName="";

  SubCategoryModel subcategorySelect;
  List<SubCategoryModel> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllSubCatDatafromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<SubCategoryModel>>(
        stream: sublist_bloc.allsubcategory,
        builder: (context, AsyncSnapshot<List<SubCategoryModel>> snapshot) {
          if (snapshot.hasData) {
            data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

//            return Row(
//              mainAxisAlignment:MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                  _valSubCategoryName==""?
//                  Text("Sub Category",style: TextStyle(color: Colors.grey),):Text(_valSubCategoryName),
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
//                            });
//                            print("id is:"+ value.id.toString());
//                            sublist_bloc.getSubCategoryID(value.id.toString());
//                          }),
//                    ),
//                  ),
//                ],
//            );
                  //return Text(data[index].categoryName);


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
                          AppLocalizations.of(context).translate('sub_category').toString(),
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
//                                        itemBuilder: (SubCategoryModel subcat) =>
//                                            getDropDownMenuItem(subcat),
//                                        focusedItemDecoration: _getDslDecoration(),
//                                        onItemSelectedListener: (value, selectedIndex, context) {
//                                          FocusScope.of(context).requestFocus(FocusNode());
//                                          subcategorySelect = value;
//
//                                          print(subcategorySelect.subCategoryName.toString());
//                                          print("ID HOITESE: " + subcategorySelect.id);
//                                          sublist_bloc.getSubCategoryID(subcategorySelect.id);
//                                          sublist_bloc.getSubCategoryName(subcategorySelect.subCategoryName);
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
                                      hint: AppLocalizations.of(context).translate('sub_category_hint').toString(),
                                      searchHint: AppLocalizations.of(context).translate('select_one').toString(),
                                      isCaseSensitiveSearch: true,
                                      onChanged: (value) {
                                        setState(() {
                                          subcategorySelect = value;

                                        });
                                        sublist_bloc.getSubCategoryID(subcategorySelect.id);
                                        sublist_bloc.getSubCategoryName(subcategorySelect.subCategoryName);
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

  Widget masterdataview(data) {
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
          offset: new Offset(0.0, 0.0),
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
