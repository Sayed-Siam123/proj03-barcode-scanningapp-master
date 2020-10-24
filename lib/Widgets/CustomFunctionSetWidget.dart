import 'dart:async';

import 'package:app/Model/CustomFunctionModel.dart';
import 'package:app/Model/CustomFunctionlistModel.dart';
import 'package:app/UI/Home.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFunctionSetWidget extends StatefulWidget {

  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;
  //int counter = 0;

  final VoidCallback onCountSelected;

  CustomFunctionSetWidget({this.height,this.width,this.scaffoldKey,this.onCountSelected});

  @override
  _CustomFunctionSetWidgetState createState() => _CustomFunctionSetWidgetState();
}

class _CustomFunctionSetWidgetState extends State<CustomFunctionSetWidget> {


  CustomFunctionModel custom = new CustomFunctionModel();
  List<CustomFunctionListModel> list_item =[];

  String _activateKey = "_activate";
  String _timestampKey = "_timestamp";
  String _code128Key = "_code128";
  String _ean13Key = "_ean13";
  String _datamatrixKey = "_datamatrix";
  String _qrcodeKey = "_qrcode";

  bool _activate = false;
  bool _timestamp = true;
  bool _code128 = true;
  bool _ean13 = true;
  bool _datamatrix = true;
  bool _qrcode = true;

  final _name = new TextEditingController();
  final _description = new TextEditingController();
  final _name_id = new TextEditingController();
  final _separator = new TextEditingController();

  var counter = 0;

  SnackbarHelper snack = new SnackbarHelper();
  SessionManager prefs = new SessionManager();

  List<TextEditingController> _controller = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.clear();
    list_item.clear();
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Custom Settings",
          style: new TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        actions: [
          new IconButton(
            tooltip: "clear",
            icon: new Icon(
              Icons.delete,
              color: Colors.black54,
            ),
            onPressed: () {

            },
          ),

          new IconButton(
            tooltip: "Create function",
            icon: new Icon(
              Icons.save,
              color: Colors.black54,
            ),
            onPressed: () {
              print(custom.field_list.length.toString());

              custom = CustomFunctionModel(
                name: _name.text,
                desc: _description.text,
                separator: _separator.text,
              );


              print(custom.name.toString());

              for(int i = 0; i < counter ; i++){
                setState(() {

                  list_item.add(CustomFunctionListModel(
                    name: _controller[i].text,
                  ));
                  custom = CustomFunctionModel(
                      field_list: list_item
                  );
                });

                print("Name: "+_controller[i].text);
                print("Type: "+custom.field_list[i].type);
              }



            },
          ),
        ],
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.pop(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
            setState(() {
              if(counter < 5){
                counter++;
                _controller.add(TextEditingController());
              }

              else{
                SnackbarHelper snack = new SnackbarHelper();
                snack.snackbarshowNormal(context, "Max. 5 is allowed to add", 1, Colors.black87);
              }

            });
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,size: hp(5),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: wp(100),
              color: Colors.transparent,
              margin: EdgeInsets.fromLTRB(wp(3),hp(3),wp(3),hp(2)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Custom Function",style: TextStyle(
                      fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),),

