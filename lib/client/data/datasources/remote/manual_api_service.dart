
import 'package:dio/dio.dart';
import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/urls.dart';

part 'manual_api_service.g.dart';

@RestApi(baseUrl: DOMAIN)
abstract class ManualApiService {
  factory ManualApiService(Dio dio) {
    return _ManualApiService(dio);
  }

  @GET('/api/Manual/RegionSelectList')
  Future<HttpResponse<List<TypeEntity>>> getRegionSelectList();

  @GET('/api/Manual/Ins/GetApplicationModule')
  Future<HttpResponse<List<ApplicationModuleEntity>>> getApplicationModule();

  @GET('/api/Manual/DocumentTypeSelectList')
  Future<HttpResponse<List<TypeEntity>>> documentTypeSelectList();


}
