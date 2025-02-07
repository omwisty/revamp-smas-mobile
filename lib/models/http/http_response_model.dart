class HttpResponseModel {
  bool? success;
  int? errCode;
  String? message;

  HttpResponseModel({
    this.success,
    this.errCode,
    this.message
  });

  HttpResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errCode = json['error_code'];
    message = json['message'];
  }
}