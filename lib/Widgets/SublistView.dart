import 'package:app/Handler/app_localizations.dart';
import 'package:app/UI/PackageMaterial.dart';
import 'package:app/UI/ProductPackaging.dart';
import 'package:app/UI/CategorieViewPage.dart';
import 'package:app/UI/ManufacViewPage.dart';
import 'package:app/UI/SubCatViewPage.dart';
import 'package:app/UI/UnitPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SublistViewPage extends StatefulWidget {
  @override
  _SublistViewPageState createState() => _SublistViewPageState();
}

class _SublistViewPageState extends State<SublistViewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.only(left:13.0),
              child: Text(AppLocalizations.of(context).translate('sublist').toString(),
                style: GoogleFonts.exo2(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    fontSize: 30
                  ),
                ),
              ),
            ),

            SizedBox(height: 2,),

            Container(
              margin: EdgeInsets.only(left: 6,right: 6,top: 1),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                    },
                    title: Text(AppLocalizations.of(context).translate('manufac').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),),

                    trailing: IconButton(
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/details');
                        Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                        //TODO:: eikhane
                      },
                      icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2,),
            Container(
              margin: EdgeInsets.only(left: 6,right: 6,top: 1),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategorieViewPage()));
                    },
                    title: Text(AppLocalizations.of(context).translate('category').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),),

                    trailing: IconButton(
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/details');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategorieViewPage()));
                        //TODO:: eikhane
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2,),

            Container(
              margin: EdgeInsets.only(left: 6,right: 6,top: 1),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubCatPageView()));
                    },
                    title: Text(AppLocalizations.of(context).translate('sub_category').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),),

                    trailing: IconButton(
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/details');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubCatPageView()));
                        //TODO:: eikhane
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2,),

            Container(
              margin: EdgeInsets.only(left: 6,right: 6,top: 1),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UnitPageView()));
                    },
                    title: Text(AppLocalizations.of(context).translate('unit').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),),

                    trailing: IconButton(
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/details');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UnitPageView()));
                        //TODO:: eikhane
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 2,),

            Container(
              margin: EdgeInsets.only(left: 6,right: 6,top: 1),
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: ListTile(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PackageMaterialPage()));
                    },
                    title: Text(AppLocalizations.of(context).translate('package_material').toString(),
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),),

                    trailing: IconButton(
                      onPressed: () {
                        //Navigator.of(context).pushNamed('/details');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PackageMaterialPage()));
                        //TODO:: eikhane
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
