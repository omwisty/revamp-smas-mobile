// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'presence_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PresenceModelAdapter extends TypeAdapter<PresenceModel> {
  @override
  final int typeId = 0;

  @override
  PresenceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PresenceModel(
      id: fields[0] as int?,
      keyword: fields[1] as String?,
      presenceDate: fields[2] as String?,
      latitude: fields[3] as double?,
      longitude: fields[4] as double?,
      accuracy: fields[5] as double?,
      isMockLocation: fields[6] as bool?,
      presenceFlag: fields[7] as int?,
      checksum: fields[8] as String?,
      version: fields[9] as String?,
      date: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PresenceModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.keyword)
      ..writeByte(2)
      ..write(obj.presenceDate)
      ..writeByte(3)
      ..write(obj.latitude)
      ..writeByte(4)
      ..write(obj.longitude)
      ..writeByte(5)
      ..write(obj.accuracy)
      ..writeByte(6)
      ..write(obj.isMockLocation)
      ..writeByte(7)
      ..write(obj.presenceFlag)
      ..writeByte(8)
      ..write(obj.checksum)
      ..writeByte(9)
      ..write(obj.version)
      ..writeByte(10)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PresenceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
