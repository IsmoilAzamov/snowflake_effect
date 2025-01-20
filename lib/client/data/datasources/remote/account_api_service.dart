
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/urls.dart';

part 'account_api_service.g.dart';

@RestApi(baseUrl: DOMAIN)
abstract class AccountApiService {
  factory AccountApiService(Dio dio) {
    return _AccountApiService(dio);
  }

  @POST('/api/Account/AskUserRegister')
  Future<HttpResponse<bool>> askUserRegister({@Body() required Map<String, dynamic> dto});




}
