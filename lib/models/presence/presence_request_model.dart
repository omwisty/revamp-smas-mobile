import 'package:encrypt/encrypt.dart';

class PresenceRequestModel {
  String? keyword;
  String? presenceDate;
  double? latitude;
  double? longitude;
  double? accuracy;
  bool? isMockLocation;
  int? presenceFlag;
  String? checksum;
  String? version;

  PresenceRequestModel({
    this.keyword,
    this.presenceDate,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.isMockLocation,
    this.presenceFlag,
    this.checksum,
    this.version
  });

  String toEncryptPayload(String nik, String uuid) {
    final Map<String, dynamic> data = toJson(nik, uuid);
    String finalKey = '$nik$uuid';
    if (finalKey.length <= 32) {
      StringBuffer stringBuffer = StringBuffer(finalKey);
      var x = 32 - finalKey.length;
      for (var i=0; i < x; i++) {
        stringBuffer.write('0');
      }
      finalKey = stringBuffer.toString();
    } else if (finalKey.length > 32) {
      String x = finalKey.split('-').join('');
      String c = x.substring(0, 32);
      finalKey = c;
    }
    final payload = data.toString();
    final key = Key.fromUtf8(finalKey);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt("$iv$payload", iv: iv);
    return encrypted.base64;
  }

  Map<String, dynamic> toJson(String nik, String uuid) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keyword'] = keyword!;
    data['presence_date'] = presenceDate!;
    data['latitude'] = latitude!;
    data['longitude'] = longitude!;
    data['accuracy'] = accuracy!;
    data['is_mock_location'] = isMockLocation!;
    data['presence_flag'] = presenceFlag!;
    data['checksum'] = checksum!;
    data['version'] = version!;
    return data;
  }
}