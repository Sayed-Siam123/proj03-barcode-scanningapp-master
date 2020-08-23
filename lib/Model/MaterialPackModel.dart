class MaterialPackModel{

  String sl;
  String id=null,materialName=null,materialDescription=null,isView=null,isAdd=null,isEdit=null,isDelete=null,isDeactivate=null,updateFlag=null,newFlag=null;


  MaterialPackModel({this.materialName,this.isEdit,this.id,this.materialDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd,this.updateFlag,this.newFlag});


  Map<String, dynamic> toMap() => {
    "id" : this.id,
    "materialName" : this.materialName,
    "materialDescription" : this.materialDescription,
    "isView" : this.isView,
    "isAdd": this.isAdd,
    "isEdit" : this.isEdit,
    'isDelete': this.isDelete,
    "isDeactivate" : this.isDeactivate,
    "updateFlag" : this.updateFlag,
    "newFlag" : this.newFlag,
  };


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
      updateFlag: json['updateFlag'],
      newFlag: json['newFlag'],
    );
  }

  String toString() {
    return '${materialName}';
  }

}