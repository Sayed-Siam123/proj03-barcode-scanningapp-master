import 'dart:convert';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductCategoryDropDown extends StatefulWidget {

  String category,previous_id;

  EditProductCategoryDropDown({this.category,this.previous_id});

  @override
  _EditProductCategoryDropDownState createState() => _EditProductCategoryDropDownState();
}

class _EditProductCategoryDropDownState extends State<EditProductCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valCategoryName="";
  String _valCategoryID = "";
  List<CategoryModel> _CategoryDesc = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllCatagoryData();
    masterdata_bloc.getsinglemasterdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<CategoryModel>>(
        stream: sublist_bloc.allcategory,
        builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            List<CategoryModel> data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      widget.category!="" && _valCategoryName==""?
                      Text(widget.category,style: TextStyle(color: Colors.black),):Text(_valCategoryName),

                      Container(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            //hint: Text("Category"),
                              items: data.map((value) {
                                return new DropdownMenuItem<CategoryModel>(
                                  child: Text(value.categoryName),
                                  value: value,

                                );
                              }).toList(),
                              onChanged: (value) {

                                print("value ta holo: "+ value.categoryName);
                                // _valFriends = value;
                                //_valCategoryName = value.categoryName;
                                setState(() {
                                    //_valCategoryName = value.categoryName;
                                  // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih

                                  _valCategoryName = value.categoryName;
                                  widget.previous_id = value.id.toString();

                                });
//                      print("id is:"+ value.categoryName.toString());
//                      print("id is:"+ value.id.toString());
                                print("CategoryID: "+widget.previous_id);
                                sublist_bloc.getCategoryID(widget.previous_id);

                              }),
                        ),

                      ),

//                      StatefulBuilder(
//                        builder: (context, setState) {
//                          return Container(
//                            margin: EdgeInsets.all(20),
//                            child: StreamBuilder<List<SingleMasterDataModel>>(
//                                stream: masterdata_bloc.singleMasterData,
//                                builder: (context,
//                                    AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
//                                  if (snapshot.hasData) {
//                                    List<SingleMasterDataModel> data = snapshot.data;
//                                    print("Data gula:: ");
//                                    print(data.length);
//                                    return masterdataview(data);
//                                  } else if (snapshot.hasError) {
//                                    return Text("${snapshot.error}");
//                                  }
//
//                                  return Center(child: CircularProgressIndicator());
//                                }),
//                          );
//                        },
//                      ),

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
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
//          return Text(data[index].productName);
          //_valCategoryID = data[index].categoryName.toString();
//            productName.text = data[index].productDescription;



        });
  }
}
