import 'dart:async';
import 'dart:io';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/Widgets/AddProductCategoryDropDown.dart';
import 'package:app/Widgets/AddProductManufacturerDropDown.dart';
import 'package:app/Widgets/AddProductSubCategoryDropDown.dart';
import 'package:app/Widgets/AddProductUnitDropDown.dart';
import 'package:camera/camera.dart';
import 'package:camera/new/src/common/camera_interface.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_translate/global.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:responsive_screen/responsive_screen.dart';

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

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  var ImagePath;

  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;


  bool _validate1_prodDesc;
  bool _validate2_barcode;
  bool _validate3_price;
  bool _validate4_image;


  String errortext1_prodDesc = "*Product description can\'t be empty";
  String errortext2_barcode = "*barcode can\'t be empty";
  String errortext3_price = "*price can\'t be empty";
  String errortext4_image = "*Product image not found";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //masterdata_bloc.fetchMaxIDData();
    print(widget.id.toString());
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(firstCamera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  void _openFileExplorer() async {

    setState(() {
      showCapturedPhoto = false;
      imageCache.clear();
    });

    try {
      _paths = null;
      _path = await FilePicker.getFilePath(type: FileType.any);
    }
    on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    setState(() {
      _fileName = _path != null ? _path
          .split('/')
          .last : _paths != null ? _paths.keys.toString() : '...';
    });
    print(_fileName.toString());
    print(_path.toString());
    getImagefromStorage(_path.toString(), _fileName.toString());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;


    dynamic size = MediaQuery.of(context).size;
    dynamic deviceRatio = size.width / size.height;

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            translate('add_product_title').toString(),
            style: GoogleFonts.exo2(
              textStyle: TextStyle(color: Colors.black54, fontSize: 20),
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

//              Fluttertoast.showToast(
//                  msg: "Product Added!",
//                  toastLength: Toast.LENGTH_SHORT,
//                  gravity: ToastGravity.BOTTOM,
//                  timeInSecForIosWeb: 1,
//                  backgroundColor: Colors.green,
//                  textColor: Colors.white,
//                  fontSize: 16.0);  //TODO:: TOAST EXAMPLE


              if(ProductDesc.text.isEmpty &&  ProductDesc.text == ""){
                setState(() {
                  _validate1_prodDesc = false;
                  _validate2_barcode = true;
                  _validate3_price = true;
                  _validate4_image = true;

                });
              }

              else if(gtin.text.isEmpty &&  gtin.text == ""){
                setState(() {
                  _validate1_prodDesc = true;
                  _validate2_barcode = false;
                  _validate3_price = true;
                  _validate4_image = true;

                });
              }

              else if(ListPrice.text.isEmpty && ListPrice.text == ""){
                setState(() {
                  _validate1_prodDesc = true;
                  _validate2_barcode = true;
                  _validate3_price = false;
                  _validate4_image = true;

                });
              }

              else if(ImagePath.toString() == "null"){
                setState(() {
                  _validate1_prodDesc = true;
                  _validate2_barcode = true;
                  _validate3_price = true;
                  _validate4_image = false;

                });
              }

              else{
                setState(() {
                  _validate1_prodDesc = true;
                  _validate2_barcode = true;
                  _validate3_price = true;
                  _validate4_image = true;

                });
              }

              print(ImagePath.toString());

              if(_validate1_prodDesc && _validate2_barcode && _validate3_price){
               print("all validate");

                sublist_bloc.getProductID((widget.id + 1).toString());
                sublist_bloc.getProductDesc(ProductDesc.text);
                sublist_bloc.getGtin(gtin.text);
                sublist_bloc.getListPrice(ListPrice.text);
                sublist_bloc.getProductPhoto((widget.id + 1).toString()+".png");


                sublist_bloc.createProductMasterDatatoDBV2();
                sublist_bloc.dispose();
                masterdata_bloc.fetchAllMasterdatafromDBV2();


               _scaffoldKey.currentState.showSnackBar(SnackBar(
                 content: Text(
                   'Product Added Succesfully',
                   style: GoogleFonts.exo2(
                     textStyle: TextStyle(
                       fontSize: 14,
                     ),
                   ),
                 ),
                 duration: Duration(seconds: 3),
               ));

               Timer(Duration(seconds: 3), () {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (context) => MasterData()));
               }); //TODO:: DELAY EXAMPLE

              }

              else{
                print("Not validate");
              }

              },
            ),
          ],
        ),
        body: DirectSelectContainer(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(left: wp(2), top: hp(2), right: wp(2)),
          child: SingleChildScrollView(
            child: Container(
              width: wp(100),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          translate('product_id').toString(),
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                                fontSize: 14, fontStyle: FontStyle.italic),
                          ),
                        ),
                        Text(
                          "#" + (widget.id + 1).toString(),
                          style: GoogleFonts.exo2(
                            textStyle: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: hp(8), bottom: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            translate('product_desc').toString(),
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: hp(1),
                          ),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            margin:  EdgeInsets.only(
                                top: 0, left: 0, right: 0,bottom: hp(.5)),
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
                              padding: const EdgeInsets.only(left: 8.0, top: 3),
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
                                    hintText:
                                        translate('product_desc').toString(),
                                  )),
                            ),
                          ),

                          _validate1_prodDesc == false ? Text(errortext1_prodDesc,style: TextStyle(
                              fontSize: hp(1.5),
                              color: Colors.red.shade500
                          ),):Text(""),

                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hp(21), bottom: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Barcode",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: hp(1),
                          ),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: 0, left: 0, right: 0,bottom: hp(.5)),
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
                              padding: const EdgeInsets.only(left: 8.0, top: 3),
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
                                      icon: new Image.asset(
                                          'assets/images/barcode.png',
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
                                    hintText: "Enter barcode",
                                  )),
                            ),
                          ),


                          _validate2_barcode == false ? Text(errortext2_barcode,style: TextStyle(
                              fontSize: hp(1.5),
                              color: Colors.red.shade500
                          ),):Text(""),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: hp(34), bottom: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Price",
                            style: GoogleFonts.exo2(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: hp(1),
                          ),
                          Container(
                            height: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                top: 0, left: 0, right: 0),
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
                              padding: const EdgeInsets.only(left: 8.0, top: 3),
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
                                    hintText: "Enter price",
                                  )),
                            ),
                          ),

                          _validate3_price == false ? Text(errortext3_price,style: TextStyle(
                              fontSize: hp(1.5),
                              color: Colors.red.shade500
                          ),):Text(""),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hp(46), bottom: hp(1)),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top:hp(2)),
                                child: Text(
                                  "Add Image/Select Image",
                                  style: GoogleFonts.exo2(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: wp(5),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: (){
                                        setState(() {
                                          showCapturedPhoto =
                                          false;
                                        });
                                        _initializeCamera();
                                      },
                                      icon: Icon(Icons.camera_alt),
                                    ),
                                    SizedBox(width: wp(3),),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: (){
                                        _openFileExplorer();
                                      },
                                      icon: Icon(Icons.attach_file),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),


                          _validate4_image == false ? Text(errortext4_image,style: TextStyle(
                              fontSize: hp(1.5),
                              color: Colors.red.shade500
                          ),):Text(""),

                        ],
                      ),
                    ),
                  ),

                  showCapturedPhoto == false
                      ? Padding(
                    padding: EdgeInsets.only(
                        top: hp(1), bottom: hp(2)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: FutureBuilder<void>(
                        future: _initializeControllerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            // If the Future is complete, display the preview.
                            return Transform.scale(
                                scale: _controller.value
                                    .aspectRatio /
                                    deviceRatio,
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      child: AspectRatio(
                                        aspectRatio:
                                        _controller
                                            .value
                                            .aspectRatio,
                                        child: CameraPreview(_controller), //cameraPreview
                                      ),
                                      alignment: Alignment.topCenter,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: hp(70), bottom: hp(2),right: wp(7)),
                                      child: Align(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.camera,color: Colors.white,size: hp(7),),
                                          onPressed: () {
                                            onCaptureButtonPressed();
                                            print("Captured");
                                          },
                                        ),
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                  ],
                                ));
                          } else {
                            return Center(
                                child: Container(
                                  height: 0,
                                  width: 0,
                                )); // Otherwise, display a loading indicator.
                          }
                        },
                      ),
                    ),
                  )
                      : showCapturedPhoto == true ?  Padding(
                    padding: EdgeInsets.only(top: hp(52), bottom: hp(2)),
                    child: Container(
                      height: hp(50),
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: hp(5)),
                            child: Align(
                              child: Image.file(File(ImagePath),fit: BoxFit.fill,width: wp(80),height: hp(40),),
                              alignment: Alignment.topCenter,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: wp(85)),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: IconButton(
                                onPressed: (){
                                    print(ImagePath.toString());
                                    setState(() {
                                      showCapturedPhoto = null;
                                      deleteFile(ImagePath.toString());
                                      imageCache.clear();
                                    });
                                },
                                icon: Icon(AntDesign.closecircle,color: Colors.black87,size: hp(3),),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ) : Text(""),

                ],
              ),
              color: Colors.transparent,
            ),

