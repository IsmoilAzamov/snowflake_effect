import 'package:dio/dio.dart';
import 'package:my_ihma/client/domain/entities/product/product_entity.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/urls.dart';

part 'product_api_service.g.dart';

@RestApi(baseUrl: DOMAIN)
abstract class ProductApiService {
  factory ProductApiService(Dio dio) {
    return _ProductApiService(dio);
  }

  @POST('/api/Pom/Product/GetList')
  Future<HttpResponse<String>> getList({@Body() required Map<String, dynamic> dto});

  @GET('/api/Pom/Product/GetAvailableCountrySelectList')
  Future<HttpResponse<List<TypeEntity>>> getAvailableCountrySelectList();

  @GET('/api/Pom/Product/GetAvailableBrandSelectList')
  Future<HttpResponse<List<TypeEntity>>> getAvailableBrandSelectList();

  @GET('/api/Pom/Product/GetById')
  Future<HttpResponse<ProductEntity>> getById({@Query("productId2") required String productId2});

  @POST('/api/Pom/Product/GetSimilarList')
  Future<HttpResponse<String>> getSimilarList({@Body() required Map<String, dynamic> dto});
}
