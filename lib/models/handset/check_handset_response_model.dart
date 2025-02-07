class CheckHandsetResponseModel {
  int? errCode;
  bool? success;
  bool? isValidHandset;
  bool? needUpdate;

  CheckHandsetResponseModel({
    this.errCode,
    this.success,
    this.isValidHandset,
    this.needUpdate,
  });

  CheckHandsetResponseModel.fromJson(Map<String, dynamic> json) {
    errCode = json['error_code'];
    success = json['success'];
    isValidHandset = json['is_valid_handset'];
    needUpdate = json['need_update'];
  }
}