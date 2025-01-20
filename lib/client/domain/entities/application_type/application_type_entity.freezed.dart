// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_type_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApplicationTypeEntity _$ApplicationTypeEntityFromJson(
    Map<String, dynamic> json) {
  return _ApplicationTypeEntity.fromJson(json);
}

/// @nodoc
mixin _$ApplicationTypeEntity {
  @HiveField(0)
  int? get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get orderCode => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get code => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get shortName => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get fullName => throw _privateConstructorUsedError;
  @HiveField(5)
  int? get processingPeriodInDays => throw _privateConstructorUsedError;
  @HiveField(6)
  int? get stateId => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get state => throw _privateConstructorUsedError;
  @HiveField(8)
  bool? get isGroup => throw _privateConstructorUsedError;
  @HiveField(9)
  int? get parentId => throw _privateConstructorUsedError;
  @HiveField(10)
  bool? get isUniversal => throw _privateConstructorUsedError;
  @HiveField(11)
  int? get applicationGroupId => throw _privateConstructorUsedError;
  @HiveField(12)
  bool? get hasApplication => throw _privateConstructorUsedError;
  @HiveField(13)
  String? get createdAt => throw _privateConstructorUsedError;
  @HiveField(14)
  String? get modifiedAt => throw _privateConstructorUsedError;
  @HiveField(15)
  int? get moduleId => throw _privateConstructorUsedError;
  @HiveField(16)
  String? get module => throw _privateConstructorUsedError;
  @HiveField(17)
  String? get moduleCode => throw _privateConstructorUsedError;

  /// Serializes this ApplicationTypeEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplicationTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationTypeEntityCopyWith<ApplicationTypeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationTypeEntityCopyWith<$Res> {
  factory $ApplicationTypeEntityCopyWith(ApplicationTypeEntity value,
          $Res Function(ApplicationTypeEntity) then) =
      _$ApplicationTypeEntityCopyWithImpl<$Res, ApplicationTypeEntity>;
  @useResult
  $Res call(
      {@HiveField(0) int? id,
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
      @HiveField(17) String? moduleCode});
}

/// @nodoc
class _$ApplicationTypeEntityCopyWithImpl<$Res,
        $Val extends ApplicationTypeEntity>
    implements $ApplicationTypeEntityCopyWith<$Res> {
  _$ApplicationTypeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicationTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderCode = freezed,
    Object? code = freezed,
    Object? shortName = freezed,
    Object? fullName = freezed,
    Object? processingPeriodInDays = freezed,
    Object? stateId = freezed,
    Object? state = freezed,
    Object? isGroup = freezed,
    Object? parentId = freezed,
    Object? isUniversal = freezed,
    Object? applicationGroupId = freezed,
    Object? hasApplication = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? moduleId = freezed,
    Object? module = freezed,
    Object? moduleCode = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderCode: freezed == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      processingPeriodInDays: freezed == processingPeriodInDays
          ? _value.processingPeriodInDays
          : processingPeriodInDays // ignore: cast_nullable_to_non_nullable
              as int?,
      stateId: freezed == stateId
          ? _value.stateId
          : stateId // ignore: cast_nullable_to_non_nullable
              as int?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      isGroup: freezed == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      isUniversal: freezed == isUniversal
          ? _value.isUniversal
          : isUniversal // ignore: cast_nullable_to_non_nullable
              as bool?,
      applicationGroupId: freezed == applicationGroupId
          ? _value.applicationGroupId
          : applicationGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      hasApplication: freezed == hasApplication
          ? _value.hasApplication
          : hasApplication // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      moduleId: freezed == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as int?,
      module: freezed == module
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String?,
      moduleCode: freezed == moduleCode
          ? _value.moduleCode
          : moduleCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationTypeEntityImplCopyWith<$Res>
    implements $ApplicationTypeEntityCopyWith<$Res> {
  factory _$$ApplicationTypeEntityImplCopyWith(
          _$ApplicationTypeEntityImpl value,
          $Res Function(_$ApplicationTypeEntityImpl) then) =
      __$$ApplicationTypeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int? id,
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
      @HiveField(17) String? moduleCode});
}

