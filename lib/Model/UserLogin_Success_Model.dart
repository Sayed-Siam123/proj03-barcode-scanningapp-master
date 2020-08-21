class UserLogin_Success_Model{

  final int id;
  final bool success;
  final String message;
  final int code;


  UserLogin_Success_Model({this.id, this.success,this.message,this.code});

  factory UserLogin_Success_Model.fromJson(Map<String, dynamic> json) {
    return UserLogin_Success_Model(
      id: json['Id'],
      code: json['Code'],
      success: json['Success'],
      message: json['Message'],
    );
  }

}