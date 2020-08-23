class SubCategoryModel{

  String sl;
  String id=null,subCategoryName=null,subcategoryDescription=null,isView=null,isAdd=null,isEdit=null,isDelete=null,isDeactivate=null,categoryId=null,categoryName=null,updateFlag=null;


  SubCategoryModel({this.subCategoryName,this.isEdit,this.id,this.subcategoryDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd,this.categoryName,
  this.categoryId,this.updateFlag});


  Map<String, dynamic> toMap() => {
    "id" : this.id,
    "subCategoryName" : this.subCategoryName,
    "subcategoryDescription" : this.subcategoryDescription,
    "isView" : this.isView,
    "isAdd": this.isAdd,
    "isEdit" : this.isEdit,
    'isDelete': this.isDelete,
    "isDeactivate" : this.isDeactivate,
    "updateFlag" : this.updateFlag,
    "categoryId": this.categoryId,
    "categoryName" : this.categoryName,

  };


  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      subCategoryName: json['subCategoryName'],
      subcategoryDescription: json['subcategoryDescription'],
      isView: json['isView'],
      isAdd: json['isAdd'],
      isEdit: json['isEdit'],
      isDelete: json['isDelete'],
      isDeactivate: json['isDeactivate'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      updateFlag: json['updateFlag'],
    );
  }

}