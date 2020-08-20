class getdeliverysuccess_model{

  final String position;
  final bool success;
  final String message;
  final String barcode;


  getdeliverysuccess_model({this.position, this.success,this.message,this.barcode});

  factory getdeliverysuccess_model.fromJson(Map<String, dynamic> json) {
    return getdeliverysuccess_model(
      position: json['id'],
      success: json['success'],
      message: json['message'],
      barcode: json['code'],
    );
  }

}