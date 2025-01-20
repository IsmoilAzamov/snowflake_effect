import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/data/datasources/local/regions_db_service.dart';

import '../../../../main.dart';
import '../../../data/datasources/local/brands_db_service.dart';
import '../../../data/datasources/local/countries_db_service.dart';
import '../../../domain/entities/type/type_entity.dart';
import 'filter_widget_event.dart';
import 'filter_widget_state.dart';

class FilterWidgetBloc extends Bloc<FilterWidgetEvent, FilterWidgetState> {
  final RegionsDBService _regionsDBService;
  final CountriesDBService _countriesDBService;

  final BrandsDBService _brandsDBService;

  FilterWidgetBloc(
      this._regionsDBService, this._countriesDBService, this._brandsDBService)
      : super(FilterWidgetLoadingState()) {
    on<FilterWidgetLoadEvent>(_init);
  }

  _init(FilterWidgetLoadEvent event, Emitter<FilterWidgetState> emit) async {
    emit(FilterWidgetLoadingState());
    final regions = await _regionsDBService.getRegions();
    final countries = await _countriesDBService.getCountries();
    final brands = await _brandsDBService.getBrands();

    // change list<dynamic> to list<TypeEntity>
    final regionsList = regions.map((e) {
      print(e);
      return TypeEntity.fromJson(e.toJson());
    }).toList();

    final countriesList = countries.map((e) {
      print("countries: $e");
      return TypeEntity.fromJson(e.toJson());
    }).toList();

    final brandsList = brands.map((e) {
      print("brands: $e");
      return TypeEntity.fromJson(e.toJson());
    }).toList();

    emit(FilterWidgetLoadedState(
        regions: regionsList, countries: countriesList, brands: brandsList));
  }
}
