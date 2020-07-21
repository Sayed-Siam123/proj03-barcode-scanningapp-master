//ManufactureModel

class ManufactureModel{

  String sl;
  String id,manufacturerName,manufacturerDescription,isView,isAdd,isEdit,isDelete,isDeactivate;


  ManufactureModel({this.manufacturerName,this.isEdit,this.id,this.manufacturerDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd});





  factory ManufactureModel.fromJson(Map<String, dynamic> json) {
    return ManufactureModel(
      id: json['id'],
      manufacturerName: json['manufacturerName'],
      manufacturerDescription: json['manufacturerDescription'],
      isView: json['isView'],
      isAdd: json['isAdd'],
      isEdit: json['isEdit'],
      isDelete: json['isDelete'],
      isDeactivate: json['isDeactivate'],

    );
  }

}