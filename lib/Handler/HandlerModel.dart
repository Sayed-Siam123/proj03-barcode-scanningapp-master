class HandlerClass{
  String clicked;
  String id;


  HandlerClass({this.clicked, this.id});


  String get getclick{
    return this.clicked;
  }

  String get getid_data {
    return this.id;
  }

  set setclick(String clicked){
    this.clicked = clicked;
  }

  set setid(String id){
    this.id = id;
  }


}