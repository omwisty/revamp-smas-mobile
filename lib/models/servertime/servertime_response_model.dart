class ServerTimeResponseModel {
  int? errCode;
  bool? success;
  String? message;
  String? serverTime;

  ServerTimeResponseModel({
    this.errCode,
    this.success,
    this.message,
    this.serverTime
  });

  ServerTimeResponseModel.fromJson(Map<String, dynamic> json) {
    errCode = json['error_code'];
    success = json['success'];
    message = json['message'];
    serverTime = json['server_time'];
  }
}