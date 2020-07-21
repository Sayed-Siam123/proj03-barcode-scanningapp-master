class UnitModel{

  String sl;
  String id,unitName,unitDescription,isView,isAdd,isEdit,isDelete,isDeactivate;


  UnitModel({this.unitName,this.isEdit,this.id,this.unitDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd});





  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'],
      unitName: json['unitName'],
      unitDescription: json['unitDescription'],
      isView: json['isView'],
      isAdd: json['isAdd'],
      isEdit: json['isEdit'],
      isDelete: json['isDelete'],
      isDeactivate: json['isDeactivate'],

    );
  }

}