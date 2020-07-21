import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubCategoryDropDown extends StatefulWidget {

  @override
  _SubCategoryDropDownState createState() => _SubCategoryDropDownState();
}

class _SubCategoryDropDownState extends State<SubCategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valSubCategoryName;

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

            return Container(
              width: 140,
              child: DropdownButton(
                        hint: Text("Sub Category"),
                        value: _valSubCategoryName,
                        items: data.map((value) {
                          return DropdownMenuItem(
                            child: Text(value.subCategoryName),
                            value: value,
                          );
                        }).toList(),
                        onChanged: (value) {
                          // _valFriends = value;
                          setState(() {
                            //_valCategoryName = value.categoryName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                          });
                          print("id is:"+ value.id.toString());
                          sublist_bloc.getsubcategory_id(value.id.toString());
                        }),
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
