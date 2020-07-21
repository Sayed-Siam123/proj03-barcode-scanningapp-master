class sublist_getsuccess_model{

  final String id;
  final bool success;
  final String message;


  sublist_getsuccess_model({this.id, this.success,this.message});

  factory sublist_getsuccess_model.fromJson(Map<String, dynamic> json) {
    return sublist_getsuccess_model(
      id: json['id'],
      success: json['success'],
      message: json['message'],
    );
  }

}