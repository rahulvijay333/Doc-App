part of 'create_user_bloc.dart';

abstract class CreateUserEvent {
  const CreateUserEvent();
}

class CreateButtonClicked extends CreateUserEvent {
  final CreateUserModel newUser;
  final String userType;

  CreateButtonClicked({required this.newUser, required this.userType});
}

class OtpVerificationCall extends CreateUserEvent {
  final String email;
  final String otp;
  final String userType;

  OtpVerificationCall({required this.email, required this.otp, required this.userType});


}

class InitialiCreateBloc extends CreateUserEvent {}
