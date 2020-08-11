import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/Model/unit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductManufacturerDropDown extends StatefulWidget {

  @override
  _AddProductManufacturerDropDownState createState() => _AddProductManufacturerDropDownState();
}

class _AddProductManufacturerDropDownState extends State<AddProductManufacturerDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valManufacName="";

  ManufactureModel manufacSelect;
  List<ManufactureModel> data;

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
            data = snapshot.data;
            print("Cat er Data gula:: ");
            print(data.length);
            //return masterdataview(data);

//            return Container(
//              margin: EdgeInsets.only(left:35),
//              child: Row(
//                mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//
//                  _valManufacName==""?
//                  Text("Manufacture",style: TextStyle(color: Colors.grey),):Text(_valManufacName),
//
//
//                  Container(
//                    child: DropdownButtonHideUnderline(
//                      child: DropdownButton(
//                          items: data.map((value) {
//                            return DropdownMenuItem(
//                              child: Text(value.manufacturerName),
//                              value: value,
//                            );
//                          }).toList(),
//                          onChanged: (value) {
//                            // _valFriends = value;
//                            setState(() {
//                              _valManufacName = value.manufacturerName.toString(); //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//                            });
//                            print("id is:"+ value.id.toString());
//
//                            sublist_bloc.getManufacturerID(value.id.toString());
//                          }),
//                    ),
//                  ),
//
//
//
//                ],
//              ),
//            );
//                  //return Text(data[index].categoryName);+
//
//            //TODO:: eikhan theke start hbe
//
//          } else if (snapshot.hasError) {
//            return Text("${snapshot.error}");
//          }
//
//          return CircularProgressIndicator();
//        },
//      ),
//    );

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

//                      widget.category==null ?
//                      Text("Category",style: TextStyle(color: Colors.black),):Text(widget.category),
//
//                      Container(
//                        child: DropdownButtonHideUnderline(
//                          child: DropdownButton(
//                            //hint: Text("Category"),
//                              items: data.map((value) {
//                                return new DropdownMenuItem<CategoryModel>(
//                                  child: Text(value.categoryName),
//                                  value: value,
//
//                                );
//                              }).toList(),
//                              onChanged: (value) {
//
//                                print("value ta holo: "+ value.categoryName);
//                                // _valFriends = value;
//                                //_valCategoryName = value.categoryName;
//                                setState(() {
//                                    //_valCategoryName = value.categoryName;
//                                  // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                  widget.category = value.categoryName;
//                                  widget.previous_id = value.id.toString();
//
//                                });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                print("CategoryID: "+widget.previous_id);
//                                sublist_bloc.getCategoryID(widget.previous_id);
//
//                              }),
//                        ),
//
//                      ),

                  Text("Manufacturer",style: GoogleFonts.exo2(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),),


                  SizedBox(height: 5,),


                  new Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                    height: 50,
                    width: MediaQuery.of(context).size.width-40,
                    child: new DropdownButton<ManufactureModel>(
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      underline: SizedBox(),
                      value: manufacSelect,
                      onChanged: (ManufactureModel newValue) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        setState(() {
                          manufacSelect = newValue;
                        });
                        print(manufacSelect.manufacturerName);
                        sublist_bloc.getManufacturerID(manufacSelect.id);
                      },
                      elevation: 25,
                      items: data.map((ManufactureModel manufac) {
                        return new DropdownMenuItem<ManufactureModel>(
                          value: manufac,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: new Text(
                              manufac.manufacturerName,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),


//
////                      StatefulBuilder(
////                        builder: (context, setState) {
////                          return Container(
////                            margin: EdgeInsets.all(20),
////                            child: StreamBuilder<List<SingleMasterDataModel>>(
////                                stream: masterdata_bloc.singleMasterData,
////                                builder: (context,
////                                    AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
////                                  if (snapshot.hasData) {
////                                    List<SingleMasterDataModel> data = snapshot.data;
////                                    print("Data gula:: ");
////                                    print(data.length);
////                                    return masterdataview(data);
////                                  } else if (snapshot.hasError) {
////                                    return Text("${snapshot.error}");
////                                  }
////
////                                  return Center(child: CircularProgressIndicator());
////                                }),
////                          );
////                        },
////                      ),
//
                ],
              ),
            );



            //return Text(data[index].categoryName);

            //TODO:: eikhan theke start hbe

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  //TODO:: eikhan theke kaj shuru hbe

  Widget masterdataview(data) {
  }
}
