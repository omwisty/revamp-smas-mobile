class UpdatesRequestModel {
  String? platform;

  UpdatesRequestModel({
    this.platform
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['platform'] = platform!;
    return data;
  }
}