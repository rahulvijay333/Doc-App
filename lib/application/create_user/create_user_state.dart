part of 'create_user_bloc.dart';

abstract class CreateUserState {
  const CreateUserState();
}

class CreateUserInitial extends CreateUserState {}

class CreateUserLoading extends CreateUserState {}

class CreateUserSuccess extends CreateUserState {}

class CreateUserFailed extends CreateUserState {
  final String errorMessage;

  CreateUserFailed({required this.errorMessage});
}
