import 'dart:async';
import 'dart:io';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/ColorLibrary/HexColor.dart';
import 'package:app/Handler/HandlerModel.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/CatagoryModel.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/Details.dart';
import 'package:app/Widgets/EditProductCategoryDropDown.dart';
import 'package:app/Widgets/EditProductManufacturerDropDown.dart';
import 'package:app/Widgets/EditProductSubCategoryDropDown.dart';
import 'package:app/Widgets/EditProductUnitDropDown.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:camera/camera.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_translate/global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:responsive_screen/responsive_screen.dart';

import 'Home.dart';
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
  String propic,
      newFlag,
      isTransfertoApp,
      isOrderableviaApp,
      productHeight,
      ProductLength;

  CategoryModel CategoryPass;

  ScanResult barcode1;
  ScanResult barcode2;

  TextEditingController ProductName = new TextEditingController();
  TextEditingController ProductDesc = new TextEditingController();
  TextEditingController manu_pn = new TextEditingController();
  TextEditingController gtin = new TextEditingController();
  TextEditingController ListPrice = new TextEditingController();

  final Color _hintcolor = new HexColor("#737373");
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  HandlerClass handle;

//  List<SingleMasterDataModel> data;
  List<SingleMasterDataModelV2> data;

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = true;
  var ImagePath;

  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;

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

  void getImagefromStorage(String path,String fileName) async{
    print("path is "+path);
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir +
        "/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

    print(root.toString());

    moveFile(File(path), root+"/"+'$id.png',root);
  }


  Future<File> moveFile(File sourceFile, String newPath,String root) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path

      setState(() {
        ImagePath = root;
        showCapturedPhoto = true;
      });
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file and then delete it
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }

  void imagePath() async{
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir +
        "/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

    setState(() {
      ImagePath = root;
    });

    print(root.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    masterdata_bloc.getsinglemasterdatafromDBV2();
    //productName.text = widget.productname;
    print(widget.productname);
    Timer(Duration(),(){
      imagePath();
    });
    super.initState();
    sublist_bloc.dispose();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
    sublist_bloc.dispose();
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          translate('edit_product').toString(),
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
              context, MaterialPageRoute(builder: (context) => MasterData())),
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

//                sublist_bloc.getProductName(ProductName.text);
//                sublist_bloc.getProductDesc(ProductDesc.text);
//                sublist_bloc.getManufacturerPn(manu_pn.text);
//                sublist_bloc.getGtin(gtin.text);
//                sublist_bloc.getListPrice(ListPrice.text);
                //sublist_bloc.UpdateProductMasterData();
//
//                sublist_bloc.dispose();
//                masterdata_bloc.fetchAllMasterData();
                sublist_bloc.getProductID(id.toString());

                // if (ProductName.text.isEmpty) {
                //   print("previous Name: " + pre_name);
                //   sublist_bloc.getProductName(pre_name);
                // } else if (ProductName.text.isNotEmpty) {
                //   print("New Name: " + ProductName.text);
                //   sublist_bloc.getProductName(ProductName.text);
                // }

                if (ProductDesc.text.isEmpty) {
                  print("previous Desc: " + pre_productdesc);
                  sublist_bloc.getProductDesc(pre_productdesc);
                } else if (ProductDesc.text.isNotEmpty) {
                  print("New Desc: " + ProductDesc.text);
                  sublist_bloc.getProductDesc(ProductDesc.text);
                }

                // if (manu_pn.text.isEmpty) {
                //   print("previous ManuPIN: " + "aas");
                //   sublist_bloc.getManufacturerPn(pre_manu_pin);
                // } else if (manu_pn.text.isNotEmpty) {
                //   print("New ManuPin: " + manu_pn.text);
                //   sublist_bloc.getManufacturerPn(manu_pn.text);
                // }

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

                //print(categoryID.toString());

                // sublist_bloc.getPreviousCategoryID(categoryID);
                // sublist_bloc.getPreviousManufacturerID(manufacID);
                // sublist_bloc.getPreviousSubCategoryID(sub_categoryID);
                // sublist_bloc.getPreviousUnitID(unitID);
                //
                // sublist_bloc.getPreviousCategoryName(category);
                // sublist_bloc.getPreviousManufacturerName(manufac);
                // sublist_bloc.getPreviousSubCategoryName(sub_category);
                // sublist_bloc.getPreviousUnitName(unit);

                MasterDataModelV2 data = MasterDataModelV2(
                  productPicture: propic.toString(),
                  newFlag: newFlag.toString(),
                );

                print("eikhnane submit");
                sublist_bloc.UpdateProductMasterDatatoDBV2(data);
                sublist_bloc.dispose();

                ProductName.text = "";
                ProductDesc.text = "";
                manu_pn.text = "";
                gtin.text = "";
                ListPrice.text = "";

                // Fluttertoast.showToast(
                //     msg: "Product Updated!",
                //     toastLength: Toast.LENGTH_SHORT,
                //     gravity: ToastGravity.BOTTOM,
                //     timeInSecForIosWeb: 1,
                //     backgroundColor: Colors.green,
                //     textColor: Colors.white,
                //     fontSize: 16.0);

                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                    'Updated Successfully',
                    style: GoogleFonts.exo2(),
                  ),
                  duration: Duration(seconds: 3),
                ));

                Timer(Duration(seconds: 3), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MasterData()));
                }); //TODO:: DELAY EXAMPLE
              }),
        ],
      ),
      body: DirectSelectContainer(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: StreamBuilder<List<SingleMasterDataModelV2>>(
                      stream: masterdata_bloc.singleMasterDatav2,
                      builder: (context,
                          AsyncSnapshot<List<SingleMasterDataModelV2>>
                              snapshot) {
                        if (snapshot.hasData) {
                          data = snapshot.data;
                          print("Data gula:: ");
                          print(data.length);

                          id = data[0].id;
                          pre_productdesc = data[0].productDescription;
                          pre_gtin = data[0].gtin;
                          pre_listprice = data[0].listPrice;
                          propic = data[0].productPicture;
                          newFlag = data[0].newFlag;

                          return Padding(
                            padding: EdgeInsets.all(wp(4)),
                            child: Container(
                              height: hp(90),
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: hp(1), bottom: hp(2)),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: hp(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                translate('product_desc')
                                                    .toString(),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 0, 0),
                                                  child: TextField(
                                                      controller: ProductDesc,
                                                      autocorrect: true,
                                                      style: GoogleFonts.exo2(
                                                        textStyle: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      decoration:
                                                          new InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        hintStyle:
                                                            GoogleFonts.exo2(
                                                          textStyle: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        labelStyle:
                                                            GoogleFonts.exo2(
                                                          textStyle: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        hintText: data[0]
                                                            .productDescription,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: hp(11), bottom: hp(2)),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: hp(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Barcode",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 0, 0),
                                                  child: TextField(
                                                      controller: gtin,
                                                      autocorrect: true,
                                                      style: GoogleFonts.exo2(
                                                        textStyle: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      decoration:
                                                          new InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        hintStyle:
                                                            GoogleFonts.exo2(
                                                          textStyle: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        labelStyle:
                                                            GoogleFonts.exo2(
                                                          textStyle: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        hintText: data[0].gtin,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: hp(21), bottom: hp(2)),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: hp(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Price",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(1, 1),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 0, 0, 0),
                                                  child: TextField(
                                                      controller: ListPrice,
                                                      autocorrect: true,
                                                      style: GoogleFonts.exo2(
                                                        textStyle: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      decoration:
                                                          new InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        focusedBorder:
                                                            InputBorder.none,
                                                        enabledBorder:
                                                            InputBorder.none,
                                                        errorBorder:
                                                            InputBorder.none,
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        hintStyle:
                                                            GoogleFonts.exo2(
                                                          textStyle: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        labelStyle:
                                                            GoogleFonts.exo2(
                                                          textStyle: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        hintText:
                                                            data[0].listPrice,
                                                      )),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: hp(31), bottom: hp(2)),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          height: hp(100),
                                          alignment: Alignment.center,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: hp(2)),
                                                    child: Text(
                                                      "Capture Picture/Add Picture",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              showCapturedPhoto =
                                                                  false;
                                                            });
                                                            _initializeCamera();
                                                          },
                                                          icon: Icon(Icons
                                                              .camera_alt)),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            _openFileExplorer();
                                                          },
                                                          icon: Icon(Icons
                                                              .attach_file)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),

                                  showCapturedPhoto == false
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: hp(1), bottom: hp(2)),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: FutureBuilder<void>(
                                              future:
                                                  _initializeControllerFuture,
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
                                                              child: CameraPreview(
                                                                  _controller), //cameraPreview
                                                            ),
                                                            alignment: Alignment
                                                                .topCenter,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: hp(70),
                                                                    bottom:
                                                                        hp(2),
                                                                    right:
                                                                        wp(7)),
                                                            child: Align(
                                                              child: IconButton(
                                                                icon: Icon(
                                                                  Icons.camera,
                                                                  color: Colors
                                                                      .white,
                                                                  size: hp(7),
                                                                ),
                                                                onPressed: () {
                                                                  onCaptureButtonPressed();
                                                                  print(
                                                                      "Captured");
                                                                },
                                                              ),
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
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
                                      : showCapturedPhoto == true
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: hp(40), bottom: hp(2)),
                                              child: Container(
                                                height: hp(50),
                                                width: double.infinity,
                                                color: Colors.transparent,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: hp(5)),
                                                      child: Align(
                                                        child: Image.file(
                                                          File(ImagePath+"/"+id.toString()+".png"),
                                                          fit: BoxFit.fill,
                                                          width: wp(80),
                                                          height: hp(40),
                                                        ),
                                                        alignment:
                                                            Alignment.topCenter,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: wp(85)),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            print(ImagePath.toString());
                                                            setState(() {
                                                              showCapturedPhoto = null;
                                                              deleteFile(ImagePath+"/"+id.toString()+".png");
                                                              imageCache.clear();
                                                            });
                                                          },
                                                          icon: Icon(
                                                            AntDesign.closecircle,
                                                            color:
                                                                Colors.black87,
                                                            size: hp(3),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Text(""),

                                  // ResponsiveGridCol(
                                  //   lg: 12,
                                  //   child: Container(
                                  //       height: 95,
                                  //       alignment: Alignment.center,
                                  //       child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: <Widget>[
                                  //           Container(
                                  //             child: Padding(
                                  //               padding: EdgeInsets.only(top: 0,left: 0.0, right: 0),
                                  //               child: Row(
                                  //                 children: <Widget>[
                                  //                   Container(
                                  //                     child: EditProductCategoryDropDown(category: category),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //   ),
                                  // ),
                                  //
                                  // ResponsiveGridCol(
                                  //   lg: 12,
                                  //   child: Container(
                                  //       height: 95,
                                  //       alignment: Alignment.center,
                                  //       child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: <Widget>[
                                  //           Container(
                                  //             child: Padding(
                                  //               padding: EdgeInsets.only(top: 0,left: 0.0, right: 0),
                                  //               child: Row(
                                  //                 children: <Widget>[
                                  //                   Container(
                                  //                     child: EditProductSubCategoryDropDown(subcat: sub_category,),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //   ),
                                  // ),
                                  //
                                  // ResponsiveGridCol(
                                  //   lg: 12,
                                  //   child: Container(
                                  //       height: 95,
                                  //       alignment: Alignment.center,
                                  //       child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: <Widget>[
                                  //           Container(
                                  //             child: Padding(
                                  //               padding: EdgeInsets.only(top: 0,left: 0.0, right: 0),
                                  //               child: Row(
                                  //                 children: <Widget>[
                                  //                   Container(
                                  //                     child: EditProductManufacturerDropDown(manufac: manufac,),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //   ),
                                  // ),
                                  //
                                  // ResponsiveGridCol(
                                  //   lg: 12,
                                  //   child: Container(
                                  //       height: 95,
                                  //       alignment: Alignment.center,
                                  //       child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: <Widget>[
                                  //           Container(
                                  //             child: Padding(
                                  //               padding: EdgeInsets.only(top: 0,left: 0.0, right: 0),
                                  //               child: Row(
                                  //                 children: <Widget>[
                                  //                   Container(
                                  //                     child: EditProductUnitDropDown(unit: unit,),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //   ),
                                  // ),
                                ],
                              ),
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

  void onCaptureButtonPressed() async {
    //on camera button press
    try {
      List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
      var root = storageInfo[0].rootDir +
          "/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

      print(root.toString());

      final path = join(
        (root.toString()),
        '${(int.parse(id)).toString()}.png',
      );

      setState(() {
        ImagePath = root;
      });
      await _controller.takePicture(path); //take photo

      setState(() {
        showCapturedPhoto = true;
      });
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
}
