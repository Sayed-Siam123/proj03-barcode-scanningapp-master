import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnitDropDown extends StatefulWidget {

  @override
  _UnitDropDownState createState() => _UnitDropDownState();
}

class _UnitDropDownState extends State<UnitDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valUnitName;

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

            return DropdownButton(
                      hint: Text("Unit"),
                      value: _valUnitName,
                      items: data.map((value) {
                        return DropdownMenuItem(
                          child: Text(value.unitName),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        // _valFriends = value;
                        setState(() {
                          //_valCategoryName = value.categoryName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                        });
                        print("id is:"+ value.id.toString());
                        sublist_bloc.getunit_id(value.id.toString());
                      });
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
