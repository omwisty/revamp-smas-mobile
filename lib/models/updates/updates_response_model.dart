class UpdatesResponseModel {
  int? errCode;
  bool? success;
  String? fileName;
  String? version;
  String? link;

  UpdatesResponseModel({
    this.errCode,
    this.success,
    this.fileName,
    this.version,
    this.link
  });

  UpdatesResponseModel.fromJson(Map<String, dynamic> json) {
    errCode = json['error_code'];
    success = json['success'];
    fileName = json['file_name'];
    version = json['version'];
    link = json['link'];
  }
}