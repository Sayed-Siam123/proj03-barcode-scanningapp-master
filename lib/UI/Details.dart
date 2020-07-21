import 'package:app/Bloc/Sublist_bloc.dart';
import 'package:app/Bloc/masterData_bloc.dart';
import 'package:app/Model/RouteArgument.dart';
import 'package:app/Model/masterdata_model.dart';
import 'package:app/UI/Home.dart';
import 'package:app/UI/ProductDetails.dart';
import 'package:app/UI/ProductEditPage.dart';
import 'package:app/UI/ProductGeneral.dart';
import 'package:app/UI/ProductPackaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class DetailsPage extends StatefulWidget {

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

//  void dispose() {
//    // TODO: implement dispose
//    masterdata_bloc.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Luna Rosato 2019", style: new TextStyle(color: Colors.black54),),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 00.00,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black54,),
          onPressed: () => Navigator.of(context).pushNamed('/home'),
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.edit, color: Colors.black54,),
            onPressed: () {
              print("Edit");
              masterdata_bloc.getsinglemasterdata();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductEditPage(productname: "Paisi",)));
            }
          ),
        ],
      ),

      body: TabBarView(
              children: [
                new ProductGeneralPage(),
                new ProductDetailsPage(),
                new ProductPackagingPage(),
              ],
              controller: _tabController,),
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
        margin: EdgeInsets.only(bottom: 3),
        child: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor: Colors.black45,
          labelColor: Colors.black,
          tabs: [
            new Tab(text: "General"),
            new Tab(
                text: "Details"
            ),
            new Tab(
                text: "Packaging"
            )
          ],
          controller: _tabController,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,),
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
