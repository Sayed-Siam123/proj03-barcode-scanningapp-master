import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Widgets/CategoryDropDown.dart';
import 'package:app/Widgets/SubCategoryList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Sublist.dart';

class SubCatPageView extends StatefulWidget {
  @override
  _SubCatPageViewState createState() => _SubCatPageViewState();
}

class _SubCatPageViewState extends State<SubCatPageView> {
  String _valCategoryName;
  List _myFriends = [
    "Clara",
    "John",
    "Rizal",
    "Steve",
    "Laurel",
    "Bernard",
    "Miechel"
  ];

  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  //Toaster toast;

  final _resetKey = GlobalKey<FormState>();
  bool _resetValidate = false;

  bool _validate1;
  bool _validate2 = false;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";

  @override
  void initState() {
    sublist_bloc.fetchAllCatagoryData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sublist_bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SublistPage())),
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black45,
              ),
              onPressed: () {
                //Navigator.pop(context);
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => HomePage())
//                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SublistPage()));
              }),
          title: Text(
            "Sub Category",
            style: new TextStyle(color: Colors.black54),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,
        ),
//        body: MasterdataView(),
        body: SubCategoryList(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("jabs");
//            Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => AddProductPage())
//            );
            // Add your onPressed code here!
            _showDialog();
          },
          child: Icon(
            Icons.add,
            size: 50,
          ),
          backgroundColor: Colors.black,
        ),
      ),
    );
  }

//  _showDialog() async {
//    await showDialog<String>(
//        context: context,
//        builder: (_) => new AlertDialog(
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
//              content: Builder(
//                builder: (context) {
//                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
//                  var height = MediaQuery.of(context).size.height;
//                  var width = MediaQuery.of(context).size.width;
//
//                  return Container(
//                    height: height - 680,
//                    width: width - 200,
//                    child: new Column(
//                      children: <Widget>[
//                    Container(
//                      child: StreamBuilder<List<CategoryModel>>(
//                        stream: sublist_bloc.allcategory,
//                        builder: (context, AsyncSnapshot<List<CategoryModel>> snapshot) {
//                          if (snapshot.hasData) {
//                            List<CategoryModel> data = snapshot.data;
//                            print("Cat DAta ache Data gula:: ");
//                            print(data.length);
//                            return masterdataview(data);
//                          } else if (snapshot.hasError) {
//                            return Text("${snapshot.error}");
//                          }
//
//                          return Center(child: CircularProgressIndicator());
//                        },
//                      ),
//                    ),
//
////                        DropdownButton(
////                          hint: Text("Select The Gender"),
////                          value: _valFriends,
////                          items: _myFriends.map((value) {
////                            return DropdownMenuItem(
////                              child: Text(value),
////                              value: value,
////                            );
////                          }).toList(),
////                          onChanged: (value) {
////                            // _valFriends = value;
////                            setState(() {
////                              _valFriends =
////                                  value; //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
////                            });
////                            print(_valFriends);
////                          },
////                        ),
//
//                        SizedBox(
//                          height: 10,
//                        ),
//
//                        new Expanded(
//                          child: new TextField(
//                            autofocus: true,
//                            decoration: new InputDecoration(
//                                labelText: 'Sub Category',
//                                hintText: 'eg. Rose Wine'),
//                          ),
//                        ),
//                      ],
//                    ),
//                  );
//                },
//              ),
//              actions: <Widget>[
//                new FlatButton(
//                    child: const Text('CANCEL'),
//                    onPressed: () {
//                      Navigator.pop(context);
//                    }),
//                new FlatButton(
//                    child: const Text('ADD'),
//                    onPressed: () {
////                Navigator.pop(context);
//                    })
//              ],
//            ));
//  }

  _showDialog() async {
    await showDialog<String>(
        context: context,
        builder: (_) => StatefulBuilder(
              builder: (context, setState) {
                return new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;

                      return Container(
                        height: height - 600,
                        width: width - 200,
                        child: new Column(
                          children: <Widget>[
                            CategoryDropDown(),
                            SizedBox(
                              height: 15,
                            ),
                            new Expanded(
                              child: new TextField(
                                autofocus: true,
                                decoration: new InputDecoration(
                                  labelText: 'Sub Category',
                                  hintText: 'eg. Rose Wine',
                                  errorText:
                                      _validate1 == false ? errortext1 : null,
                                ),
                                controller: _inputcontrol1,
                                // ignore: missing_return
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  actions: <Widget>[
                    new FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          _inputcontrol1.text = "";
                          //_inputcontrol2.text = "";
                          Navigator.pop(context);
                        }),
                    new FlatButton(
                        child: const Text('ADD'),
                        onPressed: () {
//                Navigator.pop(context);

                          if (_inputcontrol1.text.isEmpty &&
                              _inputcontrol1.text == "") {
                            print("KHali");

                            setState(() {
                              _validate1 = false;
                            });
                            //TODO:: Toast hobe ekta
                          }

//                  else if (_inputcontrol2.text.isEmpty &&
//                      _inputcontrol2.text == "") {
//                    print("eitao KHali");
//                    //TODO:: Toast hobe ekta
//                  }

                          else {
                            setState(() {
                              _validate1 = true;
                            });

                            print("Vora");

                            print(_inputcontrol1.text);
                            //print(_inputcontrol2.text);

                            sublist_bloc.getsub_category(_inputcontrol1.text);
                            sublist_bloc.createsubcategory();

                            _inputcontrol1.text = "";
                            //_inputcontrol2.text = "";

                            Fluttertoast.showToast(
                                msg: "Sub Category Added!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Navigator.pop(context);
                            sublist_bloc.dispose();
                            sublist_bloc.fetchAllSubCatagoryData();
                          }

//                      setState(() {
//                        _inputcontrol2.text.isEmpty || _inputcontrol2.text == '' ? _validate = true : _validate = false;
//                      });
                        })
                  ],
                );
              },
            ));
  }

  String validateinput1(String value) {
    if (value.length == 0) {
      return "Value is required";
    } else {
      return null;
    }
  }

//  Widget masterdataview(data) {
//    ListView.builder(
//        scrollDirection: Axis.vertical,
//        itemCount: data.length,
//        itemBuilder: (BuildContext context, int index) {
//          //return Text(data[index].categoryName);
//          return StatefulBuilder(
//              builder: (BuildContext context, StateSetter setState) {
//            return DropdownButton(
//                hint: Text("Select The Gender"),
//                value: _valCategoryName,
//                items: data[index].categoryName.map((value) {
//                  return DropdownMenuItem(
//                    child: Text(value),
//                    value: value,
//                  );
//                }).toList(),
//                onChanged: (value) {
//                  // _valFriends = value;
//                  setState(() {
//                    _valCategoryName =
//                        value; //Untuk memberitahu _valGender bahwa isi nya akan diubah sesuai dengan value yang kita pilih
//                  });
//                  print(_valCategoryName);
//                  sublist_bloc.getcategory_id(data[index].id);
//                });
//          });
//        });
//  }
}
