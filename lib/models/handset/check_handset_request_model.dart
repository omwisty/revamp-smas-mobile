class CheckHandsetRequestModel {
  String? platform;
  String? imei;
  String? imsi;
  String? uuid;

  CheckHandsetRequestModel({
    this.platform,
    this.imei,
    this.imsi,
    this.uuid
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform!;
    data['imei'] = imei!;
    data['imsi'] = imsi!;
    data['uuid'] = uuid!;
    return data;
  }
}