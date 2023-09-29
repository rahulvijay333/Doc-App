part of 'create_user_bloc.dart';

abstract class CreateUserState {
  const CreateUserState();
}

class CreateUserInitial extends CreateUserState {}

class CreateUserLoading extends CreateUserState {}

class CreateUserSuccess extends CreateUserState {
  final String email;
  final String userType;

  CreateUserSuccess({required this.email, required this.userType});
}

class OtpVerificationLoading extends CreateUserState {
  
}

class OtpVerifiedSuccess extends CreateUserState {

}

class OtpVerifiedFailed extends CreateUserState {
  final String error;

  OtpVerifiedFailed({required this.error});

}

class CreateUserFailed extends CreateUserState {
  final String errorMessage;

  CreateUserFailed({required this.errorMessage});
}
