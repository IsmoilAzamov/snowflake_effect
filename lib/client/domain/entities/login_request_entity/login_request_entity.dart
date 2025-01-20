import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_entity.freezed.dart';

part 'login_request_entity.g.dart';


@freezed
class LoginRequestEntity with _$LoginRequestEntity {
  const factory LoginRequestEntity({
    String? seria,
    String? number,
    String? dateOfBirth,
    int? documentTypeId,
    String? pinfl,
    String? phoneNumber,
    String? verificationCode,
    String? email,
    String? password,
    bool? addAsTrustedDevice,
    String? confirmPassword,
  }) = _LoginRequestEntity;

  factory LoginRequestEntity.fromJson(Map<String, dynamic> json) => _$LoginRequestEntityFromJson(json);

}