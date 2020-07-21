import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductManufacturerDropDown extends StatefulWidget {

  String manufac,previous_id;

  EditProductManufacturerDropDown({this.manufac,this.previous_id});

  @override
  _EditProductManufacturerDropDownState createState() => _EditProductManufacturerDropDownState();
}

class _EditProductManufacturerDropDownState extends State<EditProductManufacturerDropDown> {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  widget.manufac!="" && _valManufacName==""?
                  Text(widget.manufac,style: TextStyle(color: Colors.black),):Text(_valManufacName),

                  SizedBox(width: 15,),
                  Container(
                    width: 120,
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
                              widget.previous_id = value.id.toString();
                            });
                            print("id is:"+ widget.previous_id);

                            sublist_bloc.getManufacturerID(widget.previous_id);
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
