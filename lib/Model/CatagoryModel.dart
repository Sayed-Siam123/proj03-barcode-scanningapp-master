class CategoryModel{

  String sl;
  String id=null,categoryName=null,categoryDescription=null,isView=null,isAdd=null,isEdit=null,isDelete=null,isDeactivate=null,updateFlag=null;


  CategoryModel({this.categoryName,this.isEdit,this.id,this.categoryDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd,this.updateFlag});



  Map<String, dynamic> toMap() => {
    "id" : this.id,
    "categoryName" : this.categoryName,
    "categoryDescription" : this.categoryDescription,
    "isView" : this.isView,
    "isAdd": this.isAdd,
    "isEdit" : this.isEdit,
    'isDelete': this.isDelete,
    "isDeactivate" : this.isDeactivate,
    "updateFlag" : this.updateFlag,

  };


  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
      categoryDescription: json['categoryDescription'],
      isView: json['isView'],
      isAdd: json['isAdd'],
      isEdit: json['isEdit'],
      isDelete: json['isDelete'],
      isDeactivate: json['isDeactivate'],
      updateFlag: json['updateFlag'],

    );
  }

}