import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductUnitDropDown extends StatefulWidget {

  String unit,previous_id;

  EditProductUnitDropDown({this.unit,this.previous_id});

  @override
  _EditProductUnitDropDownState createState() => _EditProductUnitDropDownState();
}

class _EditProductUnitDropDownState extends State<EditProductUnitDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valUnitName="";

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
            List<UnitModel> data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  widget.unit!="" && _valUnitName==""?
                  Text(widget.unit,style: TextStyle(color: Colors.black),):Text(_valUnitName),

                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          items: data.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.unitName),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            // _valFriends = value;
                            setState(() {
                              _valUnitName = value.unitName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                              widget.previous_id = value.id.toString();
                            });
                            print("id is:"+ widget.previous_id);
                            sublist_bloc.getUnitID(widget.previous_id);
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
