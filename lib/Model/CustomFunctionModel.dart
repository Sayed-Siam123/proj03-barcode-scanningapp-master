import 'package:app/Model/CustomFunctionlistModel.dart';

class CustomFunctionModel{

  String name,desc,separator,file_format;
  List<CustomFunctionListModel> field_list = [];

  CustomFunctionModel({this.name,this.desc,this.file_format,this.field_list,this.separator});

  //CustomFunctionListModel data;

  factory CustomFunctionModel.fromJson(Map<String, dynamic> json) {
    return CustomFunctionModel(
      name: json['name'],
      desc: json['desc'],
      file_format: json['file_format'],
      separator: json['separator'],
      field_list: List<CustomFunctionListModel>.from(json["field_list"].map((x) => CustomFunctionListModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'desc': desc,
    'file_format': file_format,
    'separator': separator,
    'field_list': List<dynamic>.from(field_list.map((x) => x.toJson())),
  };

}