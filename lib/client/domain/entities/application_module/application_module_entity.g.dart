// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_module_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApplicationModuleEntityAdapter
    extends TypeAdapter<ApplicationModuleEntity> {
  @override
  final int typeId = 2;

  @override
  ApplicationModuleEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApplicationModuleEntity(
      id: fields[0] as int?,
      fullName: fields[1] as String?,
      shortName: fields[2] as String?,
      code: fields[3] as String?,
      stateId: fields[4] as int?,
      state: fields[5] as String?,
      orderCode: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ApplicationModuleEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.shortName)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.stateId)
      ..writeByte(5)
      ..write(obj.state)
      ..writeByte(6)
      ..write(obj.orderCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationModuleEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationModuleEntityImpl _$$ApplicationModuleEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicationModuleEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      shortName: json['shortName'] as String?,
      code: json['code'] as String?,
      stateId: (json['stateId'] as num?)?.toInt(),
      state: json['state'] as String?,
      orderCode: json['orderCode'] as String?,
    );

Map<String, dynamic> _$$ApplicationModuleEntityImplToJson(
        _$ApplicationModuleEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'shortName': instance.shortName,
      'code': instance.code,
      'stateId': instance.stateId,
      'state': instance.state,
      'orderCode': instance.orderCode,
    };
