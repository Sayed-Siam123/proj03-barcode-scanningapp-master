import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProductManufacturerDropDown extends StatefulWidget {

  @override
  _AddProductManufacturerDropDownState createState() => _AddProductManufacturerDropDownState();
}

class _AddProductManufacturerDropDownState extends State<AddProductManufacturerDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valManufacName="";

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

            return Container(
              margin: EdgeInsets.only(left:35),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  _valManufacName==""?
                  Text("Manufacture",style: TextStyle(color: Colors.grey),):Text(_valManufacName),


                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          items: data.map((value) {
                            return DropdownMenuItem(
                              child: Text(value.manufacturerName),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            // _valFriends = value;
                            setState(() {
                              _valManufacName = value.manufacturerName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                            });
                            print("id is:"+ value.id.toString());

                            sublist_bloc.getManufacturerID(value.id.toString());
                          }),
                    ),
                  ),



                ],
              ),
            );
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
