import 'dart:async';
import 'dart:io';

import 'package:app/Bloc/DataAcquisition_bloc.dart';
import 'package:app/UI/DataAcquitisionView.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fxpoi/fxpoi.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_screen/responsive_screen.dart';

class DataAcquisitionWidget extends StatefulWidget {
  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  DataAcquisitionWidget({this.height, this.width, this.scaffoldKey});

  @override
  _DataAcquisitionWidgetState createState() => _DataAcquisitionWidgetState();
}

class _DataAcquisitionWidgetState extends State<DataAcquisitionWidget> {

  var files, rowCount;
  List<int> count = [];

  SnackbarHelper snackbar = new SnackbarHelper();


  Future<void> deleteFile(String file_name) async {

    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir +
        "/Indentit"; //storageInfo[1] for SD card, getting the root directory

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

  void getFiles() async {
    //asyn function to get list of files
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir +
        "/Indentit"; //storageInfo[1] for SD card, getting the root directory
    var fm = FileManager(root: Directory(root)); //
    files = await fm.filesTree(
        excludedPaths: ["/storage/emulated/0/Android"],
        extensions: [
          "csv",
          "txt"
        ] //optional, to filter files, list only csv text files
    );

    print(files.toString());
    for (int i = 0; i < files.length; i++) {
      rowCount = await Fxpoi.getRowCount(files[i].path.toString());
      count.add(rowCount);
    }
    setState(() {
      for (int i = 0; i < files.length; i++) {
        print(count[i].toString());
      }
    }); //update the UI
  }

  @override
  void initState() {
    print("asas");
    super.initState();
    data_acquisition_bloc.deleteFullDataAcquiTable();
    Timer(Duration(microseconds: 50), () {
      getFiles(); //call getFiles() function on initial state.
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top:hp(3)),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: files == null ? Text("Searching Files") :
                          ListView.separated(
                            separatorBuilder: (context, index) => Divider(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: files?.length ?? 0,
                            itemBuilder: (context, index) =>
                                Slidable(
                                  actionPane: SlidableBehindActionPane(),
                                  actionExtentRatio: wp(.07),
                                  closeOnScroll: true,
                                  // actions: <Widget>[
                                  //   Padding(
                                  //     padding: EdgeInsets.only(top: hp(0), right: wp(0), left: wp(0), bottom: hp(.5)),
                                  //     child: IconSlideAction(
                                  //       caption: 'Edit',
                                  //       color: Colors.blue,
                                  //       icon: Icons.edit,
                                  //       onTap: () {
                                  //
                                  //       },
                                  //     ),
                                  //   ),
                                  // ],
                                  secondaryActions: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: hp(0), right: wp(0), left: wp(0), bottom: hp(.5)),
                                      child: IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {
                                          deleteFile(files[index].path.toString());
                                          snackbar.snackbarshowNormal(context, files[index].path.split('/').last.toString()+" deleted", 4, Colors.black87);
                                            //print(files[index].path.toString());
                                          Timer(Duration(seconds: 1),(){
                                            getFiles();
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                  child: ListTile(
                                    onTap: () {
                                      print(files[index].path
                                          .split('/')
                                          .last
                                          .toString());

                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => DataAcquisitionViewPage()));

                                    },
                                    contentPadding: EdgeInsets.only(left: wp(5)),
                                    title: Text(files[index].path
                                        .split('/')
                                        .last
                                        .toString()),
                                    subtitle: Text(
                                        count[index].toString() + " values"),
                                    leading: Container(
                                      height: hp(5.5),
                                      width: hp(5.5),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(wp(2))),
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
