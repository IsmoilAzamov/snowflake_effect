import 'dart:io';


import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/resources/datastate.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/widgets/toasts.dart';

DioException errorHandler(DioException e) {

  if(e is SocketException){
    showErrorToast('no_internet'.tr());
  }
  // print(e.requestOptions.path);

  try {
    if (e.response?.statusCode == 401) {
      // showErrorToast('unauthorized'.tr());
      return DioException(error: 'unauthorized'.tr(), requestOptions: RequestOptions(path: ''));
    }
    if (e.error is SocketException) {
      // Handling SocketException separately
      return e;
    } else if (e.response?.data != null) {
      if (e.response?.data?.toString().contains('errors') ?? false) {
        final errors = e.response!.data['errors'];
        if (errors != null) {
          for (var key in errors.keys) {
            final errorMessage = errors[key][0];
            showErrorToast(errorMessage);
            // print('Validation Error: Message - $errorMessage');

            // Creating a new DioException for validation error
            e = DioException(error: errorMessage, requestOptions: RequestOptions(path: ''));
            return (e);
          }
        }
      }
    }

    // If it's not a validation error or any specific key, return the original error
    // print('Error: ${e.error}--------------------------');
    return (e);
  } on Error catch (handleError) {
    // print('Error: $handleError at errorHandler');
    // print(e.stackTrace);
    //   writeLogsToStorage(handleError.toString());

    return (e);
  }
}


Future<DataState<T>> getCheckedResponse<T>(
    Future<HttpResponse<T>> Function() func) async {
  try {
    // print("-----------------------------");

    HttpResponse response = await func();
    // print("-----------------------------");
    // print(response.data);
    if (response.response.statusCode == 200) {
      return DataSuccess(response.data);
    } else {
      DioException error = errorHandler(DioException(
        response: response.response,
        requestOptions: response.response.requestOptions,
        message: response.response.statusMessage ?? "Unknown error",
      ));
      // print("Error during request: ${response.response.requestOptions.uri}");
      return DataError(error);
    }
  } on DioException catch (e) {
    DioException error = errorHandler(e);
    // print("DioException: ${e.message}");
    // print("Request options: ${e.requestOptions.uri}");
    // print("Response: ${e.response}");
    // print("Error: ${e.error}");
    // print("StackTrace: ${e.stackTrace}");
    return DataError(error);
  }
}
