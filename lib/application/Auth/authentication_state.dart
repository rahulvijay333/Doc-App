part of 'authentication_bloc.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class Unauthenticated extends AuthenticationState {}

class Autheticated extends AuthenticationState {
  final String role;
  final String token;
  final String name;
  final String id;

  Autheticated(this.role, this.token, this.name, this.id);
}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationError extends AuthenticationState {
  final String errorMessage;

  AuthenticationError(this.errorMessage);
}
