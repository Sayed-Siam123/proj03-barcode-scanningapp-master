class MaterialPackModel{

  String sl;
  String id,materialName,materialDescription,isView,isAdd,isEdit,isDelete,isDeactivate;


  MaterialPackModel({this.materialName,this.isEdit,this.id,this.materialDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd});





  factory MaterialPackModel.fromJson(Map<String, dynamic> json) {
    return MaterialPackModel(
      id: json['id'],
      materialName: json['materialName'],
      materialDescription: json['materialDescription'],
      isView: json['isView'],
      isAdd: json['isAdd'],
      isEdit: json['isEdit'],
      isDelete: json['isDelete'],
      isDeactivate: json['isDeactivate'],

    );
  }

}