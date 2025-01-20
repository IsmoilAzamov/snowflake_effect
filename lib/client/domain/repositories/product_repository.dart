

import 'package:my_ihma/client/domain/entities/type/type_entity.dart';

import '../../../core/resources/datastate.dart';
import '../entities/filter/filter_entity.dart';
import '../entities/product/product_entity.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductEntity>>> getList(FilterEntity filter);

  Future<DataState<List<TypeEntity>>> getAvailableCountrySelectList();

  Future<DataState<List<TypeEntity>>> getAvailableBrandSelectList();

  Future<DataState<ProductEntity>>  getById({required String productId});

  Future<DataState<List<ProductEntity>>> getSimilarList({required String productId, required int page, required int pageSize});
}