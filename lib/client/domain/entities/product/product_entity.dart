import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

part 'product_entity.g.dart';


@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    final int? id,
    final String? id2,
    final int? tableId,
    final String? createdAt,
    final String? modifiedAt,
    final int? pomClassificatorId,
    final String? pomClassificator,
    final String? pomClassificatorTechRequirements,
    final int? mxikId,
    final String? mxik,
    final bool? isPom,
    final int? contractorId,
    final String? contractor,
    final int? contractorRegionId,
    final String? contractorRegion,
    final int? contractorDistrictId,
    final String? contractorDistrict,
    final String? contractorAddress,
    final String? contractorDirector,
    final String? contractorPhoneNumber,
    final String? title,
    final int? countryId,
    final String? country,
    final String? brand,
    final int? minPrice,
    final int? maxPrice,
    final int? minDeadlineDays,
    final int? maxDeadlineDays,
    final int? currencyId,
    final String? currency,
    final int? salesCount,
    final String? photoId, // Extracted from `photos`
    final String? photoFileName, // Extracted from `photos`
    final String? photoFileExtension, // Extracted from `photos`
    final String? instruction,
    final String? description,
    final double? subsidyAmount,
    final double? subsidyCoeficcient,
    final String? subsidyCalculatedAt,
    final int? warrantyMonth,
    final int? usageDurationMonth,
    final List<PhotoEntity>? photos,
    final List<CertificateEntity>? certificates,
  }) = _ProductEntity;

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

}

@freezed
class PhotoEntity with _$PhotoEntity {
  const factory PhotoEntity({
    final String? id,
    final bool? isMain,
    final int? ownerId,
    final String? fileName,
    final String? fileExtension
  }) = _PhotoEntity;

  factory PhotoEntity.fromJson(Map<String, dynamic> json) =>
      _$PhotoEntityFromJson(json);
}

@freezed
class CertificateEntity with _$CertificateEntity {
  const factory CertificateEntity({
    final String? id,
    final String? fileExtension
  }) = _CertificateEntity;

  factory CertificateEntity.fromJson(Map<String, dynamic> json) =>
      _$CertificateEntityFromJson(json);
}