/// @nodoc
class __$$ApplicationTypeEntityImplCopyWithImpl<$Res>
    extends _$ApplicationTypeEntityCopyWithImpl<$Res,
        _$ApplicationTypeEntityImpl>
    implements _$$ApplicationTypeEntityImplCopyWith<$Res> {
  __$$ApplicationTypeEntityImplCopyWithImpl(_$ApplicationTypeEntityImpl _value,
      $Res Function(_$ApplicationTypeEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplicationTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orderCode = freezed,
    Object? code = freezed,
    Object? shortName = freezed,
    Object? fullName = freezed,
    Object? processingPeriodInDays = freezed,
    Object? stateId = freezed,
    Object? state = freezed,
    Object? isGroup = freezed,
    Object? parentId = freezed,
    Object? isUniversal = freezed,
    Object? applicationGroupId = freezed,
    Object? hasApplication = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? moduleId = freezed,
    Object? module = freezed,
    Object? moduleCode = freezed,
  }) {
    return _then(_$ApplicationTypeEntityImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderCode: freezed == orderCode
          ? _value.orderCode
          : orderCode // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _value.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      processingPeriodInDays: freezed == processingPeriodInDays
          ? _value.processingPeriodInDays
          : processingPeriodInDays // ignore: cast_nullable_to_non_nullable
              as int?,
      stateId: freezed == stateId
          ? _value.stateId
          : stateId // ignore: cast_nullable_to_non_nullable
              as int?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      isGroup: freezed == isGroup
          ? _value.isGroup
          : isGroup // ignore: cast_nullable_to_non_nullable
              as bool?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      isUniversal: freezed == isUniversal
          ? _value.isUniversal
          : isUniversal // ignore: cast_nullable_to_non_nullable
              as bool?,
      applicationGroupId: freezed == applicationGroupId
          ? _value.applicationGroupId
          : applicationGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      hasApplication: freezed == hasApplication
          ? _value.hasApplication
          : hasApplication // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      moduleId: freezed == moduleId
          ? _value.moduleId
          : moduleId // ignore: cast_nullable_to_non_nullable
              as int?,
      module: freezed == module
          ? _value.module
          : module // ignore: cast_nullable_to_non_nullable
              as String?,
      moduleCode: freezed == moduleCode
          ? _value.moduleCode
          : moduleCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationTypeEntityImpl implements _ApplicationTypeEntity {
  const _$ApplicationTypeEntityImpl(
      {@HiveField(0) this.id,
      @HiveField(1) this.orderCode,
      @HiveField(2) this.code,
      @HiveField(3) this.shortName,
      @HiveField(4) this.fullName,
      @HiveField(5) this.processingPeriodInDays,
      @HiveField(6) this.stateId,
      @HiveField(7) this.state,
      @HiveField(8) this.isGroup,
      @HiveField(9) this.parentId,
      @HiveField(10) this.isUniversal,
      @HiveField(11) this.applicationGroupId,
      @HiveField(12) this.hasApplication,
      @HiveField(13) this.createdAt,
      @HiveField(14) this.modifiedAt,
      @HiveField(15) this.moduleId,
      @HiveField(16) this.module,
      @HiveField(17) this.moduleCode});

  factory _$ApplicationTypeEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationTypeEntityImplFromJson(json);

  @override
  @HiveField(0)
  final int? id;
  @override
  @HiveField(1)
  final String? orderCode;
  @override
  @HiveField(2)
  final String? code;
  @override
  @HiveField(3)
  final String? shortName;
  @override
  @HiveField(4)
  final String? fullName;
  @override
  @HiveField(5)
  final int? processingPeriodInDays;
  @override
  @HiveField(6)
  final int? stateId;
  @override
  @HiveField(7)
  final String? state;
  @override
  @HiveField(8)
  final bool? isGroup;
  @override
  @HiveField(9)
  final int? parentId;
  @override
  @HiveField(10)
  final bool? isUniversal;
  @override
  @HiveField(11)
  final int? applicationGroupId;
  @override
  @HiveField(12)
  final bool? hasApplication;
  @override
  @HiveField(13)
  final String? createdAt;
  @override
  @HiveField(14)
  final String? modifiedAt;
  @override
  @HiveField(15)
  final int? moduleId;
  @override
  @HiveField(16)
  final String? module;
  @override
  @HiveField(17)
  final String? moduleCode;

  @override
  String toString() {
    return 'ApplicationTypeEntity(id: $id, orderCode: $orderCode, code: $code, shortName: $shortName, fullName: $fullName, processingPeriodInDays: $processingPeriodInDays, stateId: $stateId, state: $state, isGroup: $isGroup, parentId: $parentId, isUniversal: $isUniversal, applicationGroupId: $applicationGroupId, hasApplication: $hasApplication, createdAt: $createdAt, modifiedAt: $modifiedAt, moduleId: $moduleId, module: $module, moduleCode: $moduleCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationTypeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderCode, orderCode) ||
                other.orderCode == orderCode) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.processingPeriodInDays, processingPeriodInDays) ||
                other.processingPeriodInDays == processingPeriodInDays) &&
            (identical(other.stateId, stateId) || other.stateId == stateId) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.isGroup, isGroup) || other.isGroup == isGroup) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.isUniversal, isUniversal) ||
                other.isUniversal == isUniversal) &&
            (identical(other.applicationGroupId, applicationGroupId) ||
                other.applicationGroupId == applicationGroupId) &&
            (identical(other.hasApplication, hasApplication) ||
                other.hasApplication == hasApplication) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.moduleId, moduleId) ||
                other.moduleId == moduleId) &&
            (identical(other.module, module) || other.module == module) &&
            (identical(other.moduleCode, moduleCode) ||
                other.moduleCode == moduleCode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      orderCode,
      code,
      shortName,
      fullName,
      processingPeriodInDays,
      stateId,
      state,
      isGroup,
      parentId,
      isUniversal,
      applicationGroupId,
      hasApplication,
      createdAt,
      modifiedAt,
      moduleId,
      module,
      moduleCode);

  /// Create a copy of ApplicationTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationTypeEntityImplCopyWith<_$ApplicationTypeEntityImpl>
      get copyWith => __$$ApplicationTypeEntityImplCopyWithImpl<
          _$ApplicationTypeEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationTypeEntityImplToJson(
      this,
    );
  }
}

