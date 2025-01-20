


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';

import '../../../core/resources/datastate.dart';
import '../../../main.dart';
import '../../domain/entities/filter/filter_entity.dart';
import '../../domain/entities/product/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/remote/product_api_service.dart';
import '../error_handler/error_handler.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService _productApiService;

  ProductRepositoryImpl(this._productApiService);

  @override
  Future<DataState<List<ProductEntity>>> getList(FilterEntity filter) async {
    // {"orderType":"asc","page":1,"pageSize":20,"search":"","totalRows":0,"sortBy":"","districtId":null,"mfyId":null,"regionId":null,"individualPlanExists":true}
    Map<String, dynamic> dto = filter.toJson();
    try {
      var response = (await _productApiService.getList(
        dto: dto,
      ));
      Map<String, dynamic> data = jsonDecode(response.data.toString());

      List<ProductEntity> products = [];
      try {
        await box.put('totalProductsCount', data['total'] as int?);
      } on Error catch (e) {
        print(e);
        print(e.stackTrace);
      }
      data['rows'].forEach((element) {
        products.add(ProductEntity.fromJson(element));
      });

      return DataSuccess(products);
    } on DioException catch (e) {
      DioException error = errorHandler(e);
      return DataError(error);
    }
  }

  @override
  Future<DataState<List<TypeEntity>>> getAvailableCountrySelectList() => getCheckedResponse(() => _productApiService.getAvailableCountrySelectList());

  @override
  Future<DataState<List<TypeEntity>>> getAvailableBrandSelectList() => getCheckedResponse(() => _productApiService.getAvailableBrandSelectList());

  @override
  Future<DataState<ProductEntity>> getById({required String productId}) => getCheckedResponse(()=> _productApiService.getById(productId2: productId));

  @override
  Future<DataState<List<ProductEntity>>> getSimilarList({required String productId, required int page, required int pageSize}) async {
    // {"orderType":"asc","page":1,"pageSize":20,"search":"","totalRows":0,"sortBy":"","districtId":null,"mfyId":null,"regionId":null,"individualPlanExists":true}
    Map<String, dynamic> dto = {
      "page": page,
      "pageSize": pageSize,
      "productId2": productId,
      "total":1

    };
    try {
      var response = (await _productApiService.getSimilarList(
        dto: dto,
      ));
      Map<String, dynamic> data = jsonDecode(response.data.toString());

      List<ProductEntity> products = [];
      try {
        await box.put('totalProductsCount', data['total'] as int?);
      } on Error catch (e) {
        print(e);
        print(e.stackTrace);
      }
      data['rows'].forEach((element) {
        products.add(ProductEntity.fromJson(element));
      });

      return DataSuccess(products);
    } on DioException catch (e) {
      DioException error = errorHandler(e);
      return DataError(error);
    }
  }
}