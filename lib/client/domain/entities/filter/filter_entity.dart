import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_entity.freezed.dart';

part 'filter_entity.g.dart';




@freezed
class FilterEntity with _$FilterEntity {
  const factory FilterEntity({
    @Default([]) List<String> brands,
    @Default([]) List<int> countryIds,
    @Default(10000000000) int maxPrice,
    @Default(0) int minPrice,
    @Default('') String orderType,
    @Default(1) int page, // Default page is 1
    @Default(20) int pageSize, // Default page size is 10
    @Default([]) List<int> pomClassificatorIds,
    @Default([]) List<int> regionIds,
    @Default('') String search,
    @Default('') String sortBy,
    @Default(0) int total,
  }) = _FilterEntity;

  factory FilterEntity.fromJson(Map<String, dynamic> json) =>
      _$FilterEntityFromJson(json);
}
