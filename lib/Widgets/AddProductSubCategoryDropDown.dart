import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductSubCategoryDropDown extends StatefulWidget {

  @override
  _AddProductSubCategoryDropDownState createState() => _AddProductSubCategoryDropDownState();
}

class _AddProductSubCategoryDropDownState extends State<AddProductSubCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valSubCategoryName="";

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
            List<SubCategoryModel> data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

            return Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  _valSubCategoryName==""?
                  Text("Sub Category",style: TextStyle(color: Colors.grey),):Text(_valSubCategoryName),

                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          items: data.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.subCategoryName),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            // _valFriends = value;
                            setState(() {
                              _valSubCategoryName = value.subCategoryName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                            });
                            print("id is:"+ value.id.toString());
                            sublist_bloc.getSubCategoryID(value.id.toString());
                          }),
                    ),
                  ),
                ],
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
