// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestEntityImpl _$$LoginRequestEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginRequestEntityImpl(
      seria: json['seria'] as String?,
      number: json['number'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      documentTypeId: (json['documentTypeId'] as num?)?.toInt(),
      pinfl: json['pinfl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      verificationCode: json['verificationCode'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      addAsTrustedDevice: json['addAsTrustedDevice'] as bool?,
      confirmPassword: json['confirmPassword'] as String?,
    );

Map<String, dynamic> _$$LoginRequestEntityImplToJson(
        _$LoginRequestEntityImpl instance) =>
    <String, dynamic>{
      'seria': instance.seria,
      'number': instance.number,
      'dateOfBirth': instance.dateOfBirth,
      'documentTypeId': instance.documentTypeId,
      'pinfl': instance.pinfl,
      'phoneNumber': instance.phoneNumber,
      'verificationCode': instance.verificationCode,
      'email': instance.email,
      'password': instance.password,
      'addAsTrustedDevice': instance.addAsTrustedDevice,
      'confirmPassword': instance.confirmPassword,
    };
