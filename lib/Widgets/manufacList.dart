import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/ManufactureModel.dart';
import 'package:app/UI/ManufacViewPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManufacList extends StatefulWidget {
  @override
  _ManufacListState createState() => _ManufacListState();
}

class _ManufacListState extends State<ManufacList> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();


  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  //Toaster toast;

  final _resetKey = GlobalKey<FormState>();
  bool _resetValidate = false;

  bool _validate1;
  bool _validate2;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";

  void initState() {
    // TODO: implement initState
    sublist_bloc.fetchAllManufacDatafromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: StreamBuilder<List<ManufactureModel>>(
        stream: sublist_bloc.allmanufac,
        builder: (context, AsyncSnapshot<List<ManufactureModel>> snapshot) {
          if (snapshot.hasData) {
            List<ManufactureModel> data = snapshot.data;
            print("Data gula:: ");
            print(data.length);
            int lastID = int.parse(data.last.id.toString());
            print(lastID.toString());
            sublist_bloc.getLastID(lastID); //to get last id of list
            return masterdataview(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget masterdataview(data) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () {
        return sublist_bloc.fetchAllManufacDatafromDB();
      },
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
//              MasterDataWidget(gtin: data[index].gtin,
//                product_name:data[index].productName,
//                category: data[index].categoryName,
//                product_id: data[index].id,
//              ),

                Container(
                  margin: EdgeInsets.only(left: 6,right: 6,top: 1),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.only(left: 6,right: 6,top: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ListTile(
                        onTap: () {
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                          _showDialog(data[index].id.toString(),data[index].manufacturerName.toString());
                        },
                        title: Text(data[index].manufacturerName.toString(),
                            style: GoogleFonts.exo2(
                              textStyle: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),)),
                        trailing: IconButton(
                          onPressed: () {
                            //Navigator.of(context).pushNamed('/details');
//                      Navigator.pushReplacement(
//                          context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                            //TODO:: eikhane

                            _showDialog(data[index].id.toString(),data[index].manufacturerName.toString());

                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 1,
                )
              ],
            );
          }),
    );
  }

  _showDialog(String id, String manufacname) async {
    await showDialog<String>(
        context: context,
        builder: (_) =>

            StatefulBuilder(
              builder: (context, setState) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var height = MediaQuery
                          .of(context)
                          .size
                          .height;
                      var width = MediaQuery
                          .of(context)
                          .size
                          .width;

                      return Container(
                        height: height * 0.2,
                        width: 400,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).translate('update_manufac').toString(),
                              style: GoogleFonts.exo2(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  new Text(
                                    AppLocalizations.of(context).translate('manufac').toString(),
                                    style: GoogleFonts.exo2(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  new TextField(
                                    autofocus: true,
                                    style: GoogleFonts.exo2(
                                      fontSize: 14,
                                    ),
                                    decoration: new InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      hintText: manufacname.toString(),
                                      hintStyle: GoogleFonts.exo2(
                                        fontSize: 14,
                                      ),
                                      errorStyle: GoogleFonts.exo2(
                                        fontSize: 14,
                                      ),
                                      errorText: _validate1 == false
                                          ? errortext1
                                          : null,
                                    ),
                                    controller: _inputcontrol1,
                                    // ignore: missing_return
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: Text(
                          AppLocalizations.of(context).translate('cancel').toString(),
                          style: GoogleFonts.exo2(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          //_inputcontrol2.text = "";
                          Navigator.pop(context);
                        }),

                    new FlatButton(
                        child: Text(
                          AppLocalizations.of(context).translate('update').toString(),
                          style: GoogleFonts.exo2(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () {
                          //_inputcontrol2.text = "";
                          //Navigator.pop(context);


                          if (_inputcontrol1.text.isEmpty &&
                              _inputcontrol1.text == "") {
                            print("KHali");

                            setState(() {
                              _validate1 = false;
                            });

                            //TODO:: Toast hobe ekta
                          }

                          else {
                            setState(() {
                              _validate1 = true;
                            });

                            print("Vora");

                            print(_inputcontrol1.text);
                            //print(_inputcontrol2.text);

                            sublist_bloc.getManufacturerID(id.toString());
                            sublist_bloc.getmanufacturer(_inputcontrol1.text);
                            sublist_bloc.updateManufacDatafromDB();
                            sublist_bloc.dispose();

                            _inputcontrol1.text = "";
                            //_inputcontrol2.text = "";

//                            Fluttertoast.showToast(
//                                msg: "Manufacturer Added!",
//                                toastLength: Toast.LENGTH_SHORT,
//                                gravity: ToastGravity.BOTTOM,
//                                timeInSecForIosWeb: 1,
//                                backgroundColor: Colors.green,
//                                textColor: Colors.white,
//                                fontSize: 16.0);

                            Navigator.pop(context);
                            sublist_bloc.dispose();
                            sublist_bloc.fetchAllManufacData();
                          }

                        }),
                  ],
                );
              },
            )

    );
  }

}
