class ChangeUuidResponseModel {
  int? errCode;
  bool? success;
  String? lastUpdate;
  String? message;

  ChangeUuidResponseModel({
    this.errCode,
    this.success,
    this.lastUpdate,
    this.message
  });

  ChangeUuidResponseModel.fromJson(Map<String, dynamic> json) {
    errCode = json['error_code'];
    success = json['success'];
    lastUpdate = json['last_update'];
    message = json['message'];
  }
}