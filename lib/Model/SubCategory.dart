class SubCategoryModel{

  String sl;
  String id,subCategoryName,subcategoryDescription,isView,isAdd,isEdit,isDelete,isDeactivate,categoryId,categoryName;


  SubCategoryModel({this.subCategoryName,this.isEdit,this.id,this.subcategoryDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd,this.categoryName,
  this.categoryId});





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

    );
  }

}