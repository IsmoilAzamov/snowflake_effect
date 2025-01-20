

import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';
import 'package:my_ihma/client/domain/entities/type/type_entity.dart';
import 'package:my_ihma/core/resources/datastate.dart';

abstract class ManualRepository {
  Future<DataState<List<TypeEntity>>> getRegionSelectList();

  Future<DataState<List<ApplicationModuleEntity>>>  getApplicationModule();

  Future<DataState<List<TypeEntity>>> documentTypeSelectList();
}