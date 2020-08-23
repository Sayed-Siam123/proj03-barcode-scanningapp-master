import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductManufacturerDropDown extends StatefulWidget {
  @override
  _AddProductManufacturerDropDownState createState() =>
      _AddProductManufacturerDropDownState();
}

class _AddProductManufacturerDropDownState
    extends State<AddProductManufacturerDropDown> {
  //List<CategoryModel> _valCategoryName = List();

  String _valManufacName = "";

  ManufactureModel manufacSelect;
  List<ManufactureModel> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sublist_bloc.fetchAllManufacDatafromDB();
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

            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        margin: EdgeInsets.only(left: 4),
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
                        padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Container(
                          decoration: _getShadowDecoration(),
                          child: Card(
                              child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 72,
                                  height: 50,
                                  child: DirectSelectList<ManufactureModel>(
                                    onUserTappedListener: () {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
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
                                    itemBuilder: (ManufactureModel manufac) =>
                                        getDropDownMenuItem(manufac),
                                    focusedItemDecoration: _getDslDecoration(),
                                    onItemSelectedListener:
                                        (value, selectedIndex, context) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      manufacSelect = value;

                                      print(manufacSelect.manufacturerName
                                          .toString());
                                      print("ID HOITESE: " + manufacSelect.id);
                                      sublist_bloc.getManufacturerID(manufacSelect.id);
                                      sublist_bloc.getManufacturerName(manufacSelect.manufacturerName);
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

  Widget masterdataview(data) {}

  DirectSelectItem<ManufactureModel> getDropDownMenuItem(
      ManufactureModel value) {
    return DirectSelectItem<ManufactureModel>(
        itemHeight: 56,
        value: value,
        itemBuilder: (context, value) {
          return Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              value.manufacturerName,
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
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
          offset: new Offset(0.0, 0.0),
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
