part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AppStartAuth extends AuthenticationEvent {}

class UserLoggedOut extends AuthenticationEvent {}
