part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent {}

class ForgotPasswordCall extends ForgotPasswordEvent {
  final String message, userType;

  ForgotPasswordCall({required this.message, required this.userType});
}

class EnterPasswordCall extends ForgotPasswordEvent {
  final String email;
  final String userType;

  EnterPasswordCall({required this.email, required this.userType});
}



class NewPasswordResetCall extends ForgotPasswordEvent {
  final String password, confirmedPassword, email, token, userType;

  NewPasswordResetCall(
      {required this.password,
      required this.confirmedPassword,
      required this.email,
      required this.token,
      required this.userType});
}


class ClearForgotPasswordState extends ForgotPasswordEvent {}
