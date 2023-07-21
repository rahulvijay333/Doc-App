
abstract class AuthenticationService {
  Future<void> saveRole(String role);
  Future<void> saveToken(String token);
  Future<void> saveLoggedInState(bool loggedIn);
  bool getLoggedInState();
  String? getRole();
  String? getToken();

 
}
