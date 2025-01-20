




import 'package:my_ihma/client/domain/entities/application_module/application_module_entity.dart';

import '../../../../../main.dart';

class ApplicationModulesDBService {
  final List<dynamic> _applicationModules = box.get('applicationModules', defaultValue: <ApplicationModuleEntity>[]);

  Future<void> putApplicationModules(List<ApplicationModuleEntity> applicationModules) async {
    _applicationModules.clear();
    _applicationModules.addAll(applicationModules);
    await box.put('applicationModules', _applicationModules);
  }


  Future<List<dynamic>> getApplicationModules() async {
    return _applicationModules;
  }


  Future<void> deleteApplicationModules() async {
    _applicationModules.clear();
    await box.put('applicationModules', _applicationModules);
  }

  Future<int> getApplicationModulesCount() async {
    return _applicationModules.length;
  }

  Future<void> deleteBrandById(int id) async {
    _applicationModules.removeWhere((element) => element.id == id);
    await box.put('applicationModules', _applicationModules);
  }
}