// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterEntityImpl _$$FilterEntityImplFromJson(Map<String, dynamic> json) =>
    _$FilterEntityImpl(
      brands: (json['brands'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      countryIds: (json['countryIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      maxPrice: (json['maxPrice'] as num?)?.toInt() ?? 10000000000,
      minPrice: (json['minPrice'] as num?)?.toInt() ?? 0,
      orderType: json['orderType'] as String? ?? '',
      page: (json['page'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
      pomClassificatorIds: (json['pomClassificatorIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      regionIds: (json['regionIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      search: json['search'] as String? ?? '',
      sortBy: json['sortBy'] as String? ?? '',
      total: (json['total'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FilterEntityImplToJson(_$FilterEntityImpl instance) =>
    <String, dynamic>{
      'brands': instance.brands,
      'countryIds': instance.countryIds,
      'maxPrice': instance.maxPrice,
      'minPrice': instance.minPrice,
      'orderType': instance.orderType,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pomClassificatorIds': instance.pomClassificatorIds,
      'regionIds': instance.regionIds,
      'search': instance.search,
      'sortBy': instance.sortBy,
      'total': instance.total,
    };
