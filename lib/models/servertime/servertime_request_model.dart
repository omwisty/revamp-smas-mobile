class ServerTimeRequestModel {
  double? latitude;
  double? longitude;

  ServerTimeRequestModel({
    this.latitude,
    this.longitude
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude!;
    data['longitude'] = longitude!;
    return data;
  }
}