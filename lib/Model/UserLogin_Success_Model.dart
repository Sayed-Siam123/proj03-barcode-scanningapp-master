class UserLogin_Success_Model{

  final String id;
  final bool success;
  final String message;


  UserLogin_Success_Model({this.id, this.success,this.message});

  factory UserLogin_Success_Model.fromJson(Map<String, dynamic> json) {
    return UserLogin_Success_Model(
      id: json['Id'],
      success: json['Success'],
      message: json['Message'],
    );
  }

}