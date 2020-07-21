import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/SubCategory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductSubCategoryDropDown extends StatefulWidget {

  String subcat,previous_id;

  EditProductSubCategoryDropDown({this.subcat,this.previous_id});

  @override
  _EditProductSubCategoryDropDownState createState() => _EditProductSubCategoryDropDownState();
}

class _EditProductSubCategoryDropDownState extends State<EditProductSubCategoryDropDown> {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.subcat!="" && _valSubCategoryName==""?
                  Text(widget.subcat,style: TextStyle(color: Colors.black),):Text(_valSubCategoryName),

                  SizedBox(width: 0,),

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
                              widget.previous_id = value.id.toString();
                            });
                            print("id is:"+ widget.previous_id );
                            sublist_bloc.getSubCategoryID(widget.previous_id );
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
