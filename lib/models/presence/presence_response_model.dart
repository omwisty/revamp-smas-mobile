class PresenceResponseModel {
  bool? success;
  int? errCode;
  List? officeLocations;
  int? maxRadius;
  String? message;

  PresenceResponseModel({
    this.success,
    this.errCode,
    this.officeLocations,
    this.maxRadius,
    this.message
  });

  PresenceResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errCode = json['error_code'];
    officeLocations = json['office_locations'];
    maxRadius = json['max_radius'];
    message = json['message'];
  }
}