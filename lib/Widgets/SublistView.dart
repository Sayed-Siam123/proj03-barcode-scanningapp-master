import 'package:app/UI/PackageMaterial.dart';
import 'package:app/UI/ProductPackaging.dart';
import 'package:app/UI/CategorieViewPage.dart';
import 'package:app/UI/ManufacViewPage.dart';
import 'package:app/UI/SubCatViewPage.dart';
import 'package:app/UI/UnitPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              child: Text("Sublist",
                  style: TextStyle(
                      fontSize: 25
                  ),
              ),
            ),

            SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      //spreadRadius: 3.0,
                      color: Colors.grey.shade400),
                ],
              ),
              child: ListTile(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ManufacViewPage()));
                },
                title: Text("Manufacturer",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),

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

            SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      //spreadRadius: 3.0,
                      color: Colors.grey.shade400),
                ],
              ),
              child: ListTile(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategorieViewPage()));
                },
                title: Text("Category",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),

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

            SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      //spreadRadius: 3.0,
                      color: Colors.grey.shade400),
                ],
              ),
              child: ListTile(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubCatPageView()));
                },
                title: Text("Sub Category",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),

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

            SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      //spreadRadius: 3.0,
                      color: Colors.grey.shade400),
                ],
              ),
              child: ListTile(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UnitPageView()));
                },
                title: Text("Unit",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),

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

            SizedBox(height: 10,),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2.0,
                      //spreadRadius: 3.0,
                      color: Colors.grey.shade400),
                ],
              ),
              child: ListTile(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PackageMaterialPage()));
                },
                title: Text("Packaging Material",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),

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


          ],
        ),
      ),
    );
  }
}
