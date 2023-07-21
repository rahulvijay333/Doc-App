part of 'login_bloc.dart';

class LoginState {}

class LoginIntial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSucess extends LoginState {
  final String? role;
  final String? name;
 
  

  LoginSucess(   {required this.role,this.name,});
}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed(this.error);
}

class LogoutSucess extends LoginState {}

class LogOutFailed extends LoginState {}

class LogoutLoading extends LoginState {}
