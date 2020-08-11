import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/HandlerModel.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/Details.dart';
import 'package:app/Widgets/EditProductCategoryDropDown.dart';
import 'package:app/Widgets/EditProductManufacturerDropDown.dart';
import 'package:app/Widgets/EditProductSubCategoryDropDown.dart';
import 'package:app/Widgets/EditProductUnitDropDown.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'MasterData.dart';

class ProductEditPage extends StatefulWidget {
  final String productname, description;

  final String id;
  final String bool;

  const ProductEditPage(
      {Key key, this.productname, this.description, this.id, this.bool})
      : super(key: key);

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  String category,
      categoryID,
      sub_category,
      sub_categoryID,
      manufac,
      manufacID,
      unit,
      unitID,
      id;

  String pre_name, pre_productdesc, pre_manu_pin = "", pre_gtin, pre_listprice;

  CategoryModel CategoryPass;

  ScanResult barcode1;
  ScanResult barcode2;

  TextEditingController ProductName = new TextEditingController();
  TextEditingController ProductDesc = new TextEditingController();
  TextEditingController manu_pn = new TextEditingController();
  TextEditingController gtin = new TextEditingController();
  TextEditingController ListPrice = new TextEditingController();

  final Color _hintcolor = new HexColor("#737373");

  HandlerClass handle;

  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.getsinglemasterdata();
    //productName.text = widget.productname;
    print(widget.productname);
    super.initState();
    sublist_bloc.dispose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sublist_bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Product",
          style: GoogleFonts.exo2(
            textStyle: TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
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
              context, MaterialPageRoute(builder: (context) => DetailsPage())),
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.save,
                color: Colors.black54,
              ),
              onPressed: () {
//                Navigator.push(context,
//                    MaterialPageRoute(builder: (context) => DetailsPage())),
                sublist_bloc.getProductID(id.toString());
//                sublist_bloc.getProductName(ProductName.text);
//                sublist_bloc.getProductDesc(ProductDesc.text);
//                sublist_bloc.getManufacturerPn(manu_pn.text);
//                sublist_bloc.getGtin(gtin.text);
//                sublist_bloc.getListPrice(ListPrice.text);
                //sublist_bloc.UpdateProductMasterData();
//
//                sublist_bloc.dispose();
//                masterdata_bloc.fetchAllMasterData();

                if (ProductName.text.isEmpty) {
                  print("previous Name: " + pre_name);
                  sublist_bloc.getProductName(pre_name);
                } else if (ProductName.text.isNotEmpty) {
                  print("New Name: " + ProductName.text);
                  sublist_bloc.getProductName(ProductName.text);
                }

                if (ProductDesc.text.isEmpty) {
                  print("previous Desc: " + pre_productdesc);
                  sublist_bloc.getProductDesc(pre_productdesc);
                } else if (ProductDesc.text.isNotEmpty) {
                  print("New Desc: " + ProductDesc.text);
                  sublist_bloc.getProductDesc(ProductDesc.text);
                }

                if (manu_pn.text.isEmpty) {
                  print("previous ManuPIN: " + "aas");
                  sublist_bloc.getManufacturerPn(pre_manu_pin);
                } else if (manu_pn.text.isNotEmpty) {
                  print("New ManuPin: " + manu_pn.text);
                  sublist_bloc.getManufacturerPn(manu_pn.text);
                }

                if (gtin.text.isEmpty) {
                  print("previous GTIN: " + pre_gtin);
                  sublist_bloc.getGtin(pre_gtin);
                } else if (gtin.text.isNotEmpty) {
                  print("New GTIN: " + gtin.text);
                  sublist_bloc.getGtin(gtin.text);
                }

                if (ListPrice.text.isEmpty) {
                  print("previous PRICE: " + pre_listprice);
                  sublist_bloc.getListPrice(pre_listprice);
                } else if (ListPrice.text.isNotEmpty) {
                  print("New PRICE: " + ListPrice.text);
                  sublist_bloc.getListPrice(ListPrice.text);
                }

                print(categoryID.toString());

                sublist_bloc.getPreviousCategoryID(categoryID);
                sublist_bloc.getPreviousManufacturerID(manufacID);
                sublist_bloc.getPreviousSubCategoryID(sub_categoryID);
                sublist_bloc.getPreviousUnitID(unitID);

//
                print("eikhnane submit");
                sublist_bloc.UpdateProductMasterData();
                sublist_bloc.dispose();
//              sublist_bloc.dispose();

                ProductName.text = "";
                ProductDesc.text = "";
                manu_pn.text = "";
                gtin.text = "";
                ListPrice.text = "";

                Fluttertoast.showToast(
                    msg: "Product Updated!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MasterData()));
              }),
        ],
      ),
      body: Container(

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: StreamBuilder<List<SingleMasterDataModel>>(
                    stream: masterdata_bloc.singleMasterData,
                    builder: (context,
                        AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
                      if (snapshot.hasData) {
                        List<SingleMasterDataModel> data = snapshot.data;
                        print("Data gula:: ");
                        print(data.length);
                        //return masterdataview(data);

//                        TextEditingController _controller = new TextEditingController();
//                        _controller.value = _controller.value.copyWith(text: snapshot.data[0].categoryName);
//
//                        return Stack(
//                          children: <Widget>[
//                            TextField(
//                              decoration: InputDecoration(
//                                hintText: "Product Name"
//                              ),
//                              controller: _controller,
//                            ),
//
//
//                            Container(
//                              child: RaisedButton(
//                                onPressed: (){
//
//                                  print(_controller.value);
//
//                                },
//                              ),
//                              margin: EdgeInsets.only(left: 60),
//                            ),
//                          ],
//                        );

//                        ProductName.value = ProductName.value
//                            .copyWith(text: data[0].productName);
//                        ProductDesc.value = ProductDesc.value
//                            .copyWith(text: data[0].productDescription);
//                        manu_pn.value = manu_pn.value.copyWith(text: "255");
//                        gtin.value = gtin.value.copyWith(text: data[0].gtin);
//                        ListPrice.value =
//                            ListPrice.value.copyWith(text: data[0].listPrice);

                        id = data[0].id;

                        pre_name = data[0].productName;
                        pre_productdesc = data[0].productDescription;
                        pre_manu_pin = data[0].manufacturerPN;
                        pre_gtin = data[0].gtin;
                        pre_listprice = data[0].listPrice;

                        category = data[0].categoryName;
                        categoryID = data[0].categoryNameId;

                        sub_category = data[0].subCategoryName;
                        sub_categoryID = data[0].subCategoryNameId;

                        manufac = data[0].manufacturerName;
                        manufacID = data[0].manufacturerId;

                        unit = data[0].packagingUnit;
                        unitID = data[0].unitId;

                        return Container(
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Product Name",
                                      style: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                          margin: EdgeInsets.only(left: 3),
                                          child: TextField(
                                            controller: ProductName,
                                            autocorrect: true,
                                            autofocus: true,
                                            style: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            decoration: new InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: _hintcolor),
                                                ),
                                                hintStyle: GoogleFonts.exo2(
                                                  textStyle: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                hintText: data[0].productName),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 7,
                              ),
//
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        "Product Description",
                                        style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                        autofocus: true,
                                        style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                        decoration: new InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: _hintcolor),
                                          ),
                                          hintStyle: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              color: _hintcolor,
                                            ),
                                          ),
                                          hintText: data[0].productDescription,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0),
                                      child: Text(
                                        "Manufacture PIN",
                                        style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 2),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
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
                                                    autofocus: true,
                                                    style: GoogleFonts.exo2(
                                                      textStyle: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    decoration:
                                                        new InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: _hintcolor),
                                                      ),
                                                      hintStyle:
                                                          GoogleFonts.exo2(
                                                        textStyle: TextStyle(
                                                          fontSize: 20,
                                                          color: _hintcolor,
                                                        ),
                                                      ),
                                                      hintText: data[0]
                                                          .manufacturerPN,
                                                      suffixIcon: IconButton(
                                                        icon: new Image.asset(
                                                            'assets/images/barcode.png',
                                                            fit:
                                                                BoxFit.contain),
                                                        tooltip: 'Scan barcode',
                                                        onPressed:
                                                            barcodeScanning1,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0),
                                      child: Text(
                                        "GTIN",
                                        style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Stack(
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
                                            autofocus: true,
                                            decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: _hintcolor),
                                              ),
                                              hintStyle: GoogleFonts.exo2(
                                                textStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: _hintcolor,
                                                ),
                                              ),
                                              hintText: data[0].gtin,
                                              suffixIcon: IconButton(
                                                icon: new Image.asset(
                                                    'assets/images/barcode.png',
                                                    fit: BoxFit.contain),
                                                tooltip: 'Scan barcode',
                                                onPressed: barcodeScanning2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 3.0),
                                      child: Text(
                                        "Price",
                                        style: GoogleFonts.exo2(
                                          textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                          autofocus: true,
                                          style: GoogleFonts.exo2(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          decoration: new InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: _hintcolor),
                                            ),
                                            hintStyle: GoogleFonts.exo2(
                                              textStyle: TextStyle(
                                                fontSize: 20,
                                                color: _hintcolor,
                                              ),
                                            ),
                                            hintText: data[0].listPrice,
                                          )),
                                    )
                                  ],
                                ),
                              ),

                              Divider(),

                              FittedBox(
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.center,
                                child: Container(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,

                                          child: EditProductCategoryDropDown(
                                            category: category.toString(),
                                            previous_id: categoryID.toString(),
                                          ),
                                        ),
                                      ],
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
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
//                            height: MediaQuery
//                                .of(context)
//                                .size
//                                .height - 740,
//                            width: MediaQuery
//                                .of(context)
//                                .size
//                                .width - 244,

                                          child: EditProductSubCategoryDropDown(
                                            subcat: sub_category.toString(),
                                            previous_id:
                                                sub_categoryID.toString(),
                                          ),
                                        ),
                                      ],
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
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Container(
//                            height: MediaQuery
//                                .of(context)
//                                .size
//                                .height - 740,
//                            width: MediaQuery
//                                .of(context)
//                                .size
//                                .width - 244,

                                          child: EditProductUnitDropDown(
                                            unit: unit.toString(),
                                            previous_id: unitID.toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Container(
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
//                              .width - 227,
                                        child: EditProductManufacturerDropDown(
                                          manufac: manufac.toString(),
                                          previous_id: manufacID.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //eituk porjonto
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future barcodeScanning1() async {
    try {
      barcode1 = await BarcodeScanner.scan();
      print(barcode1);
      setState(() {
        this.barcode1 = barcode1;
        manu_pn.text = barcode1.rawContent.toString();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode1 = 'No camera permission!' as ScanResult;
        });
      } else {
        setState(() => this.barcode1 = 'Unknown error: $e' as ScanResult);
      }
    } on FormatException {
      setState(() => this.barcode1 = 'Nothing captured.' as ScanResult);
    } catch (e) {
      setState(() => this.barcode1 = 'Unknown error: $e' as ScanResult);
    }
  }

  Future barcodeScanning2() async {
    try {
      barcode2 = await BarcodeScanner.scan();
      print(barcode2);
      setState(() {
        this.barcode2 = barcode2;
        gtin.text = barcode2.rawContent.toString();
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          this.barcode2 = 'No camera permission!' as ScanResult;
        });
      } else {
        setState(() => this.barcode2 = 'Unknown error: $e' as ScanResult);
      }
    } on FormatException {
      setState(() => this.barcode2 = 'Nothing captured.' as ScanResult);
    } catch (e) {
      setState(() => this.barcode2 = 'Unknown error: $e' as ScanResult);
    }
  }

  Widget masterdataview(data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
//          return Text(data[index].productName);
          ProductName.value =
              ProductName.value.copyWith(text: data[index].productName);
          ProductDesc.text = data[index].productDescription;
          gtin.text = data[index].gtin;
          category = data[index].categoryName;
          manufac = data[index].manufacturerName;
          sub_category = data[index].subCategoryName;
          unit = data[index].packagingUnit;
          ListPrice.text = data[index].listPrice;
          id = data[index].id;
          categoryID = data[index].categoryNameId;
          sub_categoryID = data[index].subCategoryNameId;
          manufacID = data[index].manufacturerId;
          unitID = data[index].unitId;
          //manu_pn.text = data[index].manufacturerPN;

          manu_pn.text = "2558";

          sublist_bloc.getCategoryID(data[index].categoryNameId);
          sublist_bloc.getSubCategoryID(data[index].subCategoryNameId);
          sublist_bloc.getUnitID(data[index].unitId);
          sublist_bloc.getManufacturerID(data[index].manufacturerId);

//            productName.text = data[index].productDescription;
        });
  }
}
