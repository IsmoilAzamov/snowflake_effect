

import 'package:my_ihma/client/data/error_handler/error_handler.dart';
import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';
import 'package:my_ihma/client/domain/repositories/manual_repository.dart';
import 'package:my_ihma/core/resources/datastate.dart';

import '../datasources/remote/manual_api_service.dart';

class ManualRepositoryImpl extends ManualRepository{
  final ManualApiService _manualApiService;

  ManualRepositoryImpl({required ManualApiService manualApiService}):
    _manualApiService = manualApiService;

  @override
  Future<DataState<List<TypeEntity>>> getRegionSelectList()=>getCheckedResponse(()=>_manualApiService.getRegionSelectList());

  @override
  Future<DataState<List<ApplicationModuleEntity>>> getApplicationModule() => getCheckedResponse(() => _manualApiService.getApplicationModule());

  @override
  Future<DataState<List<TypeEntity>>> documentTypeSelectList() => getCheckedResponse(() => _manualApiService.documentTypeSelectList());

}