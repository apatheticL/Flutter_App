class LoginResult {
  bool success;
  String token;
  String message;
  int userType;
  int userId;
  bool isActive;

  LoginResult(
      {this.success,
      this.token,
      this.message,
      this.userType,
      this.userId,
      this.isActive});

  factory LoginResult.fromJson(Map<String, dynamic> map) {
    var login = LoginResult(
      success: map['success'],
      token: map['token'],
      message: map['message'],
      userType: map['userType'],
      isActive: map['IsActive'] ?? true,
    );
    if (map['userId'] != null) login.userId = map["userId"];
    return login;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    data['message'] = this.message;
    data['userType'] = this.userType;
    data['IsActive'] = this.isActive;
    return data;
  }
}
