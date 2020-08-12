import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    sublist_bloc.fetchAllSubCatagoryData();
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
                mainAxisAlignment: MainAxisAlignment.start,
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

                  Text("Sub Category",style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),),


                  SizedBox(height: 5,),


                  new Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    height: 50,
                    width: MediaQuery.of(context).size.width-40,
                    child: new DropdownButton<SubCategoryModel>(
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: SizedBox(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      value: subcategorySelect,
                      onChanged: (SubCategoryModel newValue) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          subcategorySelect = newValue;
                        });
                        print(subcategorySelect.subCategoryName);
                        sublist_bloc.getSubCategoryID(subcategorySelect.id);
                      },
                      elevation: 25,
                      items: data.map((SubCategoryModel manufac) {
                        return new DropdownMenuItem<SubCategoryModel>(
                          value: manufac,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: new Text(
                              manufac.subCategoryName,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  color: Colors.black54,
                                ),
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
