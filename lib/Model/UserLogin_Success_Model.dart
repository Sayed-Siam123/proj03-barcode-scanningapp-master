class UserLogin_Success_Model{

  final String id;
  final bool success;
  final String message;
  final String code;

  UserLogin_Success_Model({this.id, this.success,this.message,this.code});

  factory UserLogin_Success_Model.fromJson(Map<String, dynamic> json) {
    return UserLogin_Success_Model(
      id: json['id'],
      success: json['success'],
      message: json['message'],
      code: json['code'],
    );
  }

}