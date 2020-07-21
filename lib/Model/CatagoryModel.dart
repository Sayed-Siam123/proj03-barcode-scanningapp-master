class CategoryModel{

  String sl;
  String id,categoryName,categoryDescription,isView,isAdd,isEdit,isDelete,isDeactivate;


  CategoryModel({this.categoryName,this.isEdit,this.id,this.categoryDescription,this.isDelete,this.isView,this.isDeactivate,this.isAdd});





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

    );
  }

}