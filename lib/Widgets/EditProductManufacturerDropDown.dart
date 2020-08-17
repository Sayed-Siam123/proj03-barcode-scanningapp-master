import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProductManufacturerDropDown extends StatefulWidget {
  String manufac, previous_id;

  EditProductManufacturerDropDown({this.manufac, this.previous_id});

  @override
  _EditProductManufacturerDropDownState createState() =>
      _EditProductManufacturerDropDownState();
}

class _EditProductManufacturerDropDownState
    extends State<EditProductManufacturerDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valManufacName = "";

  ManufactureModel manufacturer;
  List<ManufactureModel> data;

  TextEditingController _manufacController = new TextEditingController();

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

//            return Container(
//              //color: Colors.red,
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(top: 5.0),
//                    child: Text(
//                      "Manufacturer",
//                      style: GoogleFonts.exo2(
//                        textStyle: TextStyle(
//                          fontSize: 18,
//                        ),
//                      ),
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 3.0),
//                    child: Container(
//                      height: 50,
//                      width: 370,
//                      decoration: BoxDecoration(
//                          border: Border.all(),
//                          borderRadius: BorderRadius.circular(5)),
//                      child: Row(
//                        children: <Widget>[
//                          Stack(
//                            children: <Widget>[
//                              Container(
//                                child: SizedBox(
//                                    height: 70,
//                                    width: 140,
//                                    child: Container(
//                                      padding: const EdgeInsets.only(
//                                          left: 4, bottom: 3),
//                                      child: TextField(
//                                        enabled: false,
//                                        style: GoogleFonts.exo2(
//                                          textStyle: TextStyle(
//                                            fontSize: 18,
//                                          ),
//                                        ),
//                                        controller: _manufacController,
//                                        decoration: InputDecoration(
//                                          hintText: widget.manufac,
//                                          hintStyle: GoogleFonts.exo2(
//                                            textStyle: TextStyle(
//                                              fontSize: 18,
//                                              color: Colors.black,
//                                            ),
//                                          ),
//                                          border: InputBorder.none,
//                                          focusedBorder: InputBorder.none,
//                                          enabledBorder: InputBorder.none,
//                                          errorBorder: InputBorder.none,
//                                          disabledBorder: InputBorder.none,
//                                        ),
//                                      ),
//                                    )),
//                              ),
//                              Container(
//                                padding: EdgeInsets.only(left: 164, top: 3),
//                                child: SizedBox(
//                                  height: 70,
//                                  width: 200,
//                                  child: Container(
//                                    height: 70,
//                                    width: 234,
//                                    child: DropdownButtonHideUnderline(
//                                      child: DropdownButton(
//                                          isExpanded: true,
//                                          icon: Icon(
//                                            Icons.arrow_drop_down,
//                                            size: 24,
//                                          ),
//                                          //hint: Text("Category"),
//                                          items: data.map((value) {
//                                            return new DropdownMenuItem<
//                                                ManufactureModel>(
//                                              child:
//                                                  Text(value.manufacturerName,style: GoogleFonts.exo2(
//                                                    textStyle: TextStyle(
//                                                      fontSize: 18,
//                                                      color: Colors.black,
//                                                    ),
//                                                  ),
//                                                ),
//                                              value: value,
//                                            );
//                                          }).toList(),
//                                          onChanged: (value) {
//                                            print("value ta holo: " +
//                                                value.manufacturerName);
//                                            // _valFriends = value;
//                                            //_valCategoryName = value.categoryName;
//                                            FocusScope.of(context)
//                                                .requestFocus(FocusNode());
//                                            setState(() {
//                                              //_valCategoryName = value.categoryName;
//                                              // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                              _manufacController.text = value
//                                                  .manufacturerName
//                                                  .toString();
//                                              _valManufacName =
//                                                  value.id.toString();
//                                            });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                            print("ManufacID: " +
//                                                widget.previous_id);
//
//                                            sublist_bloc.getManufacturerID(
//                                                _valManufacName);
//                                          }),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            );

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.only(left: 0),
                        child: Text(
                          "Manufacturer",
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          decoration: _getShadowDecoration(),
                          child: Card(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width-60,
                                      height: 50,
                                      child: DirectSelectList<ManufactureModel>(
                                        onUserTappedListener: () {
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text(
                                              'Hold and drag the item',
                                              style: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            duration: Duration(seconds: 2),
                                          ));
                                        },
                                        values: data,
                                        itemBuilder: (ManufactureModel category) =>
                                            getDropDownMenuItem(category),
                                        focusedItemDecoration: _getDslDecoration(),
                                        onItemSelectedListener: (value, selectedIndex, context) {
                                          FocusScope.of(context).requestFocus(FocusNode());
                                          manufacturer = value;

//                                          print(categorySelect.categoryName.toString());
//                                          print("ID HOITESE: " + categorySelect.id);
//                                          sublist_bloc.getCategoryID(categorySelect.id);


                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: _getDropdownIcon(),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            );

//            return Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//
//                  widget.manufac!="" && _valManufacName==""?
//                  Text(widget.manufac,style: TextStyle(color: Colors.black),):Text(_valManufacName),
//
//                  SizedBox(width: 15,),
//                  Container(
//                    width: 120,
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
//                              widget.previous_id = value.id.toString();
//                            });
//                            print("id is:"+ widget.previous_id);
//
//                            sublist_bloc.getManufacturerID(widget.previous_id);
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
//          return Center(child: CircularProgressIndicator());
//        },
//      ),
//    );

//            return Container(
//              child: Row(
//                children: <Widget>[
//                  Stack(
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.only(left: 27),
//                        child: SizedBox(
//                          height: 70,
//                          width: 140,
//                          child: Container(
//                            margin: EdgeInsets.only(top: 20),
//                            child: Text(
//                              "Manufacturer",
//                              textAlign: TextAlign.start,
//                              style: TextStyle(fontSize: 15),
//                            ),
//                          ),
//                        ),
//                      ),
////                      Container(
////                            padding: EdgeInsets.only(left: 165),
////                            child: SizedBox(
////                                height: 70,
////                                width: 130,
////                                child: Container(
////                                  margin: EdgeInsets.only(top: 20),
////                                  child: Text(
////                                    widget.manufac,
////                                    textAlign: TextAlign.justify,
////                                    style: TextStyle(fontSize: 16),
////                                  ),
////                                )),
////                          ),
////                      Container(
////                        padding: EdgeInsets.only(left: 259),
////                        child: SizedBox(
////                          height: 70,
////                          width: 120,
////                          child: Container(
////                            child: DropdownButtonHideUnderline(
////                              child: DropdownButton(
////                                  //hint: Text("Category"),
////                                  items: data.map((value) {
////                                    return new DropdownMenuItem<
////                                        ManufactureModel>(
////                                      child: Text(value.manufacturerName),
////                                      value: value,
////                                    );
////                                  }).toList(),
////                                  onChanged: (value) {
////                                    print("value ta holo: " +
////                                        value.manufacturerName);
////                                    // _valFriends = value;
////                                    //_valCategoryName = value.categoryName;
////                                    setState(() {
////                                      //_valCategoryName = value.categoryName;
////                                      // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
////
////                                      widget.manufac = value.manufacturerName;
////                                      widget.previous_id = value.id.toString();
////                                    });
//////                      print("id is:"+ value.categoryName.toString());
//////                      print("id is:"+ value.id.toString());
////                                    print("manufacturerID: " +
////                                        widget.previous_id);
////                                    sublist_bloc
////                                        .getManufacturerID(widget.previous_id);
////                                  }),
////                            ),
////                          ),
////                        ),
////                      ),
//
//                      Container(
//                        height: 45,
//                        width: 250,
//                        margin: EdgeInsets.only(left: 136),
//                        decoration:BoxDecoration(
//                          color: Colors.white,
//                          borderRadius: BorderRadius.circular(10),
//                        ),
//                        child: Stack(
//                          children: <Widget>[
//                          Container(
//                            padding: EdgeInsets.only(left: 25),
//                            child: SizedBox(
//                                height: 70,
//                                width: 130,
//                                child: Container(
//                                  margin: EdgeInsets.only(top: 20),
//                                  child: Text(
//                                    widget.manufac,
//                                    textAlign: TextAlign.justify,
//                                    style: TextStyle(fontSize: 16),
//                                  ),
//                                )),
//                          ),
//                      Container(
//                        padding: EdgeInsets.only(left: 132),
//                        child: SizedBox(
//                          height: 70,
//                          width: 113,
//                          child: Container(
//                            child: DropdownButtonHideUnderline(
//                              child: DropdownButton(
//                                  //hint: Text("Category"),
//                                  items: data.map((value) {
//                                    return new DropdownMenuItem<
//                                        ManufactureModel>(
//                                      child: Text(value.manufacturerName),
//                                      value: value,
//                                    );
//                                  }).toList(),
//                                  onChanged: (value) {
//                                    print("value ta holo: " +
//                                        value.manufacturerName);
//                                    // _valFriends = value;
//                                    //_valCategoryName = value.categoryName;
//                                    setState(() {
//                                      //_valCategoryName = value.categoryName;
//                                      // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//
//                                      widget.manufac = value.manufacturerName;
//                                      widget.previous_id = value.id.toString();
//                                    });
////                      print("id is:"+ value.categoryName.toString());
////                      print("id is:"+ value.id.toString());
//                                    print("manufacturerID: " +
//                                        widget.previous_id);
//                                    sublist_bloc
//                                        .getManufacturerID(widget.previous_id);
//                                  }),
//                            ),
//                          ),
//                        ),
//                      ),
//                          ],
//                        ),
//                      ),
//
//                      Container(),
//                    ],
//                  ),
//
////                      Text("Select Category"),
////
////
////                      SizedBox(width: 2,),
////
////
////                      new Container(
////                        padding:
////                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
////                        decoration: BoxDecoration(
////                            color: Colors.white,
////                            borderRadius: BorderRadius.circular(10)),
////
////                        height: 50,
////                        width: 250,
////                        child: new DropdownButton<CategoryModel>(
////                          isExpanded: true,
////                          icon: Icon(Icons.arrow_drop_down),
////                          iconSize: 42,
////                          underline: SizedBox(),
////                          value: categorySelect,
////                          onChanged: (CategoryModel newValue) {
////                            setState(() {
////                              categorySelect = newValue;
////                            });
////                            print(categorySelect.categoryName);
////                          },
////                          elevation: 25,
////                          items: data.map((CategoryModel category) {
////                            return new DropdownMenuItem<CategoryModel>(
////                              value: category,
////                              child: new Text(
////                                category.categoryName,
////                                style: new TextStyle(color: Colors.black),
////                              ),
////                            );
////                          }).toList(),
////                        ),
////                      ),
//
////
//////                      StatefulBuilder(
//////                        builder: (context, setState) {
//////                          return Container(
//////                            margin: EdgeInsets.all(20),
//////                            child: StreamBuilder<List<SingleMasterDataModel>>(
//////                                stream: masterdata_bloc.singleMasterData,
//////                                builder: (context,
//////                                    AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
//////                                  if (snapshot.hasData) {
//////                                    List<SingleMasterDataModel> data = snapshot.data;
//////                                    print("Data gula:: ");
//////                                    print(data.length);
//////                                    return masterdataview(data);
//////                                  } else if (snapshot.hasError) {
//////                                    return Text("${snapshot.error}");
//////                                  }
//////
//////                                  return Center(child: CircularProgressIndicator());
//////                                }),
//////                          );
//////                        },
//////                      ),
////
//                ],
//              ),
//            );

            //return Text(data[index].categoryName);

            //TODO:: eikhan theke start hbe

          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );

//            return Container(
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//
////                      widget.category==null ?
////                      Text("Category",style: TextStyle(color: Colors.black),):Text(widget.category),
////
////                      Container(
////                        child: DropdownButtonHideUnderline(
////                          child: DropdownButton(
////                            //hint: Text("Category"),
////                              items: data.map((value) {
////                                return new DropdownMenuItem<CategoryModel>(
////                                  child: Text(value.categoryName),
////                                  value: value,
////
////                                );
////                              }).toList(),
////                              onChanged: (value) {
////
////                                print("value ta holo: "+ value.categoryName);
////                                // _valFriends = value;
////                                //_valCategoryName = value.categoryName;
////                                setState(() {
////                                    //_valCategoryName = value.categoryName;
////                                  // Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
////
////                                  widget.category = value.categoryName;
////                                  widget.previous_id = value.id.toString();
////
////                                });
//////                      print("id is:"+ value.categoryName.toString());
//////                      print("id is:"+ value.id.toString());
////                                print("CategoryID: "+widget.previous_id);
////                                sublist_bloc.getCategoryID(widget.previous_id);
////
////                              }),
////                        ),
////
////                      ),
//
//                  Text("Select Category"),
//
//
//                  SizedBox(width: 2,),
//
//
//                  new Container(
//                    padding:
//                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                    decoration: BoxDecoration(
//                        color: Colors.white,
//                        borderRadius: BorderRadius.circular(10)),
//
//                    height: 50,
//                    width: 250,
//                    child: new DropdownButton<ManufactureModel>(
//                      isExpanded: true,
//                      icon: Icon(Icons.arrow_drop_down),
//                      iconSize: 42,
//                      underline: SizedBox(),
//                      value: manufacturer,
//                      onChanged: (ManufactureModel newValue) {
//                        setState(() {
//                          manufacturer = newValue;
//                        });
//                        print(manufacturer.manufacturerName);
//                      },
//                      elevation: 25,
//                      items: data.map((ManufactureModel manufacturer) {
//                        return new DropdownMenuItem<ManufactureModel>(
//                          value: manufacturer,
//                          child: new Text(
//                            manufacturer.manufacturerName,
//                            style: new TextStyle(color: Colors.black),
//                          ),
//                        );
//                      }).toList(),
//                    ),
//                  ),
//
//
////
//////                      StatefulBuilder(
//////                        builder: (context, setState) {
//////                          return Container(
//////                            margin: EdgeInsets.all(20),
//////                            child: StreamBuilder<List<SingleMasterDataModel>>(
//////                                stream: masterdata_bloc.singleMasterData,
//////                                builder: (context,
//////                                    AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
//////                                  if (snapshot.hasData) {
//////                                    List<SingleMasterDataModel> data = snapshot.data;
//////                                    print("Data gula:: ");
//////                                    print(data.length);
//////                                    return masterdataview(data);
//////                                  } else if (snapshot.hasError) {
//////                                    return Text("${snapshot.error}");
//////                                  }
//////
//////                                  return Center(child: CircularProgressIndicator());
//////                                }),
//////                          );
//////                        },
//////                      ),
////
//                ],
//              ),
//            );
  }

  //TODO:: eikhan theke kaj shuru hbe

  Widget masterdataview(data) {}

  DirectSelectItem<ManufactureModel> getDropDownMenuItem(ManufactureModel value) {
    return DirectSelectItem<ManufactureModel>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(value.manufacturerName,
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 14,
                ),
              ),),
          );
        });
  }

  _getDslDecoration() {
    return BoxDecoration(
      border: BorderDirectional(
        bottom: BorderSide(width: 1, color: Colors.black12),
        top: BorderSide(width: 1, color: Colors.black12),
      ),
    );
  }

  BoxDecoration _getShadowDecoration() {
    return BoxDecoration(
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black.withOpacity(0.06),
          spreadRadius: 4,
          offset: new Offset(1, 1),
          blurRadius: 15.0,
        ),
      ],
    );
  }

  Icon _getDropdownIcon() {
    return Icon(
      Icons.unfold_more,
      color: Colors.grey.shade700,
    );
  }

}
