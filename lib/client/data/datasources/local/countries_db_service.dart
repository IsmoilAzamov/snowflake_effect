




import 'package:my_ihma/client/domain/entities/type/type_entity.dart';

import '../../../../../main.dart';

class CountriesDBService {
  final List<dynamic> _countries = box.get('countries', defaultValue: <TypeEntity>[]);

  Future<void> putCountries(List<TypeEntity> countries) async {
    _countries.clear();
    _countries.addAll(countries);
    await box.put('countries', _countries);
  }


  Future<List<dynamic>> getCountries() async {
    return _countries;
  }


  Future<void> deleteCountries() async {
    _countries.clear();
    await box.put('countries', _countries);
  }

  Future<int> getCountriesCount() async {
    return _countries.length;
  }

  Future<void> deleteCountryById(int id) async {
    _countries.removeWhere((element) => element.id == id);
    await box.put('countries', _countries);
  }
}