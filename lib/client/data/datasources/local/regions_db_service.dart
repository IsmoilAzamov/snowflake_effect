




import 'package:my_ihma/client/domain/entities/type/type_entity.dart';

import '../../../../../main.dart';

class RegionsDBService {
  final List<dynamic> _regions = box.get('regions', defaultValue: <TypeEntity>[]);

  Future<void> putRegions(List<TypeEntity> regions) async {
    _regions.clear();
    _regions.addAll(regions);
    await box.put('regions', _regions);
  }


  Future<List<dynamic>> getRegions() async {
    return _regions;
  }


  Future<void> deleteRegions() async {
    _regions.clear();
    await box.put('regions', _regions);
  }

  Future<int> getRegionsCount() async {
    return _regions.length;
  }

  Future<void> deleteRegionById(int id) async {
    _regions.removeWhere((element) => element.id == id);
    await box.put('regions', _regions);
  }
}