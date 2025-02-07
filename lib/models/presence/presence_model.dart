import 'package:hive_flutter/hive_flutter.dart';

part 'presence_model.g.dart';

@HiveType(typeId: 0)
class PresenceModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? keyword;

  @HiveField(2)
  String? presenceDate;

  @HiveField(3)
  double? latitude;

  @HiveField(4)
  double? longitude;

  @HiveField(5)
  double? accuracy;

  @HiveField(6)
  bool? isMockLocation;

  @HiveField(7)
  int? presenceFlag;

  @HiveField(8)
  String? checksum;

  @HiveField(9)
  String? version;

  @HiveField(10)
  String? date;

  PresenceModel({
    this.id,
    this.keyword,
    this.presenceDate,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.isMockLocation,
    this.presenceFlag,
    this.checksum,
    this.version,
    this.date
  });
}