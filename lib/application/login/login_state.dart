part of 'login_bloc.dart';

class LoginState {}

class LoginIntial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginOnBordingPatient extends LoginState {
  final String token;

  LoginOnBordingPatient({required this.token});
}

class LoginOnBordingDoctor extends LoginState {
  final String token;

  LoginOnBordingDoctor({required this.token});
}

class LoginAdminVerificationSate extends LoginState {}

class LoginSucess extends LoginState {
  final String? role;
  final String? name;
  final String? id;
  final String? token;

  LoginSucess({
    required this.role,
    this.name,
    this.id,
    this.token,
  });
}

class LoginFailed extends LoginState {
  final String error;

  LoginFailed(this.error);
}

class LogoutSucess extends LoginState {}

class LogOutFailed extends LoginState {}

class LogoutLoading extends LoginState {}