abstract class _ApplicationTypeEntity implements ApplicationTypeEntity {
  const factory _ApplicationTypeEntity(
      {@HiveField(0) final int? id,
      @HiveField(1) final String? orderCode,
      @HiveField(2) final String? code,
      @HiveField(3) final String? shortName,
      @HiveField(4) final String? fullName,
      @HiveField(5) final int? processingPeriodInDays,
      @HiveField(6) final int? stateId,
      @HiveField(7) final String? state,
      @HiveField(8) final bool? isGroup,
      @HiveField(9) final int? parentId,
      @HiveField(10) final bool? isUniversal,
      @HiveField(11) final int? applicationGroupId,
      @HiveField(12) final bool? hasApplication,
      @HiveField(13) final String? createdAt,
      @HiveField(14) final String? modifiedAt,
      @HiveField(15) final int? moduleId,
      @HiveField(16) final String? module,
      @HiveField(17) final String? moduleCode}) = _$ApplicationTypeEntityImpl;

  factory _ApplicationTypeEntity.fromJson(Map<String, dynamic> json) =
      _$ApplicationTypeEntityImpl.fromJson;

  @override
  @HiveField(0)
  int? get id;
  @override
  @HiveField(1)
  String? get orderCode;
  @override
  @HiveField(2)
  String? get code;
  @override
  @HiveField(3)
  String? get shortName;
  @override
  @HiveField(4)
  String? get fullName;
  @override
  @HiveField(5)
  int? get processingPeriodInDays;
  @override
  @HiveField(6)
  int? get stateId;
  @override
  @HiveField(7)
  String? get state;
  @override
  @HiveField(8)
  bool? get isGroup;
  @override
  @HiveField(9)
  int? get parentId;
  @override
  @HiveField(10)
  bool? get isUniversal;
  @override
  @HiveField(11)
  int? get applicationGroupId;
  @override
  @HiveField(12)
  bool? get hasApplication;
  @override
  @HiveField(13)
  String? get createdAt;
  @override
  @HiveField(14)
  String? get modifiedAt;
  @override
  @HiveField(15)
  int? get moduleId;
  @override
  @HiveField(16)
  String? get module;
  @override
  @HiveField(17)
  String? get moduleCode;

  /// Create a copy of ApplicationTypeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationTypeEntityImplCopyWith<_$ApplicationTypeEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
