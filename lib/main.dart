//import 'dart:html';

import 'dart:io';

import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Model/RouteArgument.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/UI/Details.dart';
import 'package:app/UI/Settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
//import 'package:barcode_scan/barcode_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
//importing master data
import 'Resources/SharedPrefer.dart';
import 'Widgets/MasterdataView.dart';
import 'UI/Login.dart';
import 'UI/ProductDetails.dart';
import 'package:global_configuration/global_configuration.dart';



Future<void> main() async {
  Stetho.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");
  print("base_url: ${GlobalConfiguration().getString('base_url')}");
  //'${GlobalConfiguration().getString('api_base_url')}login';
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _background = new HexColor("#F2F2F3");

  Color _font = new HexColor("#4F4F4F");

  Color _floatbuttoncolor = new HexColor("#828282");

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,


      theme: ThemeData(
        backgroundColor: _background,
        accentColor: _font,
        buttonColor: _floatbuttoncolor,
        fontFamily: 'Exo2',
      ),


      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePage(),       //for routing pages
        '/master': (BuildContext context) => new MasterData(),
        '/login': (BuildContext context) => new LoginPage(),
        '/settings': (BuildContext context) => new SettingsPage(),
        '/details': (BuildContext context) => new DetailsPage(),
        '/product_details': (BuildContext context) => new ProductDetailsPage(),
      },

      home: Splash(),
    );
  }

}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  SessionManager prefs = SessionManager();

  String loginKey="loginKey";

  String loginStatus = '';

  void getLogin() async {

    Future<String> serverip = prefs.getData(loginKey);
    serverip.then((data) async{
      print('login status pabo');
      print("login status " + data.toString());

      setState(() {
        loginStatus = data.toString();
      });
      print(loginStatus.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    },onError: (e) {
      print(e);
    });

  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      seconds: 6,
      navigateAfterSeconds: loginStatus == "false" ? LoginPage() : HomePage(),
      //title: new Text('IDENTIT',textScaleFactor: 2,),
      image: new Image.asset('assets/images/logo.jpeg'),
      loadingText: Text("Loading"),
      photoSize: 150.0,
      loaderColor: Colors.black54,
    );
  }
}

































