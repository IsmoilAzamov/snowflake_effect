// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_type_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApplicationTypeEntityAdapter extends TypeAdapter<ApplicationTypeEntity> {
  @override
  final int typeId = 3;

  @override
  ApplicationTypeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApplicationTypeEntity(
      id: fields[0] as int?,
      orderCode: fields[1] as String?,
      code: fields[2] as String?,
      shortName: fields[3] as String?,
      fullName: fields[4] as String?,
      processingPeriodInDays: fields[5] as int?,
      stateId: fields[6] as int?,
      state: fields[7] as String?,
      isGroup: fields[8] as bool?,
      parentId: fields[9] as int?,
      isUniversal: fields[10] as bool?,
      applicationGroupId: fields[11] as int?,
      hasApplication: fields[12] as bool?,
      createdAt: fields[13] as String?,
      modifiedAt: fields[14] as String?,
      moduleId: fields[15] as int?,
      module: fields[16] as String?,
      moduleCode: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ApplicationTypeEntity obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderCode)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.shortName)
      ..writeByte(4)
      ..write(obj.fullName)
      ..writeByte(5)
      ..write(obj.processingPeriodInDays)
      ..writeByte(6)
      ..write(obj.stateId)
      ..writeByte(7)
      ..write(obj.state)
      ..writeByte(8)
      ..write(obj.isGroup)
      ..writeByte(9)
      ..write(obj.parentId)
      ..writeByte(10)
      ..write(obj.isUniversal)
      ..writeByte(11)
      ..write(obj.applicationGroupId)
      ..writeByte(12)
      ..write(obj.hasApplication)
      ..writeByte(13)
      ..write(obj.createdAt)
      ..writeByte(14)
      ..write(obj.modifiedAt)
      ..writeByte(15)
      ..write(obj.moduleId)
      ..writeByte(16)
      ..write(obj.module)
      ..writeByte(17)
      ..write(obj.moduleCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationTypeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationTypeEntityImpl _$$ApplicationTypeEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicationTypeEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      orderCode: json['orderCode'] as String?,
      code: json['code'] as String?,
      shortName: json['shortName'] as String?,
      fullName: json['fullName'] as String?,
      processingPeriodInDays: (json['processingPeriodInDays'] as num?)?.toInt(),
      stateId: (json['stateId'] as num?)?.toInt(),
      state: json['state'] as String?,
      isGroup: json['isGroup'] as bool?,
      parentId: (json['parentId'] as num?)?.toInt(),
      isUniversal: json['isUniversal'] as bool?,
      applicationGroupId: (json['applicationGroupId'] as num?)?.toInt(),
      hasApplication: json['hasApplication'] as bool?,
      createdAt: json['createdAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
      moduleId: (json['moduleId'] as num?)?.toInt(),
      module: json['module'] as String?,
      moduleCode: json['moduleCode'] as String?,
    );

Map<String, dynamic> _$$ApplicationTypeEntityImplToJson(
        _$ApplicationTypeEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderCode': instance.orderCode,
      'code': instance.code,
      'shortName': instance.shortName,
      'fullName': instance.fullName,
      'processingPeriodInDays': instance.processingPeriodInDays,
      'stateId': instance.stateId,
      'state': instance.state,
      'isGroup': instance.isGroup,
      'parentId': instance.parentId,
      'isUniversal': instance.isUniversal,
      'applicationGroupId': instance.applicationGroupId,
      'hasApplication': instance.hasApplication,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
      'moduleId': instance.moduleId,
      'module': instance.module,
      'moduleCode': instance.moduleCode,
    };
