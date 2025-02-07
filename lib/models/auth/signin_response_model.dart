class SignInResponseModel {
  int? errCode;
  String? token;
  bool? isLoggedIn;
  bool? success;
  String? message;
  String? userName;

  SignInResponseModel({
    this.errCode,
    this.token,
    this.isLoggedIn,
    this.success,
    this.message,
    this.userName,
  });

  SignInResponseModel.fromJson(Map<String, dynamic> json) {
    errCode = json['error_code'];
    token = json['token'];
    isLoggedIn = json['is_loggedin'];
    success = json['success'];
    message = json['message'];
    userName = json['user_name'];
  }
}