//             child: Column(
//                 children: <Widget>[
//               Container(
//                 alignment: Alignment.centerRight,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     ResponsiveGridRow(
//                       children: [
//                         ResponsiveGridCol(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 12.0),
//                             child: Container(
//                               child: Column(
//                                 children: <Widget>[
//                                   Text(
//                                     translate('product_id').toString(),
//                                     style: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                           fontSize: 14,
//                                           fontStyle: FontStyle.italic),
//                                     ),
//                                   ),
//                                 ],
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                               ),
//                             ),
//                           ),
//                         ),
//                         ResponsiveGridCol(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 12.0),
//                             child: Container(
//                               child: Column(
//                                 children: <Widget>[
//                                   Text(
//                                     "#" + (widget.id + 1).toString(),
//                                     style: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                         fontSize: 30,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//
// //                          Text(
// //                            "Product ID",
// //                            style: GoogleFonts.exo2(
// //                              textStyle: TextStyle(
// //                                fontSize: 14,
// //                                fontStyle: FontStyle.italic
// //                              ),
// //                            ),
// //                          ),
// //                          Container(
// //                            height: 35,
// //                            width: 120,
// //                            child: StreamBuilder<sublist_getsuccess_model>(
// //                              stream: masterdata_bloc.MaxIDData,
// //                              builder: (context,
// //                                  AsyncSnapshot<sublist_getsuccess_model>
// //                                      snapshot) {
// //                                if (snapshot.hasData) {
// //                                  sublist_getsuccess_model data = snapshot.data;
// //                                  print("Cat er Data gula:: ");
// //                                  //return masterdataview(data);
// //
// //                                  return Center(
// //                                    child: Text(
// //                                      "#"+data.id.toString(),
// //                                      style: GoogleFonts.exo2(
// //                                        textStyle: TextStyle(
// //                                          fontSize: 30,
// //                                        ),
// //                                      ),
// //                                    ),
// //                                  );
// //                                  //return Text(data[index].categoryName);
// //
// //                                  //TODO:: eikhan theke start hbe
// //
// //                                } else if (snapshot.hasError) {
// //                                  return Text("${snapshot.error}");
// //                                }
// //
// //                                return Center(child: CircularProgressIndicator());
// //                              },
// //                            ),
// //                          ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 1,
//               ),
//               Container(
//                 height: 90,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       height: 90,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: 13, bottom: 3),
//                             child: Text(
//                               translate('product_desc').toString(),
//                               style: GoogleFonts.exo2(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 50,
//                             alignment: Alignment.center,
//                             margin: const EdgeInsets.only(
//                                 top: 0, left: 13, right: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: Offset(1, 1),
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0, top: 3),
//                               child: TextField(
//                                   controller: ProductDesc,
//                                   autocorrect: true,
//                                   style: GoogleFonts.exo2(
//                                     textStyle: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   decoration: new InputDecoration(
//                                     border: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     enabledBorder: InputBorder.none,
//                                     errorBorder: InputBorder.none,
//                                     disabledBorder: InputBorder.none,
//                                     hintStyle: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     labelStyle: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     hintText:
//                                         translate('product_desc').toString(),
//                                   )),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Container(
//                       height: 90,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: 13, bottom: 3),
//                             child: Text(
//                               translate('gtin').toString(),
//                               style: GoogleFonts.exo2(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 50,
//                             width: MediaQuery.of(context).size.width - 40,
//                             alignment: Alignment.center,
//                             margin: const EdgeInsets.only(
//                                 top: 0, left: 13, right: 10),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.white,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: Offset(1, 1),
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0, top: 3),
//                               child: TextField(
//                                   controller: gtin,
//                                   autocorrect: true,
//                                   style: GoogleFonts.exo2(
//                                     textStyle: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   decoration: new InputDecoration(
//                                     suffixIcon: IconButton(
//                                       icon: new Image.asset(
//                                           'assets/images/barcode.png',
//                                           fit: BoxFit.contain),
//                                       tooltip: 'Scan barcode',
//                                       onPressed: barcodeScanning2,
//                                     ),
//                                     border: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     enabledBorder: InputBorder.none,
//                                     errorBorder: InputBorder.none,
//                                     disabledBorder: InputBorder.none,
//                                     hintStyle: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     labelStyle: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     hintText: translate('gtin_hint').toString(),
//                                   )),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 1,
//                     ),
//                     Container(
//                       height: 90,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: 13, bottom: 3),
//                             child: Text(
//                               translate('listprice').toString(),
//                               style: GoogleFonts.exo2(
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             height: 50,
//                             width: MediaQuery.of(context).size.width - 40,
//                             alignment: Alignment.center,
//                             margin: const EdgeInsets.only(
//                                 top: 0, left: 13, right: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.3),
//                                   spreadRadius: 2,
//                                   blurRadius: 5,
//                                   offset: Offset(1, 1),
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 8.0, top: 3),
//                               child: TextField(
//                                   controller: ListPrice,
//                                   autocorrect: true,
//                                   style: GoogleFonts.exo2(
//                                     textStyle: TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                   decoration: new InputDecoration(
//                                     border: InputBorder.none,
//                                     focusedBorder: InputBorder.none,
//                                     enabledBorder: InputBorder.none,
//                                     errorBorder: InputBorder.none,
//                                     disabledBorder: InputBorder.none,
//                                     hintStyle: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     labelStyle: GoogleFonts.exo2(
//                                       textStyle: TextStyle(
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                     hintText:
//                                         translate('listprice_hint').toString(),
//                                   )),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Divider(),
//                   ],
//                 ),
//               ),
//             ]),
          ),
        )));
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

  void onCaptureButtonPressed() async {
    //on camera button press
    try {


      List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
      var root = storageInfo[0].rootDir+"/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

      print(root.toString());

      final path = join((root.toString()),'${(widget.id+1).toString()}.png',);

      var file = File(path);

      if(file.exists() == null) {
        print("file not exist");
        //await file.delete();

        Timer(Duration(milliseconds: 200),() async{
          print("Got the timer");
          print(path.toString());

          setState(() {
            ImagePath = path;
          });
          await _controller.takePicture(path); //take photo

          setState(() {
            showCapturedPhoto = true;
          });

        });
      }


      else{
        print("file exist");
        //await file.delete();

        Timer(Duration(milliseconds: 200),() async{
          print("Got the timer");
          print(path.toString());

          setState(() {
            ImagePath = path;
          });
          await _controller.takePicture(path); //take photo

          setState(() {
            showCapturedPhoto = true;
          });

        });

      }

    } catch (e) {
      print(e);
    }
  }



  Future<void> deleteFile(String file_name) async {

    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir +
        "/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

    print(root.toString() + " and file is " + file_name.toString());

    try {
      var file = File(file_name.toString());

      if (await file.exists()) {
        // file exits, it is safe to call delete on it
        await file.delete();
      }

    } catch (e) {
      // error in getting access to the file
      print("Error");
    }
  }

  void getImagefromStorage(String path,String fileName) async{
    print("path is "+path);
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir +
        "/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

    print(root.toString());

    moveFile(File(path), root+"/"+'${(widget.id + 1).toString()}.png');
  }


  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path

      setState(() {
        ImagePath = newPath;
        showCapturedPhoto = true;
      });
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
}
