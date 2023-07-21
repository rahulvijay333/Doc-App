import 'response_models/logout/logout_response/logout_response.dart';

abstract class LoginService {
  Future<(String error, dynamic response)> loginButton(
      {required String password,
      required String email,
      required String logintype});

  Future<(String error, LogoutResponse? logout)> logoutButton(
      {required String role});
}
