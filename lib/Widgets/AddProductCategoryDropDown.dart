import 'dart:convert';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductCategoryDropDown extends StatefulWidget {

  @override
  _AddProductCategoryDropDownState createState() => _AddProductCategoryDropDownState();
}

class _AddProductCategoryDropDownState extends State<AddProductCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valCategoryName="";
  List<CategoryModel> _CategoryDesc = [];

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
            List<CategoryModel> data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

                return Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      _valCategoryName==""?
                      Text("Select Category",style: TextStyle(color: Colors.grey),):Text(_valCategoryName),

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
                                    _valCategoryName = value.categoryName; //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                                });
//                      print("id is:"+ value.categoryName.toString());
//                      print("id is:"+ value.id.toString());
                                print("Category: "+_valCategoryName);
                                sublist_bloc.getCategoryID(value.id.toString());

                              }),
                        ),

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
}
