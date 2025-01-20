import 'package:my_ihma/client/domain/entities/login_request_entity/login_request_entity.dart';

import '../../../core/resources/datastate.dart';

abstract class AccountRepository {
  Future<DataState<bool>> askUserRegister( LoginRequestEntity form);
}
