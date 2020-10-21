import 'package:app/Model/CustomFunctionlistModel.dart';

class CustomFunctionModel{

  String name,desc,separator,file_format;
  List<CustomFunctionListModel> field_list = [];

  CustomFunctionModel({this.name,this.desc,this.file_format,this.field_list,this.separator});

}