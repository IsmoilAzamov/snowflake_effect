




import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';

import '../../../../../main.dart';
import '../../../domain/entities/type/type_entity.dart';

class TypeDBService {

  Future<void> putTypes( {required String tableName,required List<TypeEntity> data}) async {
    await box.put(tableName, data);
  }

  Future<List<TypeEntity>> getTypes({required String tableName}) async {
    return box.get(tableName) ?? [];
  }

  Future<void> deleteTypes({required String tableName}) async {
    await box.delete(tableName);
  }

}