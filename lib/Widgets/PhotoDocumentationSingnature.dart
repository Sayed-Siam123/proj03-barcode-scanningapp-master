import 'package:app/UI/Home.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:signature/signature.dart';

import 'PhotoDocumentationComment.dart';
import 'PhotoDocumentationSettings.dart';

class PhotoDocumentationSingnature extends StatefulWidget {
  @override
  _PhotoDocumentationSingnatureState createState() =>
      _PhotoDocumentationSingnatureState();
}

class _PhotoDocumentationSingnatureState extends State<PhotoDocumentationSingnature> {

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
    imageCache.clear();
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
                context,
                MaterialPageRoute(
                    builder: (context) => PhotoDocumentationCommentsPage()));
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(hp(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Signature",style: TextStyle(
                fontSize: hp(2),
              ),),
              SizedBox(height: hp(1),),
              Container(
                padding: EdgeInsets.all(hp(1)),
                decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                ),
                child: Signature(
                  controller: _controller,
                  height: hp(30),
                  backgroundColor: Colors.white,
                ),
              ),
              //OK AND CLEAR BUTTONS
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                    InkWell(
                      onTap: () async{
                        save();
                     },
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check),
                            color: Colors.blue,
                            onPressed: () async {
                              save();
                            },
                          ),

                          Text("Save",style: TextStyle(
                            color: Colors.blue,
                            fontSize: hp(2),
                          ),),
                        ],
                      ),
                    ),
                    //CLEAR CANVAS
                    InkWell(
                      onTap: () => setState(() => _controller.clear()),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.clear),
                            color: Colors.blue,
                            onPressed: () {
                              setState(() => _controller.clear());
                            },
                          ),
                          Text("Clear",style: TextStyle(
                            color: Colors.blue,
                            fontSize: hp(2),
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void save() async{
    if (_controller.isNotEmpty) {
      var data = await _controller.toPngBytes();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Photo Documentation",
                  style:
                  new TextStyle(color: Colors.black54),
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
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PhotoDocumentationSingnature()));
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PhotoDocumetationSettings()));
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print("Next");
                },
                child: Icon(Icons.check),
                backgroundColor: Colors.green.shade500,
              ),

              body: Center(
                  child: Container(
                      color: Colors.grey[300],
                      child: Image.memory(data))),
            );
          },
        ),
      );
    }
  }
}
