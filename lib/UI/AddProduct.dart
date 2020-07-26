import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/Widgets/AddProductCategoryDropDown.dart';
import 'package:app/Widgets/AddProductManufacturerDropDown.dart';
import 'package:app/Widgets/AddProductSubCategoryDropDown.dart';
import 'package:app/Widgets/AddProductUnitDropDown.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String barcode1 = "";
  String barcode2 = "";

  TextEditingController ProductName = TextEditingController();
  TextEditingController ProductDesc = TextEditingController();
  TextEditingController manu_pn = TextEditingController();
  TextEditingController gtin = TextEditingController();
  TextEditingController ListPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    masterdata_bloc.fetchMaxIDData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: GoogleFonts.exo2(
            textStyle: TextStyle(),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 00.00,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MasterData())),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.save,
              color: Colors.black54,
            ),
            onPressed: () {
//              Navigator.push(
//                  context, MaterialPageRoute(builder: (context) => MasterData())),

              sublist_bloc.getProductName(ProductName.text);
              sublist_bloc.getProductDesc(ProductDesc.text);
              sublist_bloc.getManufacturerPn(manu_pn.text);
              sublist_bloc.getGtin(gtin.text);
              sublist_bloc.getListPrice(ListPrice.text);
              sublist_bloc.createProductMasterData();
              sublist_bloc.dispose();
              masterdata_bloc.fetchAllMasterData();

              Fluttertoast.showToast(
                  msg: "Product Added!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MasterData()));
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 180,
        width: MediaQuery.of(context).size.width - 14,
        margin: EdgeInsets.only(left: 5, top: 10, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
//          first(),
//          SizedBox(height: 12,),
//          second(),
//          SizedBox(height: 12,),
//          third(),
//          SizedBox(height: 12,),
//          fourth(),
//          SizedBox(height: 12,),
//          fifth(),
//          SizedBox(height: 12,),
//          sixth(),
//          SizedBox(height: 8,),
//          Padding(
//            padding:EdgeInsets.symmetric(horizontal: 0.0),
//            child:Container(
//              height:.5,
//              width:MediaQuery.of(context).size.width*1.0,
//              color:Colors.black,),),
//          seventh(),
//          SizedBox(height: 12,),
//          eighth(),
//          SizedBox(height: 12,),
//          nineth(),
//          SizedBox(height: 12,),
//          tenth(),
//          SizedBox(height: 12,),
//          eleventh(),

              Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Product ID",
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 130,
                        ),
                        Container(
//                        height: MediaQuery
//                            .of(context)
//                            .size
//                            .height - 740,
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width - 284,
                          height: 50,
                          width: 120,
                          child: StreamBuilder<sublist_getsuccess_model>(
                            stream: masterdata_bloc.MaxIDData,
                            builder: (context,
                                AsyncSnapshot<sublist_getsuccess_model>
                                    snapshot) {
                              if (snapshot.hasData) {
                                sublist_getsuccess_model data = snapshot.data;
                                print("Cat er Data gula:: ");
                                //return masterdataview(data);

                                return Text(
                                  data.id.toString(),
                                  style: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 30,
                                    ),
                                  ),
                                );
                                //return Text(data[index].categoryName);

                                //TODO:: eikhan theke start hbe

                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }

                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              SizedBox(
                height: 15,
              ),

              FittedBox(
                fit: BoxFit.fill,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(),
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,
                          height: 50,
                          width: 370,
                          child: TextField(
                              controller: ProductName,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  hintText: "Enter Product name",
                                  labelText: "Name")),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(),
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,
                          height: 50,
                          width: 370,
                          child: TextField(
                              controller: ProductDesc,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  hintText: "Enter Product Description",
                                  labelText: "Description")),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Divider(),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
//                        height: MediaQuery
//                            .of(context)
//                            .size
//                            .height - 740,
//                        width: MediaQuery
//                            .of(context)
//                            .size
//                            .width - 240,
                            child: AddProductCategoryDropDown(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 240,
                            child: AddProductSubCategoryDropDown(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 240,
                            child: AddProductUnitDropDown(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 7,
              ),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 200,
                            child: AddProductManufacturerDropDown(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

//              FittedBox(
//                fit: BoxFit.fitWidth,
//                alignment: Alignment.center,
//                child: Container(
//                  child: Padding(
//                    padding: const EdgeInsets.only(left: 30.0, right: 30),
//                    child: Row(
//                      children: <Widget>[
//                        Text(
//                          "Manufacturer PN:",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                        SizedBox(
//                          width: 35,
//                        ),
//                        Container(
////                          height: MediaQuery
////                              .of(context)
////                              .size
////                              .height - 740,
////                          width: MediaQuery
////                              .of(context)
////                              .size
////                              .width - 292,
//                            height: 50,
//                            width: 200,
//                            child: TextField(
//                              controller: manu_pn,
//                              autocorrect: true,
//                              style: TextStyle(fontSize: 17),
//                              decoration: InputDecoration(hintText: ''),
//                            )),
//                        IconButton(
//                          icon: new Image.asset('assets/images/barcode.png',
//                              fit: BoxFit.contain),
//                          tooltip: 'Scan barcode',
//                          onPressed: barcodeScanning1,
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),

              Stack(
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(),
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,
                              height: 50,
                              width: 370,
                              child: TextField(
                                  controller: manu_pn,
                                  autocorrect: true,
                                  style: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  decoration: new InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      hintStyle: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      labelStyle: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      hintText:
                                          "Enter or scan Manufacturer PIN",
                                      labelText: "Manufacturer PIN",
                                  suffixIcon: IconButton(
                                    icon: new Image.asset('assets/images/barcode.png',
                                        fit: BoxFit.contain),
                                    tooltip: 'Scan barcode',
                                    onPressed: barcodeScanning2,
                                  ),)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

//              FittedBox(
//                fit: BoxFit.fitWidth,
//                alignment: Alignment.center,
//                child: Container(
//                  child: Padding(
//                    padding: const EdgeInsets.only(left: 30.0, right: 30),
//                    child: Row(
//                      children: <Widget>[
//                        Text(
//                          "GTIN:",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                        SizedBox(
//                          width: 125,
//                        ),
//                        Container(
////                          height: MediaQuery
////                              .of(context)
////                              .size
////                              .height - 740,
////                          width: MediaQuery
////                              .of(context)
////                              .size
////                              .width - 290,
//                            height: 50,
//                            width: 200,
//                            child: TextField(
//                              controller: gtin,
//                              autocorrect: true,
//                              style: TextStyle(fontSize: 17),
//                              decoration: InputDecoration(hintText: ''),
//                            )),
//                        IconButton(
//                          icon: new Image.asset('assets/images/barcode.png',
//                              fit: BoxFit.contain),
//                          tooltip: 'Scan barcode',
//                          onPressed: barcodeScanning2,
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),

              Stack(
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(),
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,
                              height: 50,
                              width: 370,
                              child: TextField(
                                  controller: gtin,
                                  autocorrect: true,
                                  style: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  decoration: new InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      hintStyle: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      labelStyle: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      hintText: "Enter or scan GTIN",
                                      labelText: "GTIN",
                                  suffixIcon: IconButton(
                                    icon: new Image.asset('assets/images/barcode.png',
                                        fit: BoxFit.contain),
                                    tooltip: 'Scan barcode',
                                    onPressed: barcodeScanning2,
                                  ),)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

//              FittedBox(
//                fit: BoxFit.fitWidth,
//                alignment: Alignment.center,
//                child: Container(
//                  child: Padding(
//                    padding: const EdgeInsets.only(left: 30.0,right: 50),
//                    child: Row(
//                      children: <Widget>[
//                        Text(
//                          "ListPrice:",
//                          style: TextStyle(fontSize: 20),
//                        ),
//                        SizedBox(
//                          width: 100,
//                        ),
//                        Container(
////                          height: MediaQuery
////                              .of(context)
////                              .size
////                              .height - 740,
////                          width: MediaQuery
////                              .of(context)
////                              .size
////                              .width - 250,
//                            height: 50,
//                            width: 240,
//                            child: TextField(
//                              controller: ListPrice,
//                              autocorrect: true,
//                              style: TextStyle(fontSize: 17),
//                              decoration: InputDecoration(hintText: ''),
//                            )),
//                      ],
//                    ),
//                  ),
//                ),
//              ),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(),
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,
                          height: 50,
                          width: 370,
                          child: TextField(
                              controller: ListPrice,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  labelStyle: GoogleFonts.exo2(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  hintText: "Enter Price",
                                  labelText: "Price")),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              Divider(),

//              Padding(
//                padding: const EdgeInsets.only(left: 30.0, right: 30),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(
//                      "Image:",
//                      style: TextStyle(fontSize: 20),
//                    ),
//                    SizedBox(
//                      width: 60,
//                    ),
//
//                    new Image.asset('assets/images/pickup.png',
//                          fit: BoxFit.fill),
//                  ],
//                ),
//              ),

//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(left: 25),
//                    width: 150,
//                    height: 180,
//                    color: Colors.transparent,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text("Product Name:"),
//                        Text("Product Description:"),
//                        Text("Product ID:"),
//                        Text("Categorie:"),
//                        Text("Sub Categorie:"),
//                        Text("Unit:"),
//                      ],
//                    ),
//                  ),
//                  Container(
//                    margin: EdgeInsets.only(right: 10, top: 5),
//                    width: 150,
//                    height: 240,
//                    color: Colors.transparent,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Container(
//                            height: 20,
//                            width: 150,
//                            child: TextField(
//                              autocorrect: true,
//                              style: TextStyle(fontSize: 14),
//                              decoration: InputDecoration(hintText: ''),
//                            )),
//                        Container(
//                            height: 20,
//                            width: 150,
//                            child: TextField(
//                              style: TextStyle(fontSize: 14),
//                              autocorrect: true,
//                              decoration: InputDecoration(hintText: ''),
//                            )),
//
//                        Text("P2001"),
//
////                        Container(
////                            height: 20,
////                            width: 150,
////                            child: TextField(
////                              style: TextStyle(fontSize: 14),
////                              autocorrect: true,
////                              decoration: InputDecoration(hintText: ''),
////                            )),
//
//
//                        CategoryDropDown(),
//
////                        Container(
////                            height: 20,
////                            width: 150,
////                            child: TextField(
////                              style: TextStyle(fontSize: 14),
////                              autocorrect: true,
////                              decoration: InputDecoration(hintText: ''),
////                            )),
//
//                        SubCategoryDropDown(),
//
//
//
//                        UnitDropDown(),
//
//
////                        Container(
////                            height: 20,
////                            width: 150,
////                            child: TextField(
////                              style: TextStyle(fontSize: 14),
////                              autocorrect: true,
////                              decoration: InputDecoration(hintText: ''),
////                            )),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//              SizedBox(
//                height: 20,
//              ),
//
//              SizedBox(
//                height: 20,
//              ),
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Container(
//                    margin: EdgeInsets.only(left: 25),
//                    width: 150,
//                    height: 150,
//                    color: Colors.transparent,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text("Manufacturer:"),
//                        Text("Manufacturer PN:"),
//                        Text("GTIN:"),
//                        Text("Listprice:"),
//                      ],
//                    ),
//                  ),
//                  Container(
//                    margin: EdgeInsets.only(right: 10, top: 5),
//                    width: 150,
//                    height: 150,
//                    color: Colors.transparent,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Container(
//                            height: 20,
//                            width: 150,
//                            child: TextField(
//                              style: TextStyle(fontSize: 14),
//                              autocorrect: true,
//                              decoration: InputDecoration(hintText: ''),
//                            )),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          mainAxisSize: MainAxisSize.max,
//                          children: <Widget>[
//                            IconButton(
//                              icon: new Image.asset('assets/images/barcode.png',
//                                  fit: BoxFit.contain),
//                              tooltip: 'Scan barcode',
//                              onPressed: barcodeScanning,
//                            ),
//                            Container(
//                                height: 20,
//                                width: 100,
//                                child: TextField(
//                                  style: TextStyle(fontSize: 14),
//                                  autocorrect: true,
//                                  decoration: InputDecoration(hintText: ""),
//                                )),
//                          ],
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          mainAxisSize: MainAxisSize.max,
//                          children: <Widget>[
//                            IconButton(
//                              icon: new Image.asset('assets/images/barcode.png',
//                                  fit: BoxFit.contain),
//                              tooltip: 'Scan barcode',
//                              onPressed: barcodeScanning,
//                            ),
//                            Container(
//                                height: 20,
//                                width: 100,
//                                child: TextField(
//                                  style: TextStyle(fontSize: 14),
//                                  autocorrect: true,
//                                  decoration: InputDecoration(hintText: ""),
//                                )),
//                          ],
//                        ),
//                        Container(
//                            height: 20,
//                            width: 150,
//                            child: TextField(
//                              style: TextStyle(fontSize: 14),
//                              autocorrect: true,
//                              decoration: InputDecoration(hintText: ''),
//                            )
//                        ),
//                      ],
//                    ),
//                  )
//                ],
//              ),
            ],
          ),
        ),
      ),
    );
  }

  Future barcodeScanning1() async {
    try {
      barcode1 = (await BarcodeScanner.scan());
      print(barcode1);
      setState(() {
        this.barcode1 = barcode1;
        manu_pn.text = barcode1;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode1 = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode1 = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode1 = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode1 = 'Unknown error: $e');
    }
  }

  Future barcodeScanning2() async {
    try {
      barcode2 = (await BarcodeScanner.scan());
      print(barcode2);
      setState(() {
        this.barcode2 = barcode2;
        gtin.text = barcode2;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode2 = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode2 = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode2 = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode2 = 'Unknown error: $e');
    }
  }
}
