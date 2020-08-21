class getdeliverysuccess_model{

  String position;
  bool success;
  String message;
  String code;


  getdeliverysuccess_model({this.position, this.success,this.message,this.code});

  factory getdeliverysuccess_model.fromJson(Map<String, dynamic> json) {
    return getdeliverysuccess_model(
      position: json['id'],
      success: json['success'],
      message: json['message'],
      code: json['code'],
    );
  }

}