import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/data/datasources/local/application_modules_db_service.dart';
import 'package:my_ihma/client/domain/repositories/manual_repository.dart';

import '../../../../../core/resources/datastate.dart';
import '../../../../core/widgets/toasts.dart';
import '../../../../main.dart';
import 'applications_event.dart';
import 'applications_state.dart';

class ApplicationsBloc extends Bloc<ApplicationsEvent, ApplicationsState> {
  final ManualRepository _manualRepository;
  final ApplicationModulesDBService _applicationModulesDBService;

  ApplicationsBloc(this._manualRepository, this._applicationModulesDBService) : super(ApplicationsLoadingState()) {
    on<InitApplicationsEvent>((event, emit) => init(event, emit));
    on<ApplicationsLoadEvent>(_load);
  }

  _load(ApplicationsLoadEvent event, Emitter<ApplicationsState> emit) async {
    emit(ApplicationsLoadingState());
    final result = await _manualRepository.getApplicationModule();

    if (result is DataSuccess && result.data != null) {
      emit(ApplicationsLoadedState(result.data!));
      return;
    } else if (result is DataError) {
      emit(ApplicationsErrorState(result.error?.message ?? "something_went_wrong".tr()));
      return;
    }
    emit(ApplicationsErrorState("something_went_wrong".tr()));
  }

  Future<void> init(InitApplicationsEvent event, Emitter<ApplicationsState> emit) async {
    emit(ApplicationsLoadingState());

    try {
      // Get the last update timestamp
      final String lastUpdatedTimestamp = prefs.getString("lastUpdatedModule") ?? DateTime(2024, 1, 1).toString();
      final bool requiresUpdate = DateTime.now().difference(DateTime.parse(lastUpdatedTimestamp)).inSeconds > 23;

      // Fetch the product list immediately
      final Future<DataState> applicationModuleFuture = _manualRepository.getApplicationModule();

      if (requiresUpdate) {
        // Fetch all required data in parallel
        final futures = await Future.wait([
          applicationModuleFuture,
          _manualRepository.getRegionSelectList(),
          // Uncomment when needed
          // _productRepository.getAvailableCountrySelectList(),
          // _productRepository.getAvailableBrandSelectList(),
        ]);

        // Extract main application module result
        final applicationResult = futures[0] as DataState;

        if (applicationResult is DataSuccess && applicationResult.data != null) {
          // Cache the fetched data
          unawaited(_applicationModulesDBService.putApplicationModules(applicationResult.data!));
          unawaited(prefs.setString("lastUpdatedModule", DateTime.now().toString()));

          // Emit success state with data
          emit(ApplicationsLoadedState(applicationResult.data!));
          return;
        } else if (applicationResult is DataError) {
          _handleDataError(applicationResult, emit);
          return;
        }
      } else {
        // If update is not required, process the product result only
        final result = await applicationModuleFuture;
        if (result is DataSuccess && result.data != null) {
          emit(ApplicationsLoadedState(result.data!));
          return;
        } else if (result is DataError) {
          _handleDataError(result, emit);
          return;
        }
      }

      // Fallback for unexpected issues
      emit(ApplicationsErrorState("something_went_wrong".tr()));
    } catch (e, stackTrace) {
      // Log unexpected errors
      print("Unexpected error: $e");
      print(stackTrace);

      emit(ApplicationsErrorState("something_went_wrong".tr()));
    }
  }

// Helper method to handle DataError
  void _handleDataError(DataError error, Emitter<ApplicationsState> emit) {
    final errorMessage = error.error?.message ?? "something_went_wrong".tr();
    showErrorToast(errorMessage);
    emit(ApplicationsErrorState(errorMessage));
  }
}
