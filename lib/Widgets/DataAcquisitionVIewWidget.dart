import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:grizzly_io/io_loader.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_screen/responsive_screen.dart';

class DataAcquisitionViewWidget extends StatefulWidget {

  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  DataAcquisitionViewWidget({this.height, this.width, this.scaffoldKey});

  @override
  _DataAcquisitionViewWidgetState createState() => _DataAcquisitionViewWidgetState();
}

class _DataAcquisitionViewWidgetState extends State<DataAcquisitionViewWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCSV();
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(hp(0), hp(0), hp(0), hp(0)),
                height: hp(16),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(hp(3), hp(4), hp(3), hp(2)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: wp(3),),
                              Text("File Name", style: TextStyle(
                                fontSize: hp(2),
                              ),),
                              SizedBox(width: wp(15),),
                              Text(".csv", style: TextStyle(
                                  fontSize: hp(2),
                                  color: Colors.green.shade500
                              ),),
                            ],
                          ),

                          SizedBox(height: hp(3),),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: wp(3),),
                              Text("20 Values", style: TextStyle(
                                fontSize: hp(2),
                              ),),
                              SizedBox(width: wp(15),),
                              Text("30.10.2020", style: TextStyle(
                                fontSize: hp(2),
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: hp(1),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: hp(76),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: hp(1), left: hp(2.3)),
                      child: Text("List", style: TextStyle(
                          fontSize: hp(2)
                      ),),
                    ),
                    SizedBox(
                      height: hp(2),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: hp(.5)),
                      child: Card(
                        child: ListTile(
                          title: Text("asas"),
                          subtitle: Text("asas"),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: hp(.5)),
                      child: Card(
                        child: ListTile(
                          title: Text("asas"),
                          subtitle: Text("asas"),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: hp(.5)),
                      child: Card(
                        child: ListTile(
                          title: Text("asas"),
                          subtitle: Text("asas"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void readCSV() async {
    //
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir +
        "/Indentit"; //storageInfo[1] for SD card, getting the root directory

    print(root.toString());

    var filePath = root + "/new2.csv"; // or users.xls|xlsx
    //   int offsetLine = 0;
    //   int limitLine = 10;
    //   var list = await Fxpoi.readExcelCSVByPage(
    //       filePath, offsetLine, limitLine);
    //   for (int i = 0; i <= list.length; i++) {
    //     //var item = list[i];
    //     debugPrint("item:$i ${list[i]} \n");
    //     //debugPrint("item1: ${item[0]} \n");
    //     //debugPrint("item2: ${item[1]} \n");
    //   }
  }
}
