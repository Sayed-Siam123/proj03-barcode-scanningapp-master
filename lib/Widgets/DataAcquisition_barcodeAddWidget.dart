import 'dart:async';
import 'dart:io';
import 'package:app/Bloc/DataAcquisition_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/DataAcquisition_model.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_screen/responsive_screen.dart';

class DataAcquisition_barcodeAddWidget extends StatefulWidget {
  dynamic height;
  dynamic width;
  String file_name;
  String file_format;
  bool status;
  GlobalKey<ScaffoldState> scaffoldKey;

  DataAcquisition_barcodeAddWidget(
      {this.height, this.width, this.scaffoldKey, this.file_name, this.status,this.file_format});

  @override
  _DataAcquisition_barcodeAddWidgetState createState() =>
      _DataAcquisition_barcodeAddWidgetState();
}

class _DataAcquisition_barcodeAddWidgetState
    extends State<DataAcquisition_barcodeAddWidget> {
  ScanResult barcode2;

  final gtin = new TextEditingController();
  bool listShowstatus = false;
  bool listStream = true;
  bool listStream2 = false;

  List<MasterDataModelV2> fetcheddata = [];
  List<MasterDataModelV2> _newData = [];
  List<MasterDataModelV2> _newData2 = [];

  List<DataAcquisition_model> acquiData = [];
  List<DataAcquisition_model> acquiData2 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    masterdata_bloc.fetchAllMasterdatafromDBV2();
    data_acquisition_bloc.fetchAllDataAcquisition();
    data_acquisition_bloc.fetchSingleDataAcquisition();

    setState(() {
      listStream2 = true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    data_acquisition_bloc.dispose();
    masterdata_bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          StreamBuilder<List<MasterDataModelV2>>(
            stream: masterdata_bloc.allMasterDataV2,
            builder:
                (context, AsyncSnapshot<List<MasterDataModelV2>> snapshot) {
              if (snapshot.hasData) {
                fetcheddata = snapshot.data;
                //_newData = fetcheddata;
                print("From barcode comparison page");
                print(fetcheddata.length);
                //return masterdataview(hp(100),wp(100),fetcheddata);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(child: Text(""));
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: wp(0), top: hp(2), bottom: wp(1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "File Name",
                              style: TextStyle(
                                fontSize: hp(2.5),
                              ),
                            ),
                            SizedBox(
                              width: wp(5),
                            ),
                            Text(
                              widget.file_name.toString(),
                              style: TextStyle(
                                  fontSize: hp(2.5),
                                  color: Colors.green.shade500),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: wp(7),
                        ),
                        Container(
                          height: hp(6),
                          width: hp(6),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300.withOpacity(0.4),
                                  blurRadius: 5,
                                  spreadRadius: 5,
                                )
                              ]),
                          child: Center(
                            child: Text(
                              "0",
                              style: TextStyle(
                                fontSize: hp(2.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: wp(3), top: hp(4)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Scan Barcode",
                          style: TextStyle(
                            fontSize: hp(2),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.fromLTRB(wp(0), hp(1), wp(0), hp(1)),
                          padding: EdgeInsets.fromLTRB(wp(3), hp(0), wp(1), 0),
                          width: wp(90),
                          height: hp(6.5),
                          alignment: Alignment.center,
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
                            padding: EdgeInsets.only(left: 0.0, top: hp(0)),
                            child: TextField(
                                autocorrect: true,
                                style: GoogleFonts.exo2(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                controller: gtin,
                                onChanged: (String text) =>
                                    onChangeMastercode(text),
                                decoration: new InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 0.0, top: hp(2.2)),
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
                                  hintText: "Enter or Scan barcode",
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.keyboard),
                                    tooltip: 'Enter barcode',
                                    onPressed: (){},
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hp(.7),
                  ),
                  Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: wp(3), top: hp(1)),
                        child: Text(
                          "Last Scanned Item",
                          style: TextStyle(
                            fontSize: hp(2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: hp(1),
                      ),
                      listStream2 == true
                          ? StreamBuilder<List<DataAcquisition_model>>(
                              stream:
                                  data_acquisition_bloc.singledataacquisition,
                              builder: (context,
                                  AsyncSnapshot<List<DataAcquisition_model>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  acquiData2 = snapshot.data;
                                  //_newData = fetcheddata;
                                  print("Data eikhane koyta dekho to:: ");

                                  print(acquiData2.length);

                                  return acquiData2.length > 0 ?Slidable(
                                    actionPane: SlidableBehindActionPane(),
                                    secondaryActions: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: hp(1), right: wp(1), left: wp(1), bottom: hp(1)),
                                        child: IconSlideAction(
                                          caption: 'Delete',
                                          color: Colors.red,
                                          icon: Icons.delete,
                                          onTap: () {
                                            // SnackbarHelper snackbar = new SnackbarHelper();
                                            //
                                            // snackbar.snackbarshowNormal(context, "Deleted Successfully", 4, Colors.black87);

                                            Timer(Duration(seconds: 1),(){
                                              setState(() {
                                                 data_acquisition_bloc.deleteLastDataAcqui(acquiData2[0].id);
                                                 data_acquisition_bloc.fetchAllDataAcquisition();
                                                 data_acquisition_bloc.fetchSingleDataAcquisition();
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                    child: Container(
                                      height: hp(10),
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: acquiData2.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: ListTile(
                                              title: Text(acquiData2[index]
                                                  .description
                                                  .toString()),
                                              subtitle: Text(acquiData2[index]
                                                  .barcode
                                                  .toString()),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ): SizedBox(
                                      height: hp(6),
                                      child: Center(child: Text("No Data")));

                                  //return masterdataview(_fetcheddata, context);
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }

                                return Center(child: Text(""));
                                //return masterdataview(_fetcheddata); //it should be changed
                              },
                            )
                          : Text(""),
                    ],
                  ),
                  SizedBox(
                    height: hp(.8),
                  ),
                  Divider(),
                  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: wp(3), top: hp(1)),
                              child: Text(
                                "Item List",
                                style: TextStyle(
                                  fontSize: hp(2),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: hp(1),
                            ),

                            listStream == true
                                ? StreamBuilder<List<DataAcquisition_model>>(
                                    stream: data_acquisition_bloc
                                        .alldataacquisition,
                                    builder: (context,
                                        AsyncSnapshot<
                                                List<DataAcquisition_model>>
                                            snapshot) {
                                      if (snapshot.hasData) {
                                        acquiData = snapshot.data;
                                        //_newData = fetcheddata;
                                        print("Data:: ");

                                        print(acquiData.length);

                                        return acquiData.length > 0 ? Container(
                                          height: hp(43),
                                          child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount: acquiData.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                child: ListTile(
                                                  title: Text(acquiData[index]
                                                      .description
                                                      .toString()),
                                                  subtitle: Text(
                                                      acquiData[index]
                                                          .barcode
                                                          .toString()),
                                                ),
                                              );
                                            },
                                          ),
                                        ): SizedBox(
                                            height: hp(20),
                                            child: Center(child: Text("No Data"))
                                        );

                                        //return masterdataview(_fetcheddata, context);
                                      } else if (snapshot.hasError) {
                                        return Text("${snapshot.error}");
                                      }

                                      return Center(child: Text(""));
                                      //return masterdataview(_fetcheddata); //it should be changed
                                    },
                                  )
                                : Text(""),

                            // ListView.builder(
                            //           shrinkWrap: true,
                            //           itemCount: _newData.length,
                            //           itemBuilder:(context, index) => Padding(
                            //             padding: EdgeInsets.fromLTRB(wp(2),0,wp(2),0),
                            //             child: Card(
                            //               child: ListTile(
                            //                 title: Text(_newData[index].productDescription.toString() == "" ? "" : _newData[index].productDescription.toString()),
                            //                 subtitle: Text(_newData[index].gtin.toString() == "" ? "" :_newData[index].gtin.toString()),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: hp(80), left: wp(80)),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  // if (listShowstatus == false) {
                  //   setState(() {
                  //     listShowstatus = true;
                  //     listStream = true;
                  //   });
                  //   data_acquisition_bloc.fetchSingleDataAcquisition();
                  //   data_acquisition_bloc.fetchAllDataAcquisition();
                  // } else {
                  //   setState(() {
                  //     listShowstatus = false;
                  //     listStream = false;
                  //   });
                  // }
                },
                child: Icon(Icons.description, color: Colors.white),
                backgroundColor: Colors.green.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future barcodeScanning2() async {
    setState(() {
      listStream = false;
      listStream2 = false;
    });

    try {
      barcode2 = await BarcodeScanner.scan();
      setState(() {
        this.barcode2 = barcode2;
        gtin.text = barcode2.rawContent.toString();
      });
      onChangeMastercode(barcode2.rawContent.toString());
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

  void onChangeMastercode(String text) {
    print(text);
    // setState(() {
    //   mastercode = text.toString();
    // });
    setState(() {
      listStream = false;
      listStream2 = false;
    });

    _newData.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    fetcheddata.forEach((userDetail) {
      if (userDetail.gtin.toLowerCase().contains(text.toLowerCase()))
        _newData.add(userDetail); //here will data store to db and reload to fetch all acquisition list data
    });

    Timer(Duration(milliseconds: 500), () {
//      print("Saved gtin: "+ _newData[0].gtin.toString());

      DataAcquisition_model data = DataAcquisition_model(
        barcode: _newData.isEmpty ? null : _newData[0].gtin.toString(),
        description:
            _newData.isEmpty ? null : _newData[0].productDescription.toString(),
        quantity: 1,
        newFlag: "true",
        updateFlag: "false",
      );

      pushtoDB(_newData.isEmpty ? null : data);
    });
  }

  void pushtoDB(DataAcquisition_model data) {
    if (_newData.isEmpty) {
      setState(() {
        listStream = true;
        listStream2 = true;
      });
      print("Data is empty");
      SnackbarHelper snack = new SnackbarHelper();
      snack.snackbarshowNormal(context, "No product found", 4, Colors.black87);
      data_acquisition_bloc.fetchAllDataAcquisition();
      data_acquisition_bloc.fetchSingleDataAcquisition();
    } else {
      print("Data found");
      setState(() {
        listStream = true;
        listStream2 = true;
      });
      //save to DB here
      SnackbarHelper snack = new SnackbarHelper();
      snack.snackbarshowNormal(
          context, "Product added successfully", 4, Colors.black87);
      data_acquisition_bloc.InsertDataAcquisitionData(data);
      data_acquisition_bloc.fetchAllDataAcquisition();
      data_acquisition_bloc.fetchSingleDataAcquisition();
      writetoCSVtxt();
    }
  }

  void writetoCSVtxt() async{
    print("Total length"+acquiData.length.toString());

    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir+"/Indentit/"+widget.file_name.toString()+"."+widget.file_format.toString(); //storageInfo[1] for SD card, getting the root directory

    print(root.toString());

    final file = await File(root.toString());

    // List<List<dynamic>> rows2 = List<List<dynamic>>();
    //   List<dynamic> row2 = List();
    //   row2.add("Description");
    //   row2.add("Barcode");
    //   row2.add("Quantity");
    //   rows2.add(row2);
    //
    // String title = const ListToCsvConverter().convert(rows2);
    //
    // file.writeAsString(title+"\n");

    List<List<dynamic>> rows = List<List<dynamic>>();
    for (int i = 0; i <acquiData.length;i++) {

//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List();
      row.add(acquiData[i].description);
      row.add(acquiData[i].barcode);
      row.add(acquiData[i].quantity);
      rows.add(row);
    }

    if(file.exists() != null){
      print("File exist");

      String csv = const ListToCsvConverter().convert(rows);

      file.writeAsStringSync(csv+"\n",mode: FileMode.writeOnlyAppend);

    }

    else{
      print("File not exist");
    }

//     await SimplePermissions.requestPermission(Permission. WriteExternalStorage);
//     bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
//     if(checkPermission) {
//
// //store file in documents folder
//
//       String dir = (await getExternalStorageDirectory()).absolute.path + "/documents";
//     file = "$dir";
//     print(LOGTAG+" FILE " + file);
//     File f = new File(file+"filename.csv");
//
// // convert rows to String and write as csv file
//
//     String csv = const ListToCsvConverter().convert(rows);
//     f.writeAsString(csv);
//  }



  }

}
