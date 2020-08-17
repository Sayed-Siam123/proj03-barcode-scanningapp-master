import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/UI/MasterData.dart';
import 'package:app/UI/ProductDetails.dart';
import 'package:app/UI/ProductEditPage.dart';
import 'package:app/UI/ProductGeneral.dart';
import 'package:app/UI/ProductPackaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home.dart';

class DetailsPage extends StatefulWidget {

  String product_name;

  DetailsPage({this.product_name});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  //TODO:: eikhane Product Details ashbe

  TabController _tabController;

  @override
  void initState() {
    //masterdata_bloc.getsinglemasterdata();
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    sublist_bloc.dispose();
    masterdata_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => MasterData()));
      },
      child: new Scaffold(
        appBar: AppBar(
          title: Text(
            widget.product_name,
            style: GoogleFonts.exo2(
              color: Colors.black,
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
                  Icons.edit,
                  color: Colors.black54,
                ),
                onPressed: () {
                  print("Edit");
                  masterdata_bloc.getsinglemasterdata();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductEditPage(
                                productname: "Paisi",
                              )));
                }),
          ],
        ),

        body: TabBarView(

          children: [
            new ProductGeneralPage(),
            new ProductDetailsPage(),
            new ProductPackagingPage(),
          ],
          controller: _tabController,
        ),
//      body: Container(
//        margin: EdgeInsets.all(10),
//        child: StreamBuilder<List<SingleMasterDataModel>>(
//          stream: masterdata_bloc.singleMasterData,
//          builder: (context, AsyncSnapshot<List<SingleMasterDataModel>> snapshot) {
//            if (snapshot.hasData) {
//              List<SingleMasterDataModel> data = snapshot.data;
//              print("Data gula:: ");
//              print(data.length);
//              return masterdataview(data);
//
//            } else if (snapshot.hasError) {
//              return Text("${snapshot.error}");
//            }
//
//            return CircularProgressIndicator();
//          },
//        ),
//      ),

        bottomNavigationBar: Container(
          color: Theme.of(context).backgroundColor,
          margin: EdgeInsets.only(bottom: 3),
          child: TabBar(
            indicatorWeight: 4,
            labelStyle: GoogleFonts.exo2(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
            unselectedLabelColor: Colors.black45,
            labelColor: Colors.black,
            tabs: [
              new Tab(text: "General"),
              new Tab(text: "Details"),
              new Tab(text: "Packaging")
            ],
            controller: _tabController,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
    );
//    return PersistentTabView(
//      controller: _controller,
//      items: _navBarsItems(),
//      screens: _buildScreens(),
//      showElevation: true,
//      navBarCurve: NavBarCurve.upperCorners,
//      confineInSafeArea: true,
//      handleAndroidBackButtonPress: true,
//      iconSize: 26.0,
//      navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property
//      onItemSelected: (index) {
//        print(index);
//      },
//    );

//    return PersistentTabView(
//        controller: _controller,
//        items: _navBarsItems(),
//        showElevation: true,
//        navBarCurve: NavBarCurve.upperCorners,
//        confineInSafeArea: true,
//        handleAndroidBackButtonPress: true,
//        iconSize: 26.0,
//        navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property
//        onItemSelected: (index) {
//          print(index);
//        }, screens: <Widget>[
//          ProductDetailsPage(),
//          ProductDetailsPage(),
//          ProductDetailsPage(),
//          ProductDetailsPage(),
//      ],
//      );
  }

//  ListView masterdataview(data) {
//    return ListView.builder(
//        scrollDirection: Axis.horizontal,
//        itemCount: data.length,
//        itemBuilder: (BuildContext context, int index) {
////          return Column(
////            children: <Widget>[
////              Text(data[index].categoryName),
////              SizedBox(height: 6,)
////
////            ],
////          );
//            return TabBarView(
//              children: <Widget>[
//                new ProductGeneralPage(),
//                new ProductDetailsPage(),
//                new ProductPackagingPage(),
//
//              ],
//              controller: _tabController,
//            );
//
//
//
//        });
//  }
}
