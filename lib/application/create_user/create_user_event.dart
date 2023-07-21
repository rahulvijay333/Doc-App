part of 'create_user_bloc.dart';

abstract class CreateUserEvent {
  const CreateUserEvent();
}

class CreateButtonClicked extends CreateUserEvent {
  final CreateUserModel newUser;
  final String userType;

  CreateButtonClicked({required this.newUser, required this.userType});
}

class InitialiCreateBloc extends CreateUserEvent {}
