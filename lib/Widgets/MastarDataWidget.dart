import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/UI/Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MasterDataWidget extends StatelessWidget {
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
      productPicture;

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
      this.sub_category});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 6,right: 6,top: 1),
      child: Card(
        child: ListTile(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DetailsPage(product_name: this.product_name.toString(),)));
            masterdata_bloc.getId(this.product_id.toString());
            masterdata_bloc.getsinglemasterdata();
          },
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: CircleAvatar(
              //backgroundImage: AssetImage('assets/images/Cart.png'),
              backgroundImage: NetworkImage(
                'http://202.164.212.238:8054'+this.productPicture.toString(),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
          title: Text(
            this.product_name.toString(),
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
                "Category: " + this.category.toString(),
                style: GoogleFonts.exo2(),),
              SizedBox(
                height: 5,
              ),
              Text("ProductID: " + this.product_id.toString(),
                style: GoogleFonts.exo2(),),
              SizedBox(
                height: 5,
              ),
              Text("GTIN: " + this.gtin.toString(),
                style: GoogleFonts.exo2(),),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/details');
              masterdata_bloc.getId(this.product_id.toString());
              masterdata_bloc.getsinglemasterdata();
              //TODO:: eikhane
            },
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
