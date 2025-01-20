// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeEntityAdapter extends TypeAdapter<TypeEntity> {
  @override
  final int typeId = 1;

  @override
  TypeEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeEntity(
      isGroup: fields[0] as bool?,
      parentId: fields[1] as int?,
      value: fields[2] as int?,
      text: fields[3] as String?,
      orderCode: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TypeEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isGroup)
      ..writeByte(1)
      ..write(obj.parentId)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.text)
      ..writeByte(4)
      ..write(obj.orderCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