                  FutureBuilder(
                    future: getShared(_activateKey),
                    initialData: false,
                    builder: (context, snapshot){
                      return SwitchListTile(
                        title: const Text(
                          'Function activation',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.00,
                              fontWeight: FontWeight.w600),
                        ),
                        value: snapshot.data == null ? _activate : snapshot.data,
                        onChanged: (bool value) {
                          print("Current value" + "" +
                              value.toString());
                          setState(() {
                            _activate = value;
                            putShared(_activateKey, _activate);
                          });
                        },
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: hp(2.5)),
                        child: Row(
                          children: [
                            Text(
                              "Name",
                              style: GoogleFonts.exo2(
                                fontSize: hp(2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: wp(40),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            top: 0, left: 0, right: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 3),
                          child: TextField(
                              controller: _name,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Enter name",
                              )),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: hp(2),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: hp(2.5)),
                        child: Row(
                          children: [
                            Text(
                              "Description",
                              style: GoogleFonts.exo2(
                                fontSize: hp(2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: wp(40),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            top: 0, left: 0, right: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 3),
                          child: TextField(
                              controller: _description,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Enter description",
                              )),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: hp(1),),

                  Divider(),

                  SizedBox(height: hp(2),),

                  FutureBuilder(
                    future: getShared(_timestampKey),
                    initialData: false,
                    builder: (context, snapshot){
                      return SwitchListTile(
                        title: const Text(
                          'Timestamp',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.00,
                              fontWeight: FontWeight.w600),
                        ),
                        value: snapshot.data == null ? _timestamp : snapshot.data,
                        onChanged: (bool value) {
                          print("Current value" + "" +
                              value.toString());
                          setState(() {
                            _timestamp = value;
                            putShared(_timestampKey, _timestamp);
                          });
                        },
                      );
                    },
                  ),

                  SizedBox(
                    height: hp(2),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: hp(2.5)),
                        child: Row(
                          children: [
                            Text(
                              "Separator",
                              style: GoogleFonts.exo2(
                                fontSize: hp(2),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: wp(40),
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            top: 0, left: 0, right: 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 3),
                          child: TextField(
                              controller: _separator,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Enter Separator",
                              )),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hp(3)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: hp(2.5)),
                            child: Row(
                              children: [
                                Text(
                                  "File format",
                                  style: GoogleFonts.exo2(
                                    fontSize: hp(2),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            height: hp(8),
                            width: wp(40),
                            margin: EdgeInsets.fromLTRB(wp(0), hp(0), wp(0), 0),
                            padding: EdgeInsets.fromLTRB(wp(1), hp(0), hp(1), 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(wp(3))),
                              border: Border.all(),
                            ),
                            child: DropdownButton<String>(
                              underline: Icon(null),
                              isExpanded: true,
                              iconSize: hp(4),
                              hint: Text("Select file format",style: TextStyle(
                                fontSize: hp(2)
                              ),),
                              items: <String>['jpg', 'pdf', 'csv', 'docx'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {

                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: hp(1),),

                  Divider(),
                  SizedBox(height: hp(1),),

                  counter == 0 && _controller.isEmpty ? Padding(
                    padding: EdgeInsets.only(left: wp(35),top: hp(1)),
                    child: Text("Press + to add fields"),
                  ) :
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: counter,
                        itemBuilder: (context, index) {

                         print((index+1).toString()+": "+_controller[index].text);

                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: hp(1), right: wp(1), left: wp(1), bottom: hp(2)),
                                child: IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.delete,
                                  onTap: (){
                                    setState(() {
                                      counter--;
                                      _controller.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ],
                            child: Container(
                               margin: EdgeInsets.only(left: wp(0),top: hp(1)),
                               width: wp(90),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Field "+(index+1).toString(),style: TextStyle(
                                      fontSize: hp(2),
                                      fontWeight: FontWeight.w600,
                                    ),),
                                    SizedBox(height: hp(1),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: hp(2.5)),
                                          child: Row(
                                            children: [
                                              Icon(Icons.view_week,color: Colors.black45,),
                                              SizedBox(
                                                width: wp(7.5),
                                              ),
                                              Text(
                                                "Fieldtype",
                                                style: GoogleFonts.exo2(
                                                  fontSize: hp(2),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          height: hp(8),
                                          width: wp(40),
                                          margin: EdgeInsets.fromLTRB(wp(0), hp(0), wp(0), 0),
                                          padding: EdgeInsets.fromLTRB(wp(1), hp(0), hp(1), 0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(wp(3))),
                                            border: Border.all(),
                                          ),
                                          child: DropdownButton<String>(
                                            underline: Icon(null),
                                            isExpanded: true,
                                            iconSize: hp(4),
                                            hint: Text("Select",style: TextStyle(
                                                fontSize: hp(2)
                                            ),),
                                            items: <String>['Barcode', 'Numeric', 'Textfield'].map((String value) {
                                              return new DropdownMenuItem<String>(
                                                value: value,
                                                child: new Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                                // setState(() {
                                                // if(list_item[index].type.isNotEmpty){
                                                //   print("Got it");
                                                //   list_item.removeAt(index);
                                                // }
                                                // list_item[index].type = value;
                                                // print(list_item[index].type);

                                                // });

                                              setState(() {
                                                if(list_item.asMap().containsKey(index)){
                                                  print("got it");
                                                  list_item[index].type = value;
                                                }

                                                else{
                                                  list_item.add(CustomFunctionListModel(
                                                    type: value,
                                                  ));
                                                  custom = CustomFunctionModel(
                                                      field_list: list_item
                                                  );
                                                }
                                              });

                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: hp(1),),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: hp(2.5)),
                                          child: Row(
                                            children: [
                                              Icon(Icons.view_week,color: Colors.black45,),
                                              SizedBox(
                                                width: wp(7.5),
                                              ),
                                              Text(
                                                "Field Name",
                                                style: GoogleFonts.exo2(
                                                  fontSize: hp(2),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: wp(40),
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.only(
                                              top: 0, left: 0, right: 0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(1, 1),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 8.0, top: 3),
                                            child: TextField(
                                                controller: _controller[index],
                                                autocorrect: true,
                                                style: GoogleFonts.exo2(
                                                  textStyle: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  focusedBorder: InputBorder.none,
                                                  enabledBorder: InputBorder.none,
                                                  errorBorder: InputBorder.none,
                                                  disabledBorder: InputBorder.none,
                                                  hintStyle: GoogleFonts.exo2(
                                                    textStyle: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  labelStyle: GoogleFonts.exo2(
                                                    textStyle: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  hintText: "Enter field name",
                                                ),
                                              onChanged: (value){

                                                setState(() {
                                                  if(list_item.asMap().containsKey(index)){
                                                    print("got it");
                                                    list_item[index].name = value;
                                                  }

                                                  else{
                                                    list_item.add(CustomFunctionListModel(
                                                      name: value,
                                                    ));
                                                    custom = CustomFunctionModel(
                                                        field_list: list_item
                                                    );
                                                  }
                                                });

                                                // });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: hp(1),),
                                    Divider(),
                                    SizedBox(height: hp(1),),

                                  ],
                               ),
                             ),
                          );
                      },)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  void putShared(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  Future getShared(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool(key);
    return val;
  }

}
