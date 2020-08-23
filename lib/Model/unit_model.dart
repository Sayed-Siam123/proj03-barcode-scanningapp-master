class UnitModel{

  String sl;
  String id=null,unitName=null,unitShort=null,unitDescription=null,isView=null,isAdd=null,isEdit=null,isDelete=null,isDeactivate=null,updateFlag=null;


  UnitModel({this.unitName,this.unitShort,this.isEdit,this.id,this.unitDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd,this.updateFlag});


  Map<String, dynamic> toMap() => {
    "id" : this.id,
    "unitName" : this.unitName,
    "unitDescription" : this.unitDescription,
    "isView" : this.isView,
    "isAdd": this.isAdd,
    "isEdit" : this.isEdit,
    'isDelete': this.isDelete,
    "isDeactivate" : this.isDeactivate,
    "updateFlag" : this.updateFlag,
    "unitShort" : this.unitShort,

  };


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
      updateFlag: json['updateFlag'],
    );
  }

}