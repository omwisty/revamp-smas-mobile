class SignInRequestModel {
  String? userId;
  String? password;
  String? platform;
  String? appVersion;
  String? uuid;
  String? imei;
  String? imsi;

  SignInRequestModel({
    this.userId,
    this.password,
    this.platform,
    this.appVersion,
    this.uuid,
    this.imei,
    this.imsi
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["user_id"] = userId!;
    data["password"] = password!;
    data["platform"] = platform!;
    data["app_version"] = appVersion!;
    data["uuid"] = uuid!;
    data["imei"] = imei!;
    data["imsi"] = imsi!;
    return data;
  }

}