import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Widgets/CategoryList.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Sublist.dart';

class CategorieViewPage extends StatefulWidget {
  @override
  _CategorieViewPageState createState() => _CategorieViewPageState();
}

class _CategorieViewPageState extends State<CategorieViewPage> {

  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  //Toaster toast;

  final _resetKey = GlobalKey<FormState>();
  bool _resetValidate = false;

  bool _validate1;
  bool _validate2;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () =>
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SublistPage())),

      child: Scaffold (
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black45,
              ),
              onPressed: (){
                //Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SublistPage()));

              }
          ),
          title: Text(
            "Category",
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),)
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          centerTitle: true,

        ),
//        body: MasterdataView(),
      body: CategoryList(),

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
          child: Icon(Icons.add,
            size: 50,
          ),
          backgroundColor: Colors.black,
        ),

      ),
    );
  }

  _showDialog() async {
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
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return Container(
                    height: height * 0.2,
                    width: 400,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "NEW CATEGORY",
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
                                "Category",
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
                                  hintText: 'Wines',
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
                      'CANCEL',
                      style: GoogleFonts.exo2(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      _inputcontrol1.text = "";
                      //_inputcontrol2.text = "";
                      Navigator.pop(context);
                    }),
                new FlatButton(
                    child: Text(
                      'ADD',
                      style: GoogleFonts.exo2(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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

                      else {

                        setState(() {
                          _validate1 = true;
                        });

                        print("Vora");

                        print(_inputcontrol1.text);
                        //print(_inputcontrol2.text);

                        sublist_bloc.getcategory(_inputcontrol1.text);
                        //sublist_bloc.createcategory();

                        _inputcontrol1.text = "";
                        //_inputcontrol2.text = "";

                        Fluttertoast.showToast(
                            msg: "Category Added!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        CategoryModel data = CategoryModel(
                          id: null,
                          categoryName: null,
                          updateFlag: "false",
                          newFlag: 'true',
                        );

                        Navigator.pop(context);
                        sublist_bloc.insertCatDatatoDB(data);
                        sublist_bloc.dispose();
                        sublist_bloc.fetchAllCatDatafromDB();


                      }

//                      setState(() {
//                        _inputcontrol2.text.isEmpty || _inputcontrol2.text == '' ? _validate = true : _validate = false;
//                      });
                    })
              ],
            );
          },
        )

        );
//    AwesomeDialog(
//      context: context,
//      headerAnimationLoop: false,
//
//      dialogType: DialogType.SUCCES,
//      animType: AnimType.TOPSLIDE,
//      body: Form(
//        key: _resetKey,
//        autovalidate: _resetValidate,
//        child: Container(
//          child: Padding(
//            padding: const EdgeInsets.only(left:8.0,right: 8.0),
//            child: TextFormField(
//              autofocus: true,
//              decoration: new InputDecoration(
//                labelText: 'Category',
//                hintText: 'eg. Wines',
//                labelStyle: GoogleFonts.exo2(
//                  textStyle: TextStyle(
//                    fontSize: 20,
//                  ),
//                ),
//                hintStyle: GoogleFonts.exo2(
//                  textStyle: TextStyle(
//                    fontSize: 20,
//                  ),
//                ),
//                errorText: _validate1 == false ? errortext1 : null,
//              ),
//              controller: _inputcontrol1,
//              // ignore: missing_return
//            ),
//          ),
//        ),
//      ),
//      btnCancelOnPress: () {
//        _inputcontrol1.text = "";
//        //_inputcontrol2.text = "";
//        //Navigator.pop(context);
//      },
//      btnOkOnPress: () {
//        if (_inputcontrol1.text.isEmpty && _inputcontrol1.text == "") {
//          print("KHali");
//
//          setState(() {
//            _validate1 = false;
//          });
//
//          //TODO:: Toast hobe ekta
//        }
//
////                  else if (_inputcontrol2.text.isEmpty &&
////                      _inputcontrol2.text == "") {
////                    print("eitao KHali");
////                    //TODO:: Toast hobe ekta
////                  }
//
//        else {
//          setState(() {
//            _validate1 = true;
//          });
//
//          print("Vora");
//
//          print(_inputcontrol1.text);
//          //print(_inputcontrol2.text);
//
//          sublist_bloc.getcategory(_inputcontrol1.text);
//          sublist_bloc.createcategory();
//
//          _inputcontrol1.text = "";
//          //_inputcontrol2.text = "";
//
//          Scaffold.of(context).showSnackBar(SnackBar(
//            content: Text(
//              'Successfully Added',
//              style: GoogleFonts.exo2(
//                textStyle: TextStyle(
//                  fontSize: 16,
//                ),
//              ),
//            ),
//            duration: Duration(seconds: 2),
//          ));
//
//          sublist_bloc.dispose();
//          sublist_bloc.fetchAllCatagoryData();
//        }
//      },
//    )..show();
  }

  String validateinput1(String value) {
    if (value.length == 0) {
      return "Value is required";
    } else {
      return null;
    }
  }


}

