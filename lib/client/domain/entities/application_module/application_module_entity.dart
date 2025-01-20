import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'application_module_entity.freezed.dart';
part 'application_module_entity.g.dart';


@HiveType(typeId: 2)
@freezed
class ApplicationModuleEntity with _$ApplicationModuleEntity {
  const factory ApplicationModuleEntity({
    @HiveField(0) int? id,
    @HiveField(1) String? fullName,
    @HiveField(2) String? shortName,
    @HiveField(3) String? code,
    @HiveField(4) int? stateId,
    @HiveField(5) String? state,
    @HiveField(6) String? orderCode,
  }) = _ApplicationModuleEntity;

  factory ApplicationModuleEntity.fromJson(Map<String, dynamic> json) =>
      _$ApplicationModuleEntityFromJson(json);
}
