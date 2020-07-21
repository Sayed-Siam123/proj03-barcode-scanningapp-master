import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDropDown extends StatefulWidget {

  @override
  _CategoryDropDownState createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valCategoryName;

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

            return DropdownButton(
                      hint: Text("Category"),
                      value: _valCategoryName,
                      items: data.map((value) {
                        return DropdownMenuItem(
                          child: Text(value.categoryName),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        // _valFriends = value;
                        setState(() {
                          //_valCategoryName = value.categoryName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                        });
                        print("id is:"+ value.id.toString());
                        sublist_bloc.getcategory_id(value.id.toString());
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
