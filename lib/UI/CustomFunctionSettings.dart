import 'package:app/Widgets/CustomFunctionSetWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'Home.dart';

class CustomFunctionSettingsPage extends StatefulWidget {
  @override
  _CustomFunctionSettingsPageState createState() => _CustomFunctionSettingsPageState();
}

class _CustomFunctionSettingsPageState extends State<CustomFunctionSettingsPage> {

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    return Scaffold(
      body: OrientationLayoutBuilder(
        portrait: (context) => CustomFunctionSetWidget(height: hp(80), width: wp(100)),
        landscape: (context) => CustomFunctionSetWidget(height: hp(150),width: wp(100),),
      ),
    );
  }
}
