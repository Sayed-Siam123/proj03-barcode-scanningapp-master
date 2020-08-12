import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:app/Model/unit_model.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

//                  Text("Unit",style: GoogleFonts.exo2(
//                    textStyle: TextStyle(
//                      fontSize: 20,
//                    ),
//                  ),),
//
//
//                  SizedBox(height: 5,),
//
//
//                  new Container(
//                    decoration: BoxDecoration(
//                        color: Colors.white,
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.grey.withOpacity(0.3),
//                          spreadRadius: 2,
//                          blurRadius: 5,
//                          offset: Offset(0, 3),
//                        ),
//                      ],
//                    ),
//
//                    height: 50,
//                    width: MediaQuery.of(context).size.width-40,
//                    child: new DropdownButton<UnitModel>(
//                      isExpanded: true,
//                      icon: Icon(Icons.arrow_drop_down),
//                      iconSize: 42,
//                      style: GoogleFonts.exo2(
//                        textStyle: TextStyle(
//                          fontSize: 20,
//                        ),
//                      ),
//                      underline: SizedBox(),
//                      value: unitSelect,
//                      onChanged: (UnitModel newValue) {
//                        FocusScope.of(context).requestFocus(FocusNode());
//                        setState(() {
//                          unitSelect = newValue;
//                        });
//                        print(unitSelect.unitName);
//                        sublist_bloc.getUnitID(unitSelect.id);
//                      },
//                      elevation: 25,
//                      items: data.map((UnitModel category) {
//                        return new DropdownMenuItem<UnitModel>(
//                          value: category,
//                          child: Padding(
//                            padding: const EdgeInsets.only(left:3.0),
//                            child: new Text(
//                              category.unitName,
//                              style: GoogleFonts.exo2(
//                                textStyle: TextStyle(
//                                  fontSize: 20,
//                                  color: Colors.black54,
//                                ),
//                              ),
//                            ),
//                          ),
//                        );
//                      }).toList(),
//                    ),
//                  ),


                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.only(left: 4),
                        child: Text(
                          "Unit",
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Container(
                          decoration: _getShadowDecoration(),
                          child: Card(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width-72,
                                      height: 50,
                                      child: DirectSelectList<UnitModel>(
                                        onUserTappedListener: () {
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                              'Hold and drag the item',
                                              style: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            duration: Duration(seconds: 2),
                                          ));
                                        },
                                        values: data,
                                        itemBuilder: (UnitModel unit) =>
                                            getDropDownMenuItem(unit),
                                        focusedItemDecoration: _getDslDecoration(),
                                        onItemSelectedListener: (value, selectedIndex, context) {
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          unitSelect = value;

                                          print(unitSelect.unitName.toString());
                                          print("ID HOITESE: " + unitSelect.id);
                                          sublist_bloc.getUnitID(unitSelect.id);


                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: _getDropdownIcon(),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),


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
