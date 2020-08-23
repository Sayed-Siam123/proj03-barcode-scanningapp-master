import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/Widgets/AddProductCategoryDropDown.dart';
import 'package:app/Widgets/AddProductManufacturerDropDown.dart';
import 'package:app/Widgets/AddProductSubCategoryDropDown.dart';
import 'package:app/Widgets/AddProductUnitDropDown.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AddProductPage extends StatefulWidget {

  final int id;

  const AddProductPage({Key key, this.id}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  ScanResult barcode1;
  ScanResult barcode2;

  TextEditingController ProductName = TextEditingController();
  TextEditingController ProductDesc = TextEditingController();
  TextEditingController manu_pn = TextEditingController();
  TextEditingController gtin = TextEditingController();
  TextEditingController ListPrice = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    masterdata_bloc.fetchMaxIDData();
    print(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: GoogleFonts.exo2(
            textStyle: TextStyle(
              color: Colors.black54,
              fontSize: 20
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
              context, MaterialPageRoute(builder: (context) => MasterData())),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.save,
              color: Colors.black54,
            ),
            onPressed: () {

              sublist_bloc.getProductID((widget.id+1).toString());
              sublist_bloc.getProductName(ProductName.text);
              sublist_bloc.getProductDesc(ProductDesc.text);
              sublist_bloc.getManufacturerPn(manu_pn.text);
              sublist_bloc.getGtin(gtin.text);
              sublist_bloc.getListPrice(ListPrice.text);
              sublist_bloc.createProductMasterDatatoDB();
              sublist_bloc.dispose();
              masterdata_bloc.fetchAllMasterdatafromDB();

//              Fluttertoast.showToast(
//                  msg: "Product Added!",
//                  toastLength: Toast.LENGTH_SHORT,
//                  gravity: ToastGravity.BOTTOM,
//                  timeInSecForIosWeb: 1,
//                  backgroundColor: Colors.green,
//                  textColor: Colors.white,
//                  fontSize: 16.0);  //TODO:: TOAST EXAMPLE

              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Product Added',
                      style: GoogleFonts.exo2(
                        textStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),),
                    duration: Duration(seconds: 3),
                  ));

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MasterData()));



            },
          ),
        ],
      ),
      body: DirectSelectContainer(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(left: 5, top: 10, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Container(
                  alignment: Alignment.centerRight,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          ResponsiveGridRow(
                            children: [
                              ResponsiveGridCol(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                    Text(
                                      "Product ID",
                                      style: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ],
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                    ),
                                  ),
                                ),
                              ),
                              ResponsiveGridCol(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                      Text(
                                      "#"+(widget.id+1).toString(),
                                      style: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )

//                          Text(
//                            "Product ID",
//                            style: GoogleFonts.exo2(
//                              textStyle: TextStyle(
//                                fontSize: 14,
//                                fontStyle: FontStyle.italic
//                              ),
//                            ),
//                          ),
//                          Container(
//                            height: 35,
//                            width: 120,
//                            child: StreamBuilder<sublist_getsuccess_model>(
//                              stream: masterdata_bloc.MaxIDData,
//                              builder: (context,
//                                  AsyncSnapshot<sublist_getsuccess_model>
//                                      snapshot) {
//                                if (snapshot.hasData) {
//                                  sublist_getsuccess_model data = snapshot.data;
//                                  print("Cat er Data gula:: ");
//                                  //return masterdataview(data);
//
//                                  return Center(
//                                    child: Text(
//                                      "#"+data.id.toString(),
//                                      style: GoogleFonts.exo2(
//                                        textStyle: TextStyle(
//                                          fontSize: 30,
//                                        ),
//                                      ),
//                                    ),
//                                  );
//                                  //return Text(data[index].categoryName);
//
//                                  //TODO:: eikhan theke start hbe
//
//                                } else if (snapshot.hasError) {
//                                  return Text("${snapshot.error}");
//                                }
//
//                                return Center(child: CircularProgressIndicator());
//                              },
//                            ),
//                          ),


                        ],
                      ),
                    ),

                SizedBox(
                  height: 1,
                ),

                Container(
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 13,bottom: 3),
                        child: Text("Product Name",style: GoogleFonts.exo2(
                          fontSize: 14,
                        ),),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 0, left: 13, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 3),
                          child: TextField(
                            controller: ProductName,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Product Name",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 5,
                ),

                Container(
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 13,bottom: 3),
                        child: Text("Description",style: GoogleFonts.exo2(
                          fontSize: 14,
                        ),),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 0, left: 13, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 3),
                          child: TextField(
                            controller: ProductDesc,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Product Description",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                 SizedBox(height: 5,),

                 Container(
                   height: 360,
                   width: double.infinity,
                   color: Colors.white,
                   child: Column(
                     children: <Widget>[
                       Container(
                         child: Padding(
                           padding: EdgeInsets.only(top: 7,left: 12.0, right: 0),
                           child: Row(
                             children: <Widget>[
                               Container(
                                 child: AddProductCategoryDropDown(),
                               ),
                             ],
                           ),
                         ),
                       ),
                       SizedBox(
                         height: 1,
                       ),

                     Container(
                       child: Padding(
                         padding: EdgeInsets.only(top: 7,left: 12.0, right: 0),
                         child: Row(
                           children: <Widget>[
                             Container(
                               child: AddProductSubCategoryDropDown(),
                             ),
                           ],
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 1,
                     ),

                     Container(
                       child: Padding(
                         padding: EdgeInsets.only(top: 7,left: 12.0, right: 0),
                         child: Container(
                           child: Row(
                             children: <Widget>[
                               Container(
                                 child: AddProductUnitDropDown(),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),

                     SizedBox(
                       height: 1,
                     ),

                     Container(
                       child: Padding(
                         padding: EdgeInsets.only(top: 7,left: 12.0, right: 0),
                         child: Container(
                           alignment: Alignment.center,
                           child: Row(
                             children: <Widget>[
                               Container(
                                 child: AddProductManufacturerDropDown(),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                     ],
                   ),
                 ),


                SizedBox(
                  height: 15,
                ),

                Container(
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 13,bottom: 3),
                        child: Text("Manufacturer PN",style: GoogleFonts.exo2(
                          fontSize: 14,
                        ),),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 0, left: 13, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 3),
                          child: TextField(
                              controller: manu_pn,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                suffixIcon: IconButton(
                                  icon: new Image.asset('assets/images/barcode.png',
                                      fit: BoxFit.contain),
                                  tooltip: 'Scan barcode',
                                  onPressed: barcodeScanning1,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Enter Manufacturer PN",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 1,
                ),

                Container(
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 13,bottom: 3),
                        child: Text("GTIN",style: GoogleFonts.exo2(
                          fontSize: 14,
                        ),),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 0, left: 13, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 3),
                          child: TextField(
                              controller: gtin,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                suffixIcon: IconButton(
                                  icon: new Image.asset('assets/images/barcode.png',
                                      fit: BoxFit.contain),
                                  tooltip: 'Scan barcode',
                                  onPressed: barcodeScanning2,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Enter GTIN",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 1,
                ),

                Container(
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 13,bottom: 3),
                        child: Text("Price",style: GoogleFonts.exo2(
                          fontSize: 14,
                        ),),
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-40,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 0, left: 13, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0,top: 3),
                          child: TextField(
                              controller: ListPrice,
                              autocorrect: true,
                              style: GoogleFonts.exo2(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                labelStyle: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                hintText: "Enter Price",
                              )),
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(),

              ],
            ),
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
}