/*void main() => runApp(
    MaterialApp(
      home: MyApp(),
    )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title:  new Text('L O G I N',style: TextStyle(fontSize: 16, color: Colors.black54)),
              leading: new IconButton(
                  icon: new Icon(Icons.settings, color: Colors.black54,) ,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },

              ),
              backgroundColor: Colors.white,
              actions: [
                new IconButton(icon: new Icon(Icons.language,color: Colors.black54,),  onPressed: null),
                new IconButton(
                  icon: new Icon(Icons.exit_to_app,color: Colors.black54,),
                  onPressed:() {
                    exit(0);

                    //Navigator.popUntil(context, ModalRoute.withName('/'));
                    Navigator.pop(context,true);// It worked for me instead of above line
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()),);
                  }


                ),

              ],
              centerTitle: true,
              elevation: 0.0,
            ),

            body: Center(

                child: LoginUser()
            )
        )
    );
  }
}
// Logins --------------------------------------------------
class LoginUser extends StatefulWidget {

  LoginUserState createState() => LoginUserState();

}

class LoginUserState extends State {

  // For CircularProgressIndicator.
  bool visible = false ;
  String fontname_lato= "Lato";
  String fontname_popins= "Popins";

  // Getting value from TextField widget.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userLogin() async{

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home())
    );

    // Showing CircularProgressIndicator.
    setState(() {
      visible = true ;
    });

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    //var url = 'https://flutter-examples.000webhostapp.com/login_user.php';
    var url = 'http://localhost:8080/flutterlogin/login_user.php';

    // Store all data with Param Name.
    var data = {'email': email, 'password' : password};

    // Starting Web API Call.

    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if(message == 'Login Matched')
    {

      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home())
      );
    }else{

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.

      //Bypass login  -----------development purpose only
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home())
      );

      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[

                  Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text('Sign in',

                        style: GoogleFonts.lato(
                          textStyle: TextStyle(color: Colors.black54, letterSpacing: .5, fontSize: 30, fontWeight: FontWeight.bold),
                        ),



                      )
                  ),

                Container(
                  width: 400.00,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10.00),
                  child: new Text("Please fill out the below fields to login"),

                ),

                  Divider(),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: emailController,
                        autocorrect: true,
                        decoration: InputDecoration(hintText: 'Enter Your Email Here'),
                      )
                  ),

                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: TextField(
                        controller: passwordController,
                        autocorrect: true,
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Enter Your Password Here'),
                      )
                  ),
                  FlatButton(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black)
                    ),
                    color: Colors.white,
                    textColor: Colors.black54,
                    padding: EdgeInsets.all(8.0),
                    onPressed: userLogin,
                    child: Text(
                      "Login".toUpperCase(),
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),





                  Visibility(
                      visible: visible,
                      child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: CircularProgressIndicator()
                      )
                  ),

                ],
              ),
            )));
  }
}

// Homepage
class Home extends StatefulWidget{
  _Homepage createState ()=> _Homepage();
}
class _Homepage extends State<Home>{

  List<int> _listitems = new List();
  @override
  void initState() {
    // TODO: implement initState
    for(int i=0;i<3;i++){
      _listitems.add(i);
      print(i);
    }
    print(_listitems);
    super.initState();
  }
  //Drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
   return Scaffold (
       key: _scaffoldKey,
       drawer: new Drawer(
         child: ListView(
           // Important: Remove any padding from the ListView.
           padding: EdgeInsets.zero,
           children: <Widget>[
             DrawerHeader(
               child: Text('App name'),
               decoration: BoxDecoration(
                 color: Colors.amberAccent,
               ),
             ),
             ListTile(
               title: Text('System setting'),
               trailing:  new Icon(Icons.arrow_forward),
               onTap: () {
                 // Update the state of the app.
                 // ...
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Settings()),
                 );
               },
             ),
             ListTile(
               title: Text('Master data'),
               trailing:  new Icon(Icons.arrow_forward),
               onTap: () {
                 // Update the state of the app.
                 // ...
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Masterdata()),
                 );
               },
             ),
             Divider(),
             Text("Version 1.0.1"),
           ],
         ),

       ),
          appBar: AppBar(
            title: Text("Home", style: new TextStyle(color: Colors.black54),),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 5.0,
            bottomOpacity: 10.00,
            leading: new IconButton(
              icon: new Icon(Icons.menu, color: Colors.black54,) ,
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
          ),
       body: Container (
         padding: EdgeInsets.all(10.00),
         child: new ListView (
           children: <Widget>[
              new  Card (
               child: ListTile(

                 title: new Text('Barcode information'),
                 isThreeLine: false,
                 subtitle: new Text('Barcode data display'),
                 trailing: new Icon(Icons.arrow_forward),
                   leading: ConstrainedBox(
                     constraints: BoxConstraints(
                       minWidth: 45,
                       minHeight: 45,
                       maxWidth: 45,
                       maxHeight: 45,
                     ),
                     child: Image.asset('assets/images/barcode.png', fit: BoxFit.cover),
                   ),

               )

             ),
             new  Card (
                 child: ListTile(
                   title: new Text('Deliveries'),
                   isThreeLine: false,
                   subtitle: new Text('Create or modifiy a delivery'),
                   trailing: new Icon(Icons.arrow_forward),
                   leading: ConstrainedBox(
                     constraints: BoxConstraints(
                       minWidth: 45,
                       minHeight: 45,
                       maxWidth: 45,
                       maxHeight: 45,
                     ),
                     child: Image.asset('assets/images/delivery.png', fit: BoxFit.cover),
                   ),
                 )

             ),
             new  Card (
                 child: ListTile(
                   title: new Text('Pick up'),
                   isThreeLine: false,
                   subtitle: new Text('Collect shipment'),
                   trailing: new Icon(Icons.arrow_forward),
                   leading: ConstrainedBox(
                     constraints: BoxConstraints(
                       minWidth: 45,
                       minHeight: 45,
                       maxWidth: 45,
                       maxHeight: 45,
                     ),
                     child: Image.asset('assets/images/pickup.png', fit: BoxFit.cover),
                   ),
                 )

             ),

           ],

         ),






    )

   );
  }

}


// Master data page ----------------------------
class Masterdata extends StatefulWidget {
  _Masterdatapage createState ()=> _Masterdatapage();
}
class _Masterdatapage extends State<Masterdata>{

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  //Barcode scan implement
  String barcode = "";

  @override
  initState() {
    super.initState();
  }



  //Main widget
  @override
  Widget build(BuildContext context) {
    return  Scaffold (
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : new IconButton(icon: new Icon(Icons.arrow_back, color: Colors.black45,), color: Colors.black54,
            onPressed: (){
              Navigator.pop(context);

            }
        ),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
        backgroundColor: Colors.white,
        elevation: 1.0,
        centerTitle: true,

      ),
      body: MasterdataView(),

    );
  }
  //Search widget
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black38),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery,
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.black45,),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search, color: Colors.black45,),
        onPressed: _startSearch,
      ),
      IconButton (
          icon: new Image.asset('assets/images/barcode.png',fit: BoxFit.contain),
          tooltip: 'Scan barcode',
          onPressed: barcodeScanning,
      ),
    ];

  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  _buildTitle(BuildContext context) {
    return Text ("Master data" , style: new TextStyle(color: Colors.black54),);

  }


  //scan barcode asynchronously
  Future barcodeScanning() async {
    try {
      barcode = (await BarcodeScanner.scan()) as String;
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }




}


// settings page ----------------------------------------//

class Settings extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _Settingpage();
}

class _Settingpage extends State<Settings> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _camera      = false;
  bool _code39      = false;
  bool _code128     = false;
  bool _ean13       = false;
  bool _datamatrix  = false;
  bool _qrcode      = false;
  var currentSelectedValue;
  final langtype = ["English", "German", "Chinese"];

  String deviceId, serverip, serverlog , serverport ="";
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  @override
  initState() {
    _camera       = Global.shared.isInstructionView;
    _code39       = Global.shared.isCode39;
    _code128      = Global.shared.isCode128;
    _ean13        = Global.shared.isEan13;
    _datamatrix   = Global.shared.isDatamatrix;
    _qrcode       = Global.shared.isQrcode;

    deviceId     = Global.shared.isDeviceId;
    serverip      = Global.shared.isServerIp;
    serverlog     = Global.shared.isServerLog;
    serverport    = Global.shared.isServerPort;


    super.initState();
  }


//Language widget
  Widget languageDropDown() {
    return Container(
      height: 60.00,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text("Select Language"),
                value: currentSelectedValue,
                isDense: true,
                onChanged: (newValue) {
                  setState(() {
                    currentSelectedValue = newValue;
                  });
                  print(currentSelectedValue);
                },
                items: langtype.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: new TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,

        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black54,) ,
          onPressed: () {
            Navigator.pop(context);
          },

        ),

      ),
      body:
      Container(

        child: LayoutBuilder (
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
               child: Column(
                  children: [
                    //  Flexible(
                    Container(
                      width: 500.00,
                      padding: EdgeInsets.all(10.0),
                      child: Text("Change your settings", style: TextStyle(color: Colors.black54, fontSize: 16),),

                    ),
                    Container (
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,


                              children: <Widget>[
                                const ExpansionTile(
                                  backgroundColor: Colors.black,


                                  leading: Icon(Icons.link),
                                  title: Text('Connection settings'),
                                  trailing: IconButton(icon: Icon(Icons.arrow_drop_down_circle), onPressed:null),
                                  children: <Widget>[
                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 40.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(Icons.perm_device_information),
                                      placeholder: "Device ID",



                                    ),


                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 40.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(Icons.confirmation_number),
                                      placeholder: "Server -IP/Name",

                                    ),
                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 40.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(Icons.label_important),
                                      placeholder: "Server port",

                                    ),
                                    BeautyTextfield(
                                      width: double.maxFinite,
                                      height: 40.00,
                                      duration: Duration(milliseconds: 300),
                                      inputType: TextInputType.text,
                                      prefixIcon: Icon(Icons.launch),
                                      placeholder: "Server log",

                                    ),


                                  ],

                                ),
                              ]

                          ),
                        )

                    ),
                    Divider(),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ExpansionTile(

                                  leading: Icon(Icons.settings_system_daydream),
                                  title: Text('System settings'),
                                  trailing: IconButton(icon: Icon(Icons.arrow_drop_down_circle), onPressed:null),
                                  children: <Widget>[


                                    languageDropDown(),
                                    Divider(),
                                    SwitchListTile(
                                      title: const Text('Camera',  style: TextStyle(color:Colors.black, fontSize: 12.00, fontWeight: FontWeight.w600),),
                                      value: _camera,
                                      onChanged: (bool value) {
                                        print("Current value"+""+value.toString());
                                        setState(() {
                                          Global.shared.isInstructionView = value;
                                          _camera = value;
                                          value = !value;
                                            print( "new value"+_camera.toString());
                                            }
                                        );
                                      },
                                      secondary: const Icon(Icons.camera_alt),
                                    ),

                                    SwitchListTile(
                                      title: const Text('Code 39', style: TextStyle(color:Colors.black, fontSize: 12.00, fontWeight: FontWeight.w600),),
                                      value: _code39,
                                      onChanged: (bool value) {
                                        print("Current value"+""+value.toString());
                                        setState(()
                                        {
                                          Global.shared.isCode39 = value;
                                          _code39 = value;
                                          value = !value;
                                              print( "new value"+_code39.toString());


                                            }
                                        );
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text('Code 128',style: TextStyle(color:Colors.black, fontSize: 12.00, fontWeight: FontWeight.w600),),
                                      value: _code128,
                                      onChanged: (bool value) {
                                        print("Current value"+""+value.toString());
                                        setState(
                                                () {
                                                  Global.shared.isCode128 = value;
                                                  _code128 = value;
                                                  value = !value;
                                                    print( "new value"+_code128.toString());
                                            }
                                        );
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text('EAN 13',style: TextStyle(color:Colors.black, fontSize: 12.00, fontWeight: FontWeight.w600),),
                                      value: _ean13,
                                      onChanged: (bool value) {
                                        setState(
                                                () {
                                                  Global.shared.isEan13 = value;
                                                  _ean13 = value;
                                            }
                                        );
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text('Datamatrix',style: TextStyle(color:Colors.black, fontSize: 12.00, fontWeight: FontWeight.w600),),
                                      value: _datamatrix,
                                      onChanged: (bool value) {
                                        setState(
                                                () {
                                                  Global.shared.isDatamatrix = value;
                                                  _datamatrix = value;
                                            }
                                        );
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    SwitchListTile(
                                      title: const Text('QR code',style: TextStyle(color:Colors.black, fontSize: 12.00, fontWeight: FontWeight.w600),),
                                      value: _qrcode,
                                      onChanged: (bool value) {
                                        setState(
                                                () {
                                                  Global.shared.isQrcode = value;
                                              _qrcode = value;
                                            }
                                        );
                                      },
                                      secondary: const Icon(Icons.view_week),
                                    ),
                                    Divider(),


                                  ],

                                ),
                              ]

                          ),
                        )

                    )

                  ],

                )

            );
          }

        )


      ),

    );
  }


}
class Global{
  static final shared =Global();
  bool isInstructionView = false;
  bool isCode39 = false;
  bool isCode128 = false;
  bool isEan13 = false;
  bool isDatamatrix = false;
  bool isQrcode = false;
  //Connection setting -----------------------------
  String isDeviceId ="";
  String isServerIp = "";
  String isServerPort = "";
  String isServerLog = "";


}*/

