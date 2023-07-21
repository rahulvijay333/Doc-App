part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClicked extends LoginEvent {
  final String username;
  final String password;
  final String logintype;

  LoginButtonClicked(this.username, this.password, this.logintype);
}

class LogOutButtonClicked extends LoginEvent {
  final String role;

  LogOutButtonClicked(this.role);
}
