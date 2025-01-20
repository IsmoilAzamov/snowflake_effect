import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'application_type_entity.freezed.dart';
part 'application_type_entity.g.dart';



@HiveType(typeId: 3)
@freezed
class ApplicationTypeEntity with _$ApplicationTypeEntity {
  const factory ApplicationTypeEntity({
    @HiveField(0) int? id,
    @HiveField(1) String? orderCode,
    @HiveField(2) String? code,
    @HiveField(3) String? shortName,
    @HiveField(4) String? fullName,
    @HiveField(5) int? processingPeriodInDays,
    @HiveField(6) int? stateId,
    @HiveField(7) String? state,
    @HiveField(8) bool? isGroup,
    @HiveField(9) int? parentId,
    @HiveField(10) bool? isUniversal,
    @HiveField(11) int? applicationGroupId,
    @HiveField(12) bool? hasApplication,
    @HiveField(13) String? createdAt,
    @HiveField(14) String? modifiedAt,
    @HiveField(15) int? moduleId,
    @HiveField(16) String? module,
    @HiveField(17) String? moduleCode,
  }) = _ApplicationTypeEntity;

  factory ApplicationTypeEntity.fromJson(Map<String, dynamic> json) =>
      _$ApplicationTypeEntityFromJson(json);
}
