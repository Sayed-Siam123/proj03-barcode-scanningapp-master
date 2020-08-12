import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductCategoryDropDown extends StatefulWidget {
  @override
  _AddProductCategoryDropDownState createState() =>
      _AddProductCategoryDropDownState();
}

class _AddProductCategoryDropDownState
    extends State<AddProductCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valCategoryName = "";
  List<CategoryModel> _CategoryDesc = [];

  CategoryModel categorySelect;
  List<CategoryModel> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllCatagoryData();
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

                  Text(
                    "Category",
                    style: GoogleFonts.exo2(
                      textStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),

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
                    width: MediaQuery.of(context).size.width - 40,
                    child: new DropdownButton<CategoryModel>(
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      underline: SizedBox(),
                      value: categorySelect,
                      onChanged: (CategoryModel newValue) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          categorySelect = newValue;
                        });
                        print("ID HOITESE: " + categorySelect.id);
                        sublist_bloc.getCategoryID(categorySelect.id);
                      },
                      elevation: 25,
                      items: data.map((CategoryModel category) {
                        return new DropdownMenuItem<CategoryModel>(
                          value: category,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text(
                              category.categoryName,
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

  Widget masterdataview(data) {}
}
