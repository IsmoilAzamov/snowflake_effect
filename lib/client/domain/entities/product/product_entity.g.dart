// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductEntityImpl _$$ProductEntityImplFromJson(Map<String, dynamic> json) =>
    _$ProductEntityImpl(
      id: (json['id'] as num?)?.toInt(),
      id2: json['id2'] as String?,
      tableId: (json['tableId'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
      pomClassificatorId: (json['pomClassificatorId'] as num?)?.toInt(),
      pomClassificator: json['pomClassificator'] as String?,
      pomClassificatorTechRequirements:
          json['pomClassificatorTechRequirements'] as String?,
      mxikId: (json['mxikId'] as num?)?.toInt(),
      mxik: json['mxik'] as String?,
      isPom: json['isPom'] as bool?,
      contractorId: (json['contractorId'] as num?)?.toInt(),
      contractor: json['contractor'] as String?,
      contractorRegionId: (json['contractorRegionId'] as num?)?.toInt(),
      contractorRegion: json['contractorRegion'] as String?,
      contractorDistrictId: (json['contractorDistrictId'] as num?)?.toInt(),
      contractorDistrict: json['contractorDistrict'] as String?,
      contractorAddress: json['contractorAddress'] as String?,
      contractorDirector: json['contractorDirector'] as String?,
      contractorPhoneNumber: json['contractorPhoneNumber'] as String?,
      title: json['title'] as String?,
      countryId: (json['countryId'] as num?)?.toInt(),
      country: json['country'] as String?,
      brand: json['brand'] as String?,
      minPrice: (json['minPrice'] as num?)?.toInt(),
      maxPrice: (json['maxPrice'] as num?)?.toInt(),
      minDeadlineDays: (json['minDeadlineDays'] as num?)?.toInt(),
      maxDeadlineDays: (json['maxDeadlineDays'] as num?)?.toInt(),
      currencyId: (json['currencyId'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      salesCount: (json['salesCount'] as num?)?.toInt(),
      photoId: json['photoId'] as String?,
      photoFileName: json['photoFileName'] as String?,
      photoFileExtension: json['photoFileExtension'] as String?,
      instruction: json['instruction'] as String?,
      description: json['description'] as String?,
      subsidyAmount: (json['subsidyAmount'] as num?)?.toDouble(),
      subsidyCoeficcient: (json['subsidyCoeficcient'] as num?)?.toDouble(),
      subsidyCalculatedAt: json['subsidyCalculatedAt'] as String?,
      warrantyMonth: (json['warrantyMonth'] as num?)?.toInt(),
      usageDurationMonth: (json['usageDurationMonth'] as num?)?.toInt(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => PhotoEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      certificates: (json['certificates'] as List<dynamic>?)
          ?.map((e) => CertificateEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductEntityImplToJson(_$ProductEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id2': instance.id2,
      'tableId': instance.tableId,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
      'pomClassificatorId': instance.pomClassificatorId,
      'pomClassificator': instance.pomClassificator,
      'pomClassificatorTechRequirements':
          instance.pomClassificatorTechRequirements,
      'mxikId': instance.mxikId,
      'mxik': instance.mxik,
      'isPom': instance.isPom,
      'contractorId': instance.contractorId,
      'contractor': instance.contractor,
      'contractorRegionId': instance.contractorRegionId,
      'contractorRegion': instance.contractorRegion,
      'contractorDistrictId': instance.contractorDistrictId,
      'contractorDistrict': instance.contractorDistrict,
      'contractorAddress': instance.contractorAddress,
      'contractorDirector': instance.contractorDirector,
      'contractorPhoneNumber': instance.contractorPhoneNumber,
      'title': instance.title,
      'countryId': instance.countryId,
      'country': instance.country,
      'brand': instance.brand,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'minDeadlineDays': instance.minDeadlineDays,
      'maxDeadlineDays': instance.maxDeadlineDays,
      'currencyId': instance.currencyId,
      'currency': instance.currency,
      'salesCount': instance.salesCount,
      'photoId': instance.photoId,
      'photoFileName': instance.photoFileName,
      'photoFileExtension': instance.photoFileExtension,
      'instruction': instance.instruction,
      'description': instance.description,
      'subsidyAmount': instance.subsidyAmount,
      'subsidyCoeficcient': instance.subsidyCoeficcient,
      'subsidyCalculatedAt': instance.subsidyCalculatedAt,
      'warrantyMonth': instance.warrantyMonth,
      'usageDurationMonth': instance.usageDurationMonth,
      'photos': instance.photos,
      'certificates': instance.certificates,
    };

_$PhotoEntityImpl _$$PhotoEntityImplFromJson(Map<String, dynamic> json) =>
    _$PhotoEntityImpl(
      id: json['id'] as String?,
      isMain: json['isMain'] as bool?,
      ownerId: (json['ownerId'] as num?)?.toInt(),
      fileName: json['fileName'] as String?,
      fileExtension: json['fileExtension'] as String?,
    );

Map<String, dynamic> _$$PhotoEntityImplToJson(_$PhotoEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isMain': instance.isMain,
      'ownerId': instance.ownerId,
      'fileName': instance.fileName,
      'fileExtension': instance.fileExtension,
    };

_$CertificateEntityImpl _$$CertificateEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$CertificateEntityImpl(
      id: json['id'] as String?,
      fileExtension: json['fileExtension'] as String?,
    );

Map<String, dynamic> _$$CertificateEntityImplToJson(
        _$CertificateEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileExtension': instance.fileExtension,
    };
