




import 'package:my_ihma/client/domain/entities/type/type_entity.dart';

import '../../../../../main.dart';

class BrandsDBService {
  final List<dynamic> _brands = box.get('brands', defaultValue: <TypeEntity>[]);

  Future<void> putBrands(List<TypeEntity> brands) async {
    _brands.clear();
    _brands.addAll(brands);
    await box.put('brands', _brands);
  }


  Future<List<dynamic>> getBrands() async {
    return _brands;
  }


  Future<void> deleteBrands() async {
    _brands.clear();
    await box.put('brands', _brands);
  }

  Future<int> getBrandsCount() async {
    return _brands.length;
  }

  Future<void> deleteBrandById(int id) async {
    _brands.removeWhere((element) => element.id == id);
    await box.put('brands', _brands);
  }
}