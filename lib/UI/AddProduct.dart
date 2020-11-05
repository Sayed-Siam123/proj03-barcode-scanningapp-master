import 'dart:async';
import 'dart:io';
import 'package:honeywell_scanner/honeywell_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Handler/app_localizations.dart';
import 'package:app/Model/GetSuccess_Model.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/Widgets/AddProductCategoryDropDown.dart';
import 'package:app/Widgets/AddProductManufacturerDropDown.dart';
import 'package:app/Widgets/AddProductSubCategoryDropDown.dart';
import 'package:app/Widgets/AddProductUnitDropDown.dart';
import 'package:app/resources/SharedPrefer.dart';
import 'package:camera/camera.dart';
import 'package:camera/new/src/common/camera_interface.dart';
import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_snackbar/flutter_snackbar.dart';
import 'package:flutter_translate/global.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:sweetalert/sweetalert.dart';

class AddProductPage extends StatefulWidget {
  final int id;
  final BuildContext context;

  const AddProductPage({Key key, this.id, this.context}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> with WidgetsBindingObserver implements ScannerCallBack{
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
  File _image;


  var isEditable = false;
  FocusNode _focusNode = new FocusNode();

  String _fileName;
  String _path;
  Map<String, String> _paths;
  String _extension;
  bool _multiPick = false;
  bool _hasValidMime = false;
  FileType _pickingType;

  String desc_text = ""; // empty string to carry what was there before it
  int maxLength = 25;

  GlobalKey<SnackBarWidgetState> _globalKey = GlobalKey();

  SessionManager prefs = new SessionManager();

  bool _validate1_prodDesc;
  bool _validate2_barcode;
  bool _validate3_price;
  bool _validate4_image;

  List<MasterDataModelV2> fetcheddata = [];
  List<MasterDataModelV2> _newData = [];
  List<MasterDataModelV2> _newData2 = [];

  //SnackbarHelper snack = new SnackbarHelper();

  bool _managePrices = false;
  String _managePricesKey = "_managePrices";

  String _showPricesKey = "_showPrices";

  String errortext1_prodDesc = "*Product description can\'t be empty";
  String errortext2_barcode = "*barcode can\'t be empty";
  String errortext3_price = "*price can\'t be empty";
  String errortext4_image = "*Product image not found";


  HoneywellScanner honeywellScanner = HoneywellScanner();
  String scannedCode = 'Empty';
  bool scannerEnabled = false;
  bool scan1DFormats = true;
  bool scan2DFormats = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //masterdata_bloc.fetchMaxIDData();
    print(widget.id.toString());
    fetcheddata.clear();
    _newData.clear();
    masterdata_bloc.fetchAllMasterdatafromDBV2();
    getPricestatus();
    WidgetsBinding.instance.addObserver(this);
    honeywellScanner.setScannerCallBack(this);
    updateScanProperties();
    //barcodeScanning2();

    Timer(Duration(milliseconds: 500),(){
      honeywellScanner.startScanner();
      scannerEnabled = true;
    });

  }


  updateScanProperties() {
    List<CodeFormat> codeFormats = [];
    if (scan1DFormats ?? false)
      codeFormats.addAll(CodeFormatUtils.ALL_1D_FORMATS);
    if (scan2DFormats ?? false)
      codeFormats.addAll(CodeFormatUtils.ALL_2D_FORMATS);

//    codeFormats.add(CodeFormat.AZTEC);
//    codeFormats.add(CodeFormat.CODABAR);
//    codeFormats.add(CodeFormat.CODE_39);
//    codeFormats.add(CodeFormat.CODE_93);
//    codeFormats.add(CodeFormat.CODE_128);
//    codeFormats.add(CodeFormat.DATA_MATRIX);
//    codeFormats.add(CodeFormat.EAN_8);
//    codeFormats.add(CodeFormat.EAN_13);
////    codeFormats.add(CodeFormat.ITF);
//    codeFormats.add(CodeFormat.MAXICODE);
//    codeFormats.add(CodeFormat.PDF_417);
//    codeFormats.add(CodeFormat.QR_CODE);
//    codeFormats.add(CodeFormat.RSS_14);
//    codeFormats.add(CodeFormat.RSS_EXPANDED);
//    codeFormats.add(CodeFormat.UPC_A);
//    codeFormats.add(CodeFormat.UPC_E);
////    codeFormats.add(CodeFormat.UPC_EAN_EXTENSION);

    honeywellScanner.setProperties(
        CodeFormatUtils.getAsPropertiesComplement(codeFormats));
  }

  @override
  void onDecoded(String result) {
    setState(() {
      scannedCode = result;
      gtin.text = scannedCode;
    });
    honeywellScanner.stopScanner();
    setState(() {
      scannerEnabled = false;
    });
  }

  @override
  void onError(Exception error) {
    setState(() {
      scannedCode = error.toString();
    });
  }


  _imgFromCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = image;
        print(_image.toString());
        getImagefromStorage('${_image.path}', 'fileName');
        showCapturedPhoto = true;
      });
      print(_image.path.toString());
      //getImagefromStorage(_image.path.toString(),widget.id.toString());

    }
  }

  _imgFromGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = image;
        print(_image.toString());
        getImagefromStorage('${_image.toString()}', 'fileName');
        showCapturedPhoto = true;
      });
      print("picked " + _image.path.toString());
      //getImagefromStorage(_image.path.toString(),widget.id.toString());
    }
  }

  void getPricestatus() async {
    Future<bool> managePrice = prefs.getBoolData(_managePricesKey);
    managePrice.then((data) {
      if (data != null) {
        setState(() {
          _managePrices = data;
        });
      } else {
        setState(() {
          _managePrices = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
    if(honeywellScanner != null) honeywellScanner.stopScanner();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }

    if(state == null) return;
    switch(state){
      case AppLifecycleState.resumed:
        if(honeywellScanner != null) honeywellScanner.resumeScanner();
        break;
      case AppLifecycleState.inactive:
        if(honeywellScanner != null) honeywellScanner.pauseScanner();
        break;
      case AppLifecycleState.paused://AppLifecycleState.paused is used as stopped state because deactivate() works more as a pause for lifecycle
        if(honeywellScanner != null) honeywellScanner.pauseScanner();
        break;
      case AppLifecycleState.detached:
        if(honeywellScanner != null) honeywellScanner.pauseScanner();
        break;
      default:
        break;
    }  }

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
            "New Value",
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

                if (ProductDesc.text.isEmpty && ProductDesc.text == "") {
                  setState(() {
                    _validate1_prodDesc = false;
                    _validate2_barcode = true;
                    _validate3_price = true;
                    _validate4_image = true;
                  });
                } else if (gtin.text.isEmpty && gtin.text == "") {
                  setState(() {
                    _validate1_prodDesc = true;
                    _validate2_barcode = false;
                    _validate3_price = true;
                    _validate4_image = true;
                  });
                } else if (ListPrice.text.isEmpty && ListPrice.text == "") {
                  if (_managePrices == true) {
                    setState(() {
                      _validate1_prodDesc = true;
                      _validate2_barcode = true;
                      _validate3_price = false;
                      _validate4_image = true;
                    });
                  } else {
                    setState(() {
                      _validate1_prodDesc = true;
                      _validate2_barcode = true;
                      _validate3_price = true;
                      _validate4_image = true;
                    });
                  }
                } else if (_image.path.toString() == "null") {
                  setState(() {
                    _validate1_prodDesc = true;
                    _validate2_barcode = true;
                    _validate3_price = true;
                    _validate4_image = false;
                  });
                } else {
                  setState(() {
                    _validate1_prodDesc = true;
                    _validate2_barcode = true;
                    _validate3_price = true;
                    _validate4_image = true;
                  });
                }

                print(ImagePath.toString());

                if (_managePrices == true) {
                  if (_validate1_prodDesc &&
                      _validate2_barcode &&
                      _validate3_price) {
                    print("all validate");

                    print(ListPrice.text);

                    //getImagefromStorage(_image.path.toString(),widget.id.toString());
                    imageCache.clear();

                    sublist_bloc.getProductID((widget.id + 1).toString());
                    sublist_bloc.getProductDesc(ProductDesc.text);
                    sublist_bloc.getGtin(gtin.text);
                    sublist_bloc.getListPrice(ListPrice.text);
                    sublist_bloc.getProductPhoto((widget.id + 1).toString() + ".png");
                    sublist_bloc.getBarcode_type("Code 128");
                    sublist_bloc.getBarcode_digits(gtin.text.length.toString());

                    print(gtin.text.length.toString());

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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasterData()));
                    }); //TODO:: DELAY EXAMPLE

                  } else {
                    print("Not validate");
                  }
                } else {
                  if (_validate1_prodDesc && _validate2_barcode) {
                    print("all validate");

                    sublist_bloc.getProductID((widget.id + 1).toString());
                    sublist_bloc.getProductDesc(ProductDesc.text);
                    sublist_bloc.getGtin(gtin.text);
                    sublist_bloc.getListPrice("0");
                    sublist_bloc.getProductPhoto((widget.id + 1).toString() + ".png");
                    sublist_bloc.getBarcode_type("Code 39");
                    sublist_bloc.getBarcode_digits(gtin.text.length.toString());

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

                    print("Data " +gtin.text.length.toString());


                    Timer(Duration(seconds: 3), () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MasterData()));
                    }); //TODO:: DELAY EXAMPLE

                  } else {
                    print("Not validate");
                  }
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
              child: Column(
                children: [
                  // Text('Scanner: ${scannerEnabled ? "Started" : "Stopped"}',
                  //   style: TextStyle(color: scannerEnabled ? Colors.blue : Colors.red),),
                  //
                  // Text('Scanner: ${scannerEnabled ? "Started" : "Stopped"}',
                  //   style: TextStyle(color: scannerEnabled ? Colors.blue : Colors.red),),
                  // Divider(
                  //   color: Colors.transparent,
                  // ),
                  // Text('Scanned code: $scannedCode'),
                  // Divider(
                  //   color: Colors.transparent,
                  // ),
                  //
                  // SwitchListTile(
                  //   title: Text("Scan 1D Codes"),
                  //   subtitle: Text("like Code-128, Code-39, Code-93, etc"),
                  //   value: scan1DFormats,
                  //   onChanged: (value) {
                  //     scan1DFormats = value;
                  //     updateScanProperties();
                  //     setState(() {});
                  //   },
                  // ),
                  // SwitchListTile(
                  //   title: Text("Scan 2D Codes"),
                  //   subtitle: Text("like QR, Data Matrix, Aztec, etc"),
                  //   value: scan2DFormats,
                  //   onChanged: (value) {
                  //     scan2DFormats = value;
                  //     updateScanProperties();
                  //     setState(() {});
                  //   },
                  // ),
                  //
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     RaisedButton(
                  //       onPressed: (){
                  //         honeywellScanner.startScanner();
                  //         setState(() {
                  //           scannerEnabled = true;
                  //         });
                  //       },
                  //       child: Text("Enable"),
                  //     ),
                  //
                  //     SizedBox(width: wp(10),),
                  //
                  //     RaisedButton(
                  //       onPressed: (){
                  //           honeywellScanner.stopScanner();
                  //           setState(() {
                  //             scannerEnabled = false;
                  //           });
                  //       },
                  //       child: Text("Disable"),
                  //     ),
                  //   ],
                  // ),

                  Stack(
                    children: <Widget>[
                      StreamBuilder<List<MasterDataModelV2>>(
                        stream: masterdata_bloc.allMasterDataV2,
                        builder: (context,
                            AsyncSnapshot<List<MasterDataModelV2>> snapshot) {
                          if (snapshot.hasData) {
                            fetcheddata = snapshot.data;
                            //_newData = fetcheddata;
                            print("From Add product page");
                            print(fetcheddata.length);
                            //return masterdataview(hp(100),wp(100),fetcheddata);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          return Center(child: Text(""));
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: hp(15), bottom: hp(1)),
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
                                margin: EdgeInsets.only(
                                    top: 0, left: 0, right: 0, bottom: hp(.5)),
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
                                      maxLength: maxLength,
                                      controller: ProductDesc,
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
                                      ),
                                      onChanged: (value) {
                                        if (value.length <= maxLength) {
                                          desc_text = value;
                                        } else {
                                          ProductDesc.value = new TextEditingValue(
                                              text: desc_text,
                                              composing: new TextRange(
                                                  start: 1, end: maxLength));
                                          ProductDesc.text = desc_text;
                                        }
                                      }),
                                ),
                              ),
                              _validate1_prodDesc == false
                                  ? Text(
                                      errortext1_prodDesc,
                                      style: TextStyle(
                                          fontSize: hp(1.5),
                                          color: Colors.red.shade500),
                                    )
                                  : Text(""),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: hp(2), bottom: hp(1)),
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
                                    top: 0, left: 0, right: 0, bottom: hp(.5)),
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

                                      keyboardType: TextInputType.text,
                                      controller: gtin,
                                      autofocus: true,
                                      focusNode: _focusNode,
                                      style: GoogleFonts.exo2(
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      decoration: new InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            isEditable == false
                                                ? MaterialIcons.touch_app
                                                : AntDesign.barcode,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            if (isEditable) {
                                              setState(() {
                                                //during qr mode
                                                isEditable = false;
                                                _focusNode.unfocus();
                                                honeywellScanner.startScanner();
                                              });
                                            } else {
                                              setState(() {
                                                //during keyboard mode
                                                isEditable = true;
                                                _focusNode.requestFocus();
                                                honeywellScanner.stopScanner();
                                              });
                                            }

                                            print(isEditable.toString());
                                          },
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
                              _validate2_barcode == false
                                  ? Text(
                                      errortext2_barcode,
                                      style: TextStyle(
                                          fontSize: hp(1.5),
                                          color: Colors.red.shade500),
                                    )
                                  : Text(""),
                            ],
                          ),
                        ),
                      ),
                      _managePrices
                          ? Padding(
                              padding: EdgeInsets.only(top: hp(28), bottom: hp(1)),
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
                                        padding: const EdgeInsets.only(
                                            left: 8.0, top: 3),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
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
                                          ),
                                          onChanged: (string) {
                                            string =
                                                '${_formatNumber(string.replaceAll(',', ''))}';
                                            ListPrice.text = string;
                                            Timer(Duration(milliseconds: 1), () {
                                              ListPrice.selection =
                                                  TextSelection.fromPosition(
                                                      TextPosition(
                                                          offset: string.length));
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    _validate3_price == false
                                        ? Text(
                                            errortext3_price,
                                            style: TextStyle(
                                                fontSize: hp(1.5),
                                                color: Colors.red.shade500),
                                          )
                                        : Text(""),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 0,
                              width: 0,
                            ),
                      _managePrices
                          ? Padding(
                              padding: EdgeInsets.only(top: hp(40), bottom: hp(1)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: hp(2)),
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
                                                onPressed: () {
                                                  setState(() {
                                                    showCapturedPhoto = false;
                                                  });
                                                  print("Camera OK??");
                                                  _imgFromCamera(context);

                                                },
                                                icon: Icon(Icons.camera_alt),
                                              ),
                                              SizedBox(
                                                width: wp(3),
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  setState(() {
                                                    showCapturedPhoto = false;
                                                  });
                                                  _imgFromGallery(context);
                                                },
                                                icon: Icon(Icons.attach_file),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    _validate4_image == false
                                        ? Text(
                                            errortext4_image,
                                            style: TextStyle(
                                                fontSize: hp(1.5),
                                                color: Colors.red.shade500),
                                          )
                                        : Text(""),
                                  ],
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.only(top: hp(28), bottom: hp(1)),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: hp(2)),
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
                                                onPressed: () {
                                                  // setState(() {
                                                  //   showCapturedPhoto = false;
                                                  // });
                                                  // _initializeCamera();
                                                  setState(() {
                                                    showCapturedPhoto = false;
                                                  });
                                                  print("Camera OK??");
                                                  _imgFromCamera(context);

                                                },
                                                icon: Icon(Icons.camera_alt),
                                              ),
                                              SizedBox(
                                                width: wp(3),
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  setState(() {
                                                    showCapturedPhoto = false;
                                                  });
                                                  _imgFromGallery(context);
                                                },
                                                icon: Icon(Icons.attach_file),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    _validate4_image == false
                                        ? Text(
                                            errortext4_image,
                                            style: TextStyle(
                                                fontSize: hp(1.5),
                                                color: Colors.red.shade500),
                                          )
                                        : Text(""),
                                  ],
                                ),
                              ),
                            ),

                      showCapturedPhoto == true
                              ? Padding(
                                  padding: _managePrices ? EdgeInsets.only(top: hp(52), bottom: hp(2)) : EdgeInsets.only(top: hp(35), bottom: hp(2)),
                                  child: Container(
                                    height: hp(50),
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: hp(5)),
                                          child: Align(
                                            child: Image.file(
                                              File(ImagePath),
                                              fit: BoxFit.fill,
                                              width: wp(80),
                                              height: hp(40),
                                            ),
                                            alignment: Alignment.topCenter,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: wp(85)),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: IconButton(
                                              onPressed: () {
                                                print(ImagePath.toString());
                                                setState(() {
                                                  showCapturedPhoto = null;
                                                  deleteFile(ImagePath.toString());
                                                  imageCache.clear();
                                                });
                                              },
                                              icon: Icon(
                                                AntDesign.closecircle,
                                                color: Colors.black87,
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
                    ],
                  ),
                ],
              ),
              color: Colors.transparent,
            ),
          ),
        )));
  }

  Future barcodeScanning1() async {
    try {
      barcode1 = await BarcodeScanner.scan();
      print(barcode1.rawContent.toString());
      print(barcode1.format.toString());
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
      print(barcode2.rawContent.toString());
      print(barcode2.format.toString());
      setState(() {
        this.barcode2 = barcode2;
        //gtin.text = barcode2.rawContent.toString();
      });
      onSearchedText(barcode2.rawContent.toString());
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

  void getImagefromStorage(String path, String fileName) async {
    print("path is " + path);
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].appFilesDir +"/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

    print(root.toString()+" && " + path.toString());

    moveFile(File(path), root + "/" + '${(widget.id + 1).toString()}.png');
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
      final newFile = sourceFile.copy(newPath);
      return newFile;
    }
  }

  void onSearchedText(String text) {
    print(text);

    _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail);
    });

    Timer(Duration(milliseconds: 500), () {
      middleCheck(widget.context, text);
    });
    //Get.snackbar("title", "message");

    // for(int i = 0; i< _newData.length; i++){
    //   print(_newData[i].gtin.toString());
    // }
  }

  void middleCheck(BuildContext context, String text) {
    if (_newData.isEmpty || text != _newData[0].gtin.toString()) {
      print("not got it");
      setState(() {
        gtin.text = text;
      });
      //print(_newData[0].gtin.toString());
      //print(fetcheddata[0].gtin.toString());
      //snack.snackbarshowNormal(context, "No product found!", 1, Colors.black87);

    } else if (_newData.isNotEmpty && text == _newData[0].gtin.toString()) {
      print("got it");
//      snack.snackbarshowNormal(context, "Product Exists!", 1, Colors.black87);
      SweetAlert.show(
        context,
        title: "Warning!",
        subtitle: "Barcode exist. Try new one",
        style: SweetAlertStyle.error,
      );

      //barcodeScanning2();

    }
  }

  final _locale = 'en';

  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  String _formatNumber(String string) {
    final format = NumberFormat.decimalPattern(_locale);
    return format.format(int.parse(string));
  }
}
