import 'package:my_ihma/client/data/error_handler/error_handler.dart';
import 'package:my_ihma/client/domain/entities/login_request_entity/login_request_entity.dart';
import 'package:my_ihma/core/resources/datastate.dart';

import '../../domain/repositories/account_repository.dart';
import '../datasources/remote/account_api_service.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountApiService _manualApiService;

  AccountRepositoryImpl({required AccountApiService accountApiService}) : _manualApiService = accountApiService;

  @override
  Future<DataState<bool>> askUserRegister(LoginRequestEntity form) => getCheckedResponse(() => _manualApiService.askUserRegister(dto: form.toJson()));
}
