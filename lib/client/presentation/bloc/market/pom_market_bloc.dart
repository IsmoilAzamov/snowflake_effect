import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/data/datasources/local/regions_db_service.dart';
import 'package:my_ihma/client/domain/entities/filter/filter_entity.dart';
import 'package:my_ihma/client/domain/repositories/manual_repository.dart';
import 'package:my_ihma/client/presentation/bloc/market/pom_market_event.dart';
import 'package:my_ihma/client/presentation/bloc/market/pom_market_state.dart';

import '../../../../../core/resources/datastate.dart';
import '../../../../main.dart';
import '../../../data/datasources/local/brands_db_service.dart';
import '../../../data/datasources/local/countries_db_service.dart';
import '../../../domain/repositories/product_repository.dart';

class PomMarketBloc extends Bloc<PomMarketEvent, PomMarketState> {
  final ProductRepository _productRepository;
  final ManualRepository _manualRepository;
  final RegionsDBService _regionsDBService;
  final CountriesDBService _countriesDBService;
  final BrandsDBService _brandsDBService;

  PomMarketBloc(this._productRepository, this._manualRepository,
      this._regionsDBService, this._countriesDBService, this._brandsDBService)
      : super(PomMarketLoadingState()) {
    on<InitPomMarketEvent>((event, emit) => init(event, emit));
    on<PomMarketLoadEvent>(_load);
  }

  _load(PomMarketLoadEvent event, Emitter<PomMarketState> emit) async {
    emit(PomMarketLoadingState());
    final result = await _productRepository.getList(event.filter);

    if (result is DataSuccess && result.data != null) {
      emit(PomMarketLoadedState(result.data!));
      return;
    } else if (result is DataError) {
      emit(PomMarketErrorState(
          result.error?.message ?? "something_went_wrong".tr()));
      return;
    }
    emit(PomMarketErrorState("something_went_wrong".tr()));
  }

  Future<void> init(
      InitPomMarketEvent event, Emitter<PomMarketState> emit) async {
    emit(PomMarketLoadingState());

    // Get last updated time once
    final String lastUpdatedTime =
        prefs.getString("lastUpdatedTime") ?? DateTime(2024, 1, 1).toString();
    final bool needsUpdate =
        DateTime.now().difference(DateTime.parse(lastUpdatedTime)).inHours > 23;

    try {
      // Start product list fetch immediately
      final productFuture = _productRepository.getList(
        FilterEntity(
          brands: [],
          countryIds: [],
          maxPrice: 10000000000,
          minPrice: 0,
          orderType: "",
          page: 1,
          pageSize: 20,
          pomClassificatorIds: [],
          regionIds: [],
          search: "",
          sortBy: "",
          total: 0,
        ),
      );

      // If update is needed, fetch all data in parallel
      if (needsUpdate) {
        final futures = await Future.wait([
          productFuture,
          _manualRepository.getRegionSelectList(),
          _productRepository.getAvailableCountrySelectList(),
          _productRepository.getAvailableBrandSelectList(),
        ]);

        // Destructure results
        final result = futures[0] as DataState;
        final regionResult = futures[1] as DataState;
        final countryResult = futures[2] as DataState;
        final brandResult = futures[3] as DataState;

        // Process auxiliary data in parallel
        if (regionResult is DataSuccess && regionResult.data != null) {
          unawaited(_regionsDBService.putRegions(regionResult.data!));
        }
        if (countryResult is DataSuccess && countryResult.data != null) {
          unawaited(_countriesDBService.putCountries(countryResult.data!));
        }
        if (brandResult is DataSuccess && brandResult.data != null) {
          unawaited(_brandsDBService.putBrands(brandResult.data!));
        }
        if (regionResult is DataSuccess &&
            countryResult is DataSuccess &&
            brandResult is DataSuccess) {
          unawaited(
              prefs.setString("lastUpdatedTime", DateTime.now().toString()));
        }

        // Handle main product result
        if (result is DataSuccess && result.data != null) {
          emit(PomMarketLoadedState(result.data!));
          return;
        } else if (result is DataError) {
          emit(PomMarketErrorState(
              result.error?.message ?? "something_went_wrong".tr()));
          return;
        }
      } else {
        // If no update needed, just handle product result
        final result = await productFuture;
        if (result is DataSuccess && result.data != null) {
          emit(PomMarketLoadedState(result.data!));
          return;
        } else if (result is DataError) {
          emit(PomMarketErrorState(
              result.error?.message ?? "something_went_wrong".tr()));
          return;
        }
      }

      emit(PomMarketErrorState("something_went_wrong".tr()));
    } catch (e) {
      emit(PomMarketErrorState("something_went_wrong".tr()));
    }
  }
}
