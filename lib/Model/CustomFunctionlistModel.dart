class CustomFunctionListModel{

  String type;
  String name;

  CustomFunctionListModel({this.type,this.name});

  factory CustomFunctionListModel.fromJson(Map<String, dynamic> json) {
    return CustomFunctionListModel(
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
  };

}