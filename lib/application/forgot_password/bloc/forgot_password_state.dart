part of 'forgot_password_bloc.dart';

class ForgotPasswordState {}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordEnterEmail extends ForgotPasswordState {}

class ForgotPasswordEnterPasswords extends ForgotPasswordState {
  final String email;
  final String token;
  final String userType;

  ForgotPasswordEnterPasswords({
    required this.email,
    required this.token,
    required this.userType,
  });
}

class EmailCheckingLoading extends ForgotPasswordState {}

class NewPasswordLoading extends ForgotPasswordState {}

class ResetEmailError extends ForgotPasswordState {
  final String error;

  ResetEmailError({required this.error});
}

class PasswordChangeSuccess extends ForgotPasswordState {}

class PasswordChangeFailed extends ForgotPasswordState {
  final String error;

  PasswordChangeFailed({required this.error});
}
