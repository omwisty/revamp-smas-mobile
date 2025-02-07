class ChangeUuidRequestModel {
  String? userId;
  String? password;
  String? newUuid;

  ChangeUuidRequestModel({
    this.userId,
    this.password,
    this.newUuid,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId!;
    data['password'] = password!;
    data['new_uuid'] = newUuid!;
    return data;
  }
}