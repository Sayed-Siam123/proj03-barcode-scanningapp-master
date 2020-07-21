import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
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

import 'MasterData.dart';

class ProductEditPage extends StatefulWidget {
  final String productname, description;

  const ProductEditPage({Key key, this.productname, this.description})
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
    masterdata_bloc.getsinglemasterdata();
    //productName.text = widget.productname;
    print(widget.productname);
    super.initState();
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
          style: new TextStyle(color: Colors.black54),
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
                sublist_bloc.getProductName(ProductName.text);
                sublist_bloc.getProductDesc(ProductDesc.text);
                sublist_bloc.getManufacturerPn(manu_pn.text);
                sublist_bloc.getGtin(gtin.text);
                sublist_bloc.getListPrice(ListPrice.text);
                sublist_bloc.UpdateProductMasterData();
//
              sublist_bloc.dispose();
              masterdata_bloc.fetchAllMasterData();

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
        height: MediaQuery.of(context).size.height - 180,
        width: MediaQuery.of(context).size.width - 14,
        margin: EdgeInsets.only(left: 5, top: 10, right: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Product Name:",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 85,
                          ),
                          Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 250,
                            height: 50,
                            width: 150,
                            child: TextField(
                              controller: ProductName,
                              autocorrect: true,
                              style: TextStyle(fontSize: 17),
                              decoration:
                                  InputDecoration(hintText: 'Product Name'),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
//
              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Product Description:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,
                            height: 50,
                            width: 160,
                            child: TextField(
                              controller: ProductDesc,
                              autocorrect: true,
                              style: TextStyle(fontSize: 17),
                              decoration:
                                  InputDecoration(hintText: 'Description'),
                            )),
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
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Category:",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 125,
                          ),
                          Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 244,
                            height: 50,
                            width: 150,
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
                          Text(
                            "Sub Category:",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 96,
                          ),
                          Container(
//                            height: MediaQuery
//                                .of(context)
//                                .size
//                                .height - 740,
//                            width: MediaQuery
//                                .of(context)
//                                .size
//                                .width - 244,
                            height: 50,
                            width: 150,
                            child: EditProductSubCategoryDropDown(
                              subcat: sub_category.toString(),
                              previous_id: sub_categoryID.toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
//
              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Unit:",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 155,
                          ),
                          Container(
//                            height: MediaQuery
//                                .of(context)
//                                .size
//                                .height - 740,
//                            width: MediaQuery
//                                .of(context)
//                                .size
//                                .width - 244,
                            height: 50,
                            width: 165,
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
              ),
//
              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 10),
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Manufacturer:",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 227,
                            height: 50,
                            width: 200,
                            child: EditProductManufacturerDropDown(
                              manufac: manufac.toString(),
                              previous_id: manufacID.toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Manufacturer PN:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 282,
                            height: 50,
                            width: 150,
                            child: TextField(
                              controller: manu_pn,
                              autocorrect: true,
                              style: TextStyle(fontSize: 17),
                              decoration: InputDecoration(hintText: ''),
                            )),
                        IconButton(
                          icon: new Image.asset('assets/images/barcode.png',
                              fit: BoxFit.contain),
                          tooltip: 'Scan barcode',
                          onPressed: barcodeScanning1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
//
              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "GTIN:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 110,
                        ),
                        Container(
//                            height: MediaQuery
//                                .of(context)
//                                .size
//                                .height - 740,
//                            width: MediaQuery
//                                .of(context)
//                                .size
//                                .width - 284,
                            height: 50,
                            width: 150,
                            child: TextField(
                              controller: gtin,
                              autocorrect: true,
                              style: TextStyle(fontSize: 17),
                              decoration: InputDecoration(hintText: ''),
                            )),
                        IconButton(
                          icon: new Image.asset('assets/images/barcode.png',
                              fit: BoxFit.contain),
                          tooltip: 'Scan barcode',
                          onPressed: barcodeScanning2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              FittedBox(
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                child: Container(
//                  height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 15,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "ListPrice:",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          width: 85,
                        ),
                        Container(
//                          height: MediaQuery
//                              .of(context)
//                              .size
//                              .height - 740,
//                          width: MediaQuery
//                              .of(context)
//                              .size
//                              .width - 234,
                            height: 50,
                            width: 210,
                            child: TextField(
                              controller: ListPrice,
                              autocorrect: true,
                              style: TextStyle(fontSize: 17),
                              decoration: InputDecoration(hintText: ''),
                            )),
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

              //eituk porjonto

              Container(
                margin: EdgeInsets.all(20),
                child: StreamBuilder<List<SingleMasterDataModel>>(
                    stream: masterdata_bloc.singleMasterData,
                    builder: (context,
                        AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
                      if (snapshot.hasData) {
                        List<SingleMasterDataModel> data = snapshot.data;
                        print("Data gula:: ");
                        print(data.length);
                        return masterdataview(data);
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

  Widget masterdataview(data) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: data.length,
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
//          return Text(data[index].productName);
          ProductName.text = data[index].productName;
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
