import 'dart:async';
import 'dart:io';

import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/PhotoDocumentationImageModel.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/Home.dart';
import 'package:app/Widgets/PhotoDocumentationComment.dart';
import 'package:app/Widgets/PhotoDocumentationSettings.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:path/path.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_screen/responsive_screen.dart';

class PhotoDocumentationDetailsPage extends StatefulWidget {
  String id;

  PhotoDocumentationDetailsPage({this.id});

  @override
  _PhotoDocumentationDetailsPageState createState() =>
      _PhotoDocumentationDetailsPageState();
}

class _PhotoDocumentationDetailsPageState
    extends State<PhotoDocumentationDetailsPage> {
  List<SingleMasterDataModelV2> fetcheddata = [];

  String barcode, description, id;

  int counter = 0;

  SnackbarHelper snack = new SnackbarHelper();

  List<String> images = [];

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

  bool status = true;

  Map<String, String> _images_file = Map();

  PhotoDocumentationImageModel images_data;

  void onCaptureButtonPressed() async {
    //on camera button press
    try {
      List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
      var root = storageInfo[0].rootDir +
          "/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory

      print(root.toString());
      var newcounter = counter;

      var file = File(root+"/"+id+"_"+newcounter.toString()+".png");

      if (file.exists() == null) {
        print("file not exist");
        //await file.delete();

        final path = join(
          (root.toString()),
          '${(id+"_"+newcounter.toString()).toString()}.png',
        );

        Timer(Duration(milliseconds: 200), () async {
          print("Got the timer");
          print(path.toString());

          setState(() {
            ImagePath = path;
          });


          _images_file[id.toString()+"_"+counter.toString()] = path;

          //print(_images_file.keys);

          await _controller.takePicture(path); //take photo

          _images_file.forEach((key, value) {
            print("values are "+value.toString());
          });

          setState(() {
            showCapturedPhoto = true;
            status = true;
            counter++;
            imageCache.clear();
          });
        });
      } else {
        print("file exist");
        await file.delete();

        final path = join(
          (root.toString()),
          '${(id+"_"+newcounter.toString()).toString()}.png',
        );

        Timer(Duration(milliseconds: 200), () async {
          print("Got the timer");
          print(path.toString());

          setState(() {
            ImagePath = path;
          });

          _images_file[id.toString()+"_"+counter.toString()] = path;

          //print(_images_file.keys);

          await _controller.takePicture(path); //take photo

          _images_file.forEach((key, value) {
            print("values are "+value.toString());
          });

          print(_images_file[id.toString()+"_"+counter.toString()]);

          setState(() {
            showCapturedPhoto = true;
            status = true;
            counter++;
            imageCache.clear();
          });
        });
      }
    } catch (e) {
      print(e);
    }
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
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;

    setState(() {
      _fileName = _path != null
          ? _path.split('/').last
          : _paths != null
              ? _paths.keys.toString()
              : '...';
    });
    print(_fileName.toString());
    print(_path.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // masterdata_bloc.getId(widget.id);
    masterdata_bloc.getsinglemasterdatafromDBV2();
    _images_file.clear();
    Timer(Duration(seconds: 1), () {
      getName();
    });
  }

  getName() {
    if (fetcheddata.isNotEmpty) {
      setState(() {
        barcode = fetcheddata[0].gtin.toString();
        description = fetcheddata[0].productDescription.toString();
        id = fetcheddata[0].id.toString();
      });
      print(barcode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Screen(context).hp;
    dynamic wp = Screen(context).wp;
    final orientation = MediaQuery.of(context).orientation;

    dynamic size = MediaQuery.of(context).size;
    dynamic deviceRatio = size.width / size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Photo Documentation",
          style: new TextStyle(color: Colors.black54),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 5.0,
        bottomOpacity: 10.00,
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhotoDocumetationSettings()));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("Next");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PhotoDocumentationCommentsPage()));
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Colors.green.shade500,
      ),

      body: SingleChildScrollView(
        child: Container(
          width: wp(100),
          child: Column(
            children: [
              StreamBuilder<List<SingleMasterDataModelV2>>(
                stream: masterdata_bloc.singleMasterDatav2,
                builder: (context,
                    AsyncSnapshot<List<SingleMasterDataModelV2>> snapshot) {
                  if (snapshot.hasData) {
                    fetcheddata = snapshot.data;
                    //_newData = fetcheddata;
                    print("From photo documentation page");
                    print(fetcheddata.length);
                    //return masterdataview(hp(100),wp(100),fetcheddata);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return Center(child: Text(""));
                },
              ),

              fetcheddata.isNotEmpty && status == true
                  ? Padding(
                      padding: EdgeInsets.only(left: wp(10), top: hp(2)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Barcode",
                                style: TextStyle(
                                  fontSize: hp(2),
                                ),
                              ),
                              SizedBox(
                                width: wp(14),
                              ),
                              Text(
                                barcode.toString(),
                                style: TextStyle(
                                  fontSize: hp(2),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: hp(2),
                          ),
                          Row(
                            children: [
                              Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: hp(2),
                                ),
                              ),
                              SizedBox(
                                width: wp(10),
                              ),
                              Text(
                                description.toString(),
                                style: TextStyle(
                                  fontSize: hp(2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : fetcheddata.isEmpty
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(0, hp(40), 0, 0),
                          child: Text("No Data"))
                      : Container(
                          width: 0,
                          height: 0,
                        ),

              status == true
                  ? SizedBox(
                      height: hp(1),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              status == true
                  ? Divider()
                  : Container(
                      width: 0,
                      height: 0,
                    ),
              status == true
                  ? SizedBox(
                      height: hp(1),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),

              status == true
                  ? Builder(
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(left: wp(10), top: hp(2)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add photos",
                              style: TextStyle(fontSize: hp(2)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: wp(10)),
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      onPressed: () {
                                        // setState(() {
                                        //   if(counter > 0 ){
                                        //     counter--;
                                        //   }
                                        // });

                                        setState(() {
                                          if (counter < 3) {
                                            //counter++;
                                            setState(() {
                                              showCapturedPhoto = false;
                                              status = false;
                                            });
                                            _initializeCamera();
                                          } else {
                                            snack.snackbarshowNormal(
                                                context,
                                                "More than 3 is selected!",
                                                3,
                                                Colors.black87);
                                            print("More than 3 is selected");
                                          }
                                        });
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.attach_file),
                                      onPressed: () {
                                        setState(() {
                                          if (counter < 3) {
                                            //counter++;
                                            _openFileExplorer();
                                          } else {
                                            snack.snackbarshowNormal(
                                                context,
                                                "More than 3 is selected!",
                                                3,
                                                Colors.black87);
                                            print("More than 3 is selected");
                                          }
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),

              //counter > 0 ? Text(counter.toString()): Text("No Data"),

              status == true
                  ? SizedBox(
                      height: hp(2),
                    )
                  : SizedBox(
                      height: hp(0),
                    ),

              showCapturedPhoto == false
                  ? Padding(
                      padding: EdgeInsets.only(top: hp(1), bottom: hp(2)),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FutureBuilder<void>(
                          future: _initializeControllerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // If the Future is complete, display the preview.
                              return Transform.scale(
                                  scale: _controller.value.aspectRatio /
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
                                        alignment: Alignment.topCenter,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: hp(70),
                                            bottom: hp(2),
                                            right: wp(7)),
                                        child: Align(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.camera,
                                              color: Colors.white,
                                              size: hp(7),
                                            ),
                                            onPressed: () {
                                              onCaptureButtonPressed();
                                              print("Captured");
                                            },
                                          ),
                                          alignment: Alignment.topCenter,
                                        ),
                                      ),
                                      status == false
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                  top: hp(3),
                                                  bottom: hp(2),
                                                  right: wp(10)),
                                              child: Align(
                                                child: IconButton(
                                                  icon: Icon(
                                                    AntDesign.closecircle,
                                                    color: Colors.red,
                                                    size: hp(3),
                                                  ),
                                                  onPressed: () {
                                                    _controller.dispose();
                                                    setState(() {
                                                      status = true;
                                                      showCapturedPhoto = true;
                                                    });
                                                  },
                                                ),
                                                alignment:
                                                    Alignment.centerRight,
                                              ),
                                            )
                                          : Container(
                                              height: 0,
                                              width: 0,

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
                  //   : showCapturedPhoto == true ?  Padding(
                  // padding: EdgeInsets.only(top: hp(52), bottom: hp(2)),
                  // child: Container(
                  //   height: hp(50),
                  //   width: double.infinity,
                  //   color: Colors.transparent,
                  //   child: Stack(
                  //     children: <Widget>[
                  //       Padding(
                  //         padding: EdgeInsets.only(top: hp(5)),
                  //         child: Align(
                  //           child: Image.file(File(ImagePath),fit: BoxFit.fill,width: wp(80),height: hp(40),),
                  //           alignment: Alignment.topCenter,
                  //         ),
                  //       ),
                  : counter == 0 && showCapturedPhoto == false
                      ? Text("Nothing selected")
                      : GridView.builder(
                          padding: EdgeInsets.all(wp(5)),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 2
                                          : 3),
                          itemCount: _images_file.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            print('map length:${_images_file.length}');
                            print (index.toString());
                            print('map id and index:${_images_file[id.toString()+"_"+index.toString()]}<><><><>');


                            return Container(
                            margin: EdgeInsets.all(wp(1)),
                            height: hp(2),
                            width: wp(2),
                            color: Colors.transparent,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Image.file(File(_images_file[id.toString()+"_"+index.toString()]),fit: BoxFit.fill,width: wp(80),height: hp(40),),
                                ),
                                Align(
                                  child: IconButton(
                                    icon: Icon(AntDesign.closecircle,color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        //counter--;
                                        print(id.toString()+"_"+index.toString());
                                        print(_images_file.length.toString());
                                      });
                                    },
                                  ),
                                  alignment: Alignment.topRight,
                                ),
                              ],
                            ),
                          );}
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
