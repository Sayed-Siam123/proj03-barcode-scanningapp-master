class DataAcquisition_model{
  String id=null,description=null,barcode=null;
  int quantity=null;
  String updateFlag=null,newFlag=null;



  DataAcquisition_model({this.id,this.barcode,this.description,this.quantity,this.newFlag,this.updateFlag});

  Map<String, dynamic> toMap() => {
    "id" : this.id,
    "barcode" : this.barcode,
    "description" : this.description,
    "quantity" : this.quantity,
    "updateFlag" : this.updateFlag,
    "newFlag" : this.newFlag,
  };


  factory DataAcquisition_model.fromJson(Map<String, dynamic> json) {
    return DataAcquisition_model(
      id: json['id'],
      barcode: json['barcode'],
      description: json['description'],
      quantity: json['quantity'],
      updateFlag: json['updateFlag'],
      newFlag: json['newFlag'],
    );
  }

}