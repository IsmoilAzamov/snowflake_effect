import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ihma/client/data/datasources/local/application_modules_db_service.dart';
import 'package:my_ihma/client/data/datasources/local/type_db_service.dart';
import 'package:my_ihma/client/domain/repositories/manual_repository.dart';
import 'package:my_ihma/client/presentation/bloc/login/register/register_event.dart';
import 'package:my_ihma/client/presentation/bloc/login/register/register_state.dart';

import '../../../../../core/resources/datastate.dart';
import '../../../../../core/widgets/toasts.dart';
import '../../../../../main.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final ManualRepository _manualRepository;
  final TypeDBService _typeDBService;

  RegisterBloc(this._manualRepository, this._typeDBService) : super(RegisterLoadingState()) {
    on<InitRegisterEvent>((event, emit) => init(event, emit));
    on<RegisterLoadEvent>(_load);
  }

  _load(RegisterLoadEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    final result = await _manualRepository.documentTypeSelectList();

    if (result is DataSuccess && result.data != null) {
      emit(RegisterLoadedState(result.data!));
      return;
    } else if (result is DataError) {
      emit(RegisterErrorState(result.error?.message ?? "something_went_wrong".tr()));
      return;
    }
    emit(RegisterErrorState("something_went_wrong".tr()));
  }

  Future<void> init(InitRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());

    try {
      // Get the last update timestamp
      final String lastUpdatedTimestamp = prefs.getString("lastUpdatedDocumentTypes") ?? DateTime(2024, 1, 1).toString();
      final bool requiresUpdate = DateTime.now().difference(DateTime.parse(lastUpdatedTimestamp)).inHours > 23;

      // Fetch the product list immediately
      final Future<DataState> applicationModuleFuture = _manualRepository.documentTypeSelectList();

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
        final applicationResult = futures[0];

        if (applicationResult is DataSuccess && applicationResult.data != null) {
          // Cache the fetched data
          unawaited(_typeDBService.putTypes(data:applicationResult.data!,tableName: "documentTypes"));
          unawaited(prefs.setString("lastUpdatedDocumentTypes", DateTime.now().toString()));

          // Emit success state with data
          emit(RegisterLoadedState(applicationResult.data!));
          return;
        } else if (applicationResult is DataError) {
          _handleDataError(applicationResult, emit);
          return;
        }
      } else {
        // If update is not required, process the product result only
        final result = await applicationModuleFuture;
        if (result is DataSuccess && result.data != null) {
          emit(RegisterLoadedState(result.data!));
          return;
        } else if (result is DataError) {
          _handleDataError(result, emit);
          return;
        }
      }

      // Fallback for unexpected issues
      emit(RegisterErrorState("something_went_wrong".tr()));
    } catch (e, stackTrace) {
      // Log unexpected errors
      print("Unexpected error: $e");
      print(stackTrace);

      emit(RegisterErrorState("something_went_wrong".tr()));
    }
  }

// Helper method to handle DataError
  void _handleDataError(DataError error, Emitter<RegisterState> emit) {
    final errorMessage = error.error?.message ?? "something_went_wrong".tr();
    showErrorToast(errorMessage);
    emit(RegisterErrorState(errorMessage));
  }
}
