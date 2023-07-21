import 'package:appoint_medic/domain/new_user/new_user.dart';

import 'response_models/signup/new_user_response/new_user_response.dart';

abstract class CreateAccountService {
  Future<(String error, NewUserResponse? response)> createAccount(
      {required CreateUserModel user, required String userType});
}
