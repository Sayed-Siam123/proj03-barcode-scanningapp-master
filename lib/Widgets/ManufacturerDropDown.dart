import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManufacturerDropDown extends StatefulWidget {

  @override
  _ManufacturerDropDownState createState() => _ManufacturerDropDownState();
}

class _ManufacturerDropDownState extends State<ManufacturerDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valManufacName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllManufacData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<List<ManufactureModel>>(
        stream: sublist_bloc.allmanufac,
        builder: (context, AsyncSnapshot<List<ManufactureModel>> snapshot) {
          if (snapshot.hasData) {
            List<ManufactureModel> data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

            return DropdownButton(
                      hint: Text("Manufacturer"),
                      value: _valManufacName,
                      items: data.map((value) {
                        return DropdownMenuItem(
                          child: Text(value.manufacturerName),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        // _valFriends = value;
                        setState(() {
                          //_valCategoryName = value.categoryName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                        });
                        print("id is:"+ value.id.toString());
                        sublist_bloc.getmanufacturer_id(value.id.toString());
                      });
                  //return Text(data[index].categoryName);+

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
