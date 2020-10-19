import 'package:app/UI/PhotoDocumentation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoDocumetationSettings extends StatefulWidget {
  @override
  _PhotoDocumetationSettingsState createState() => _PhotoDocumetationSettingsState();
}

class _PhotoDocumetationSettingsState extends State<PhotoDocumetationSettings> {

  bool _func_active = true;
  String _func_active_key = "_photodocument_key";

  bool _name = true;
  String _name_key = "_namerequire_key";

  bool _signature = true;
  String _signature_key = "_signature_key";

  bool _comment = true;
  String _comment_key = "_comment_key";

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Photo Documetation Settings",
          style: new TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PhotoDocumentationPage()));
          },
        ),
      ),

      body: Container(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Container(
              width: wp(100),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: EdgeInsets.only(left: wp(3),top: hp(2)),
                    child: Text("Photo documentation",style: TextStyle(
                      fontSize: hp(2),
                      fontWeight: FontWeight.w600
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: getShared(_func_active_key),
                        initialData: false,
                        builder: (context, snapshot) {
                          return SwitchListTile(
                            title: const Text(
                              'Function is active',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.00,
                                  fontWeight: FontWeight.w600),
                            ),
                            value: snapshot.data == null ? _func_active : snapshot.data,
                            onChanged: (bool value) {
                              print("Current value" + " " + value.toString());
                              setState(() {
                                _func_active = value;
                                putShared(_func_active_key, _func_active);
                              });
                            },
                            secondary: const Icon(Icons.view_week),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: getShared(_name_key),
                        initialData: false,
                        builder: (context, snapshot) {
                          return SwitchListTile(
                            title: const Text(
                              'Name required',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.00,
                                  fontWeight: FontWeight.w600),
                            ),
                            value: snapshot.data == null ? _name : snapshot.data,
                            onChanged: (bool value) {
                              print("Current value" + " " + value.toString());
                              setState(() {
                                _name = value;
                                putShared(_name_key, _name);
                              });
                            },
                            secondary: const Icon(Icons.view_week),
                          );
                        },
                      ),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: getShared(_comment_key),
                        initialData: false,
                        builder: (context, snapshot) {
                          return SwitchListTile(
                            title: const Text(
                              'Comment required',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.00,
                                  fontWeight: FontWeight.w600),
                            ),
                            value: snapshot.data == null ? _comment : snapshot.data,
                            onChanged: (bool value) {
                              print("Current value" + " " + value.toString());
                              setState(() {
                                _comment = value;
                                putShared(_comment_key, _comment);
                              });
                            },
                            secondary: const Icon(Icons.view_week),
                          );
                        },
                      ),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FutureBuilder(
                        future: getShared(_signature_key),
                        initialData: false,
                        builder: (context, snapshot) {
                          return SwitchListTile(
                            title: const Text(
                              'Signature required',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.00,
                                  fontWeight: FontWeight.w600),
                            ),
                            value: snapshot.data == null ? _signature : snapshot.data,
                            onChanged: (bool value) {
                              print("Current value" + " " + value.toString());
                              setState(() {
                                _signature = value;
                                putShared(_signature_key, _signature);
                              });
                            },
                            secondary: const Icon(Icons.view_week),
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  void putShared(String key, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  void putSharedS(String key, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  Future getShared(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool(key);
    return val;
  }

  Future getSharedS(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String val = prefs.getString(key);
    return val;
  }

  Future getSharedInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int val = prefs.getInt(key);
    return val;
  }

}
