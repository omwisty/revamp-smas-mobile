class ReportResponseModel {
  bool? success;
  int? errCode;
  List? data;

  ReportResponseModel({
    this.success,
    this.errCode,
    this.data
  });

  ReportResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errCode = json['error_code'];
    data = json['data'];
  }
}