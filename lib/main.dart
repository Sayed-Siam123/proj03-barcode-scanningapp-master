//import 'dart:html';

import 'dart:developer';
import 'dart:io';

import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/AppLanguage.dart';
import 'package:app/Model/RouteArgument.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/UI/Details.dart';
import 'package:app/UI/Settings.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'dart:async';

//import 'package:barcode_scan/barcode_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sweetalert/sweetalert.dart';

import 'dart:io' as Io;
//importing master data
import 'Handler/app_localizations.dart';
import 'Resources/SharedPrefer.dart';
import 'Widgets/MasterdataView.dart';
import 'UI/Login.dart';
import 'UI/ProductDetails.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_translate/flutter_translate.dart';

Future<void> main() async {
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US', supportedLocales: ['en_US', 'de']);
  WidgetsFlutterBinding.ensureInitialized();
  // AppLanguage appLanguage = AppLanguage();
  // await appLanguage.fetchLocale();
  await GlobalConfiguration().loadFromAsset("config");
  print("base_url: ${GlobalConfiguration().getString('base_url')}");
  //'${GlobalConfiguration().getString('api_base_url')}login';
  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatefulWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _background = new HexColor("#F2F2F3");

  Color _font = new HexColor("#4F4F4F");

  Color _floatbuttoncolor = new HexColor("#828282");

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          backgroundColor: _background,
          accentColor: _font,
          buttonColor: _floatbuttoncolor,
          fontFamily: 'Exo2',
        ),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => new HomePage(), //for routing pages
          '/master': (BuildContext context) => new MasterData(),
          '/login': (BuildContext context) => new LoginPage(),
          '/settings': (BuildContext context) => new SettingsPage(),
          '/details': (BuildContext context) => new DetailsPage(),
          '/product_details': (BuildContext context) => new ProductDetailsPage(),
        },
        home: Splash(),
      ),
    );

  // return ChangeNotifierProvider<AppLanguage>(
  //
  //   //TODO:: GERMANY de-DE
  //   // ignore: deprecated_member_use
  //   builder: (_) => widget.appLanguage,
  //   // ignore: missing_return
  //   child: Consumer<AppLanguage>(builder: (context, model, child) {
  //     return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //       locale: model.appLocal,
  //       supportedLocales: [
  //         Locale('en', 'US'),
  //         Locale('de', 'DE'),
  //       ],
  //       localizationsDelegates: [
  //         AppLocalizations.delegate,
  //         GlobalMaterialLocalizations.delegate,
  //         GlobalWidgetsLocalizations.delegate,
  //       ],
  //     theme: ThemeData(
  //       backgroundColor: _background,
  //       accentColor: _font,
  //       buttonColor: _floatbuttoncolor,
  //       fontFamily: 'Exo2',
  //     ),
  //     routes: <String, WidgetBuilder>{
  //       '/home': (BuildContext context) => new HomePage(), //for routing pages
  //       '/master': (BuildContext context) => new MasterData(),
  //       '/login': (BuildContext context) => new LoginPage(),
  //       '/settings': (BuildContext context) => new SettingsPage(),
  //       '/details': (BuildContext context) => new DetailsPage(),
  //       '/product_details': (BuildContext context) => new ProductDetailsPage(),
  //     },
  //     home: Splash(),
  //   );
  //   },),
  // );

  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final TextEditingController _inputcontrol1 = TextEditingController();
  final TextEditingController _inputcontrol2 = TextEditingController();

  //Toaster toast;

  StreamSubscription streamerforIChecker;
  ConnectivityResult result;


  final _resetKey1 = GlobalKey<FormState>();
  final _resetKey2 = GlobalKey<FormState>();
  bool _resetValidate1 = false;
  bool _resetValidate2 = false;

  bool _validate1;
  bool _validate2;

  String errortext1 = "Value Can\'t Be Empty";
  String errortext2 = "Value Can\'t Be Empty";

  ScaffoldState scaffold;

  SessionManager prefs = SessionManager();

  String loginKey = "loginKey";
  String userid = "";

  String loginStatus = '';

  void getLogin() async {
    Future<String> serverip = prefs.getData(loginKey);
    serverip.then((data) async {
      print('login status pabo');
      print("login status " + data.toString());

      setState(() {
        loginStatus = data.toString();
      });
      print(loginStatus.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  void getLoginUserid() async {
    Future<String> _userid = prefs.getData("userid");
    _userid.then((data) async {
      print('userid status pabo');
      print("userid status " + data.toString());

      setState(() {
        userid = data.toString();
      });
      print(userid.toString());

//      Future.delayed(const Duration(milliseconds: 1000), () {
//
//      });
    }, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      getLogin();
      getLoginUserid();
      _createFolder();
    });

    //print(LocaleKeys.msg_named.tr());

    //print("Title should be :: "+ 'title'.tr());
//    context.locale = Locale('en', 'US');
//
//    print(context.locale.toString());

    streamerforIChecker = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult resnow) {
      if (resnow == ConnectivityResult.none) {
        print("No Connection");
        _showDialog();
        //Get.snackbar("Hi", "I'm modern snackbar"); //TODO::EASY SNACKBAR EXAMPLE
      } else if (resnow == ConnectivityResult.mobile ||
          resnow == ConnectivityResult.wifi) {
        print("Has Connection");
      }
    });


  }


    void createDir() async {
    //Directory base = await getExternalStorageDirectory(); //only for Android
     //Directory base = await getApplicationSupportDirectory(); //works for both iOS and Android

    //Directory base = await getApplicationDocumentsDirectory();
    // var path = await ExtStorage.getExternalStorageDirectory();
    // String dirToBeCreated = "identit";
    // String base = "storage/emulated/0";
    // String finalDir = path+"/"+dirToBeCreated;
    // print(path);

    // var dir = Directory(finalDir);
    // bool dirExists = await dir.exists();
    // if(!dirExists){
    //   // final Permission _permissionHandler = Permission();
    //   // var result = await _permissionHandler.request();
    //   // if (permissionResult == PermissionStatus.authorized){
    //   //   dir.create(/*recursive=true*/); //pass recursive as true if directory is recursive
    //   // }
    //   var _status;
    //   var status = await Permission.storage.status;
    //   if (!status.isGranted) {
    //     await Permission.storage.request().whenComplete(() async{
    //       print("Granted");
    //       Timer(Duration(milliseconds: 50), () {
    //         new Directory('/storage/emulated/0/identit').create()
    //         // The created directory is returned as a Future.
    //             .then((Directory directory) {
    //           print(directory.path);
    //         });
    //       });
    //       print("Created");
    //     });
    //   }
    //   else{
    //     print("Permitted");
    //     print(status.toString());
    //     new Directory('/storage/emulated/0/identit').create()
    //     // The created directory is returned as a Future.
    //         .then((Directory directory) {
    //       print(directory.path);
    //     });
    //   }
    // }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissions.
  }

  // _createFolder()async{
  //   final folderName="some_name";
  //   final path= Directory("storage/emulated/0/$folderName");
  //   if ((await path.exists())){
  //     // TODO:
  //     print("exist");
  //   }else{
  //     // TODO:
  //     print("not exist");
  //     path.create();
  //   }}


  Future<String> _createFolder() async {
    final folderName = "Indentit";
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create().whenComplete(() {
        new Directory("storage/emulated/0/$folderName/"+"Masterdata").create();
        new Directory("storage/emulated/0/$folderName/"+"Photos").create();
        new Directory("storage/emulated/0/$folderName/"+"Photo documentation").create();

      });
      return path.path;
    }
  }




  _showDialog() async {
    await Future.delayed(Duration(seconds: 2));

    SweetAlert.show(
      context,
      title: "Info!",
      subtitle: "No internet! OFFLINE MODE loading....",
      //TODO:: SWEET ALERT EXAMPLE
      style: SweetAlertStyle.loading,
     );

    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text(
    //     'No internet! OFFLINE MODE loading..',
    //     style: GoogleFonts.exo2(
    //       textStyle: TextStyle(
    //         fontSize: 16,
    //       ),
    //     ),
    //   ),
    //   duration: Duration(seconds: 3),
    // ));

  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Updating..'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.white,
      seconds: 6,
      navigateAfterSeconds: loginStatus == "false" || loginStatus == "null" || userid == "null" || userid == "-1"
          ? LoginPage()
          : HomePage(),
      //title: new Text('IDENTIT',textScaleFactor: 2,),
      image: new Image.asset('assets/images/logo.png'),
      loadingText: Text("Loading"),
      photoSize: 150.0,
      loaderColor: Colors.black54,
    );
  }
}
