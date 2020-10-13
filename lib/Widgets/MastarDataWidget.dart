import 'dart:async';
import 'dart:io';

import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/UI/BarcodeInfoDetails.dart';
import 'package:app/UI/Details.dart';
import 'package:app/UI/ProductEditPage.dart';
import 'package:app/resources/SnackbarHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider_ex/path_provider_ex.dart';
import 'package:responsive_screen/responsive_screen.dart';

class MasterDataWidget extends StatefulWidget {
  String product_name,
      product_desc,
      category,
      sub_category,
      product_id,
      unit,
      manufac,
      manufacpin,
      gtin,
      listprice,
      productPicture,
      show_price,newFlag,updateFlag;
  dynamic height;
  dynamic width;
  GlobalKey<ScaffoldState> scaffoldKey;

  MasterDataWidget(
      {this.product_name,
      this.product_id,
      this.category,
      this.productPicture,
      this.gtin,
      this.unit,
      this.listprice,
      this.manufac,
      this.manufacpin,
      this.product_desc,
      this.sub_category,this.height,this.width,this.scaffoldKey,this.show_price,this.newFlag,this.updateFlag});

  @override
  _MasterDataWidgetState createState() => _MasterDataWidgetState();
}

class _MasterDataWidgetState extends State<MasterDataWidget> {

  var root;

  void source() async{
    Timer(Duration(microseconds: 50),() async{
      List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();

      setState(() {
        root = storageInfo[0].rootDir+"/Indentit/Photos"; //storageInfo[1] for SD card, getting the root directory
      });
      print(root.toString());
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    source();
  }

  @override
  Widget build(BuildContext context) {
    dynamic hp = Hp(widget.height).hp;
    dynamic wp = Wp(widget.width).wp;
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: wp(.07),
      closeOnScroll: true,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: hp(1), right: wp(1), left: wp(1), bottom: hp(1)),
          child: IconSlideAction(
            caption: 'Edit',
            color: Colors.blue,
            icon: Icons.edit,
            onTap: () {
              masterdata_bloc.getId(this.widget.product_id.toString());
              masterdata_bloc.getsinglemasterdatafromDBV2();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductEditPage(
                        productname: "Paisi",
                      )));
              //print(this.widget.product_id.toString());
            },
          ),
        ),
      ],
      secondaryActions: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: hp(1), right: wp(1), left: wp(1), bottom: hp(1)),
          child: IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              sublist_bloc.DeleteProductMasterDatatoDBV2(int.parse(this.widget.product_id.toString()));
              sublist_bloc.dispose();

              SnackbarHelper snackbar = new SnackbarHelper();

              snackbar.snackbarshowNormal(context, "Deleted Successfully", 4, Colors.black87);

              Timer(Duration(seconds: 1),(){
                setState(() {
                  masterdata_bloc.fetchAllMasterdatafromDBV2();
                });
              });
            },
          ),
        ),
      ],
      child: Container(
        margin: EdgeInsets.only(left: 6, right: 6, top: 1),
        child: Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BarcodeInfoDetailsPage(newFlag: widget.newFlag.toString())));
              masterdata_bloc.getId(this.widget.product_id.toString());
              masterdata_bloc.getsinglemasterdatafromDBV2();
            },
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: widget.newFlag == "false" ? CircleAvatar(
                //backgroundImage: AssetImage('assets/images/Cart.png'),
                backgroundImage: NetworkImage(
                  'http://202.164.212.238:8054' +
                      this.widget.productPicture.toString(),
                ),
                backgroundColor: Colors.transparent,
              ) : Image.file(File(root.toString()+"/"+widget.productPicture.toString()),
                height: hp(10),width: wp(90),fit: BoxFit.fill,),
            ),
            title: Text(
              this.widget.product_desc.toString(),
              style: GoogleFonts.exo2(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Barcode: " + this.widget.gtin.toString(),
                  style: GoogleFonts.exo2(),
                ),
                SizedBox(
                  height: 5,
                ),
                this.widget.show_price == "true"? Text(
                  "Price: " + this.widget.listprice.toString(),
                  style: GoogleFonts.exo2(),
                ): Text(""),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
