class getdeliverysuccess_model{

  final String id;
  final bool success;
  final String message;


  getdeliverysuccess_model({this.id, this.success,this.message});

  factory getdeliverysuccess_model.fromJson(Map<String, dynamic> json) {
    return getdeliverysuccess_model(
      id: json['id'],
      success: json['success'],
      message: json['message'],
    );
  }

}