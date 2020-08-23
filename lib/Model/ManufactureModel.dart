//ManufactureModel

class ManufactureModel{

  String sl;
  String id=null,manufacturerName=null,manufacturerDescription=null,isView=null,isAdd=null,isEdit=null,isDelete=null,isDeactivate=null,updateFlag=null,newFlag=null;


  ManufactureModel({this.manufacturerName,this.isEdit,this.id,this.manufacturerDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd,this.updateFlag,this.newFlag});


  String get getmanufacId=> this.id;
  String get getManufacturerName => this.manufacturerName;
  String get getManufacturerDescription => this.manufacturerDescription;
  String get getIsView => this.isView;
  String get getIsAdd => this.isAdd;
  String get getIsEdit => this.isEdit;
  String get getIsDelete => this.isDelete;
  String get getIsDeactivate => this.isDeactivate;
  String get getupdateFlag => this.updateFlag;


  set setid(String id) {
    this.id = id;
  }

  set setmanufacturerName(String manufacturerName) {
    this.manufacturerName = manufacturerName;
  }

  set setmanufacturerDescription(String manufacturerDescription) {
    this.manufacturerDescription = manufacturerDescription;
  }

  set setisView(String isView) {
    this.isView = isView;
  }

  set setisAdd(String isAdd) {
    this.isAdd = isAdd;
  }

  set setisEdit(String isEdit) {
    this.isEdit = isEdit;
  }

  set setisDelete(String isDelete) {
    this.isDelete = isDelete;
  }

  set setisDeactivate(String isDeactivate) {
    this.isDeactivate = isDeactivate;
  }

  set setupdateFlag(String updateFlag) {
    this.updateFlag = updateFlag;
  }

  Map<String, dynamic> toMap() => {
    "id" : this.id,
    "manufacturerName" : this.manufacturerName,
    "manufacturerDescription" : this.manufacturerDescription,
    "isView" : this.isView,
    "isAdd": this.isAdd,
    "isEdit" : this.isEdit,
    'isDelete': this.isDelete,
    "isDeactivate" : this.isDeactivate,
    "updateFlag" : this.updateFlag,
    "newFlag" : this.newFlag,
  };

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
      updateFlag: json['updateFlag'],
      newFlag: json['newFlag'],

    );
  }

  String toString() {
    return '${manufacturerName}';
  }

}