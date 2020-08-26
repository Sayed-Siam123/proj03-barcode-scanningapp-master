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
import 'package:flutter_stetho/flutter_stetho.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'dart:async';

//import 'package:barcode_scan/barcode_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sweetalert/sweetalert.dart';

//importing master data
import 'Handler/app_localizations.dart';
import 'Resources/SharedPrefer.dart';
import 'Widgets/MasterdataView.dart';
import 'UI/Login.dart';
import 'UI/ProductDetails.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter_icons/flutter_icons.dart';

Future<void> main() async {
  Stetho.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  await GlobalConfiguration().loadFromAsset("config");
  print("base_url: ${GlobalConfiguration().getString('base_url')}");
  //'${GlobalConfiguration().getString('api_base_url')}login';
  runApp(MyApp(
    appLanguage: appLanguage,
  ));
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
//    log(context.locale.toString(),
//        name: '${this} # locale Context');
//    log('title'.tr().toString(), name: '${this} # locale');
//    return new MaterialApp(
//      debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//        backgroundColor: _background,
//        accentColor: _font,
//        buttonColor: _floatbuttoncolor,
//        fontFamily: 'Exo2',
//      ),
//      routes: <String, WidgetBuilder>{
//        '/home': (BuildContext context) => new HomePage(), //for routing pages
//        '/master': (BuildContext context) => new MasterData(),
//        '/login': (BuildContext context) => new LoginPage(),
//        '/settings': (BuildContext context) => new SettingsPage(),
//        '/details': (BuildContext context) => new DetailsPage(),
//        '/product_details': (BuildContext context) => new ProductDetailsPage(),
//      },
//      home: Splash(),
//    );




  return ChangeNotifierProvider<AppLanguage>(

    //TODO:: GERMANY de-DE
    // ignore: deprecated_member_use
    builder: (_) => widget.appLanguage,
    child: Consumer<AppLanguage>(builder: (context, model, child) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
        locale: model.appLocal,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('de', 'DE'),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
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
    );
    },),
  );

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
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
      } else if (resnow == ConnectivityResult.mobile ||
          resnow == ConnectivityResult.wifi) {
        print("Has Connection");
      }
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Theme.of(context).backgroundColor,
      seconds: 6,
      navigateAfterSeconds: loginStatus == "false" || loginStatus == "null"
          ? LoginPage()
          : HomePage(),
      //title: new Text('IDENTIT',textScaleFactor: 2,),
      image: new Image.asset('assets/images/logo.jpeg'),
      loadingText: Text("Loading"),
      photoSize: 150.0,
      loaderColor: Colors.black54,
    );
  }
}
