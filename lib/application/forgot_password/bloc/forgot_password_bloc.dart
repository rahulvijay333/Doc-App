import 'dart:developer';

import 'package:appoint_medic/infrastructure/forgot_password/forgot_pass_service.dart';
import 'package:bloc/bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final PasswordResetService passwordResetService;
  ForgotPasswordBloc(this.passwordResetService)
      : super(ForgotPasswordInitial()) {
    //enter email
    on<ForgotPasswordCall>((event, emit) {
      emit(ForgotPasswordEnterEmail());
    });
    //enter password
    on<EnterPasswordCall>((event, emit) async {
      //call api to get token

      emit(EmailCheckingLoading());

      final (error, response) = await passwordResetService
          .getPasswordResetToken(email: event.email, userType: event.userType);

      if (error.isEmpty) {
        await Future.delayed(const Duration(seconds: 2));
        emit(ForgotPasswordEnterPasswords(
            email: event.email, token: response!, userType: event.userType));
      } else {
        await Future.delayed(const Duration(seconds: 3));
        emit(ResetEmailError(error: error));

        await Future.delayed(Duration(seconds: 1));
        emit(ForgotPasswordEnterEmail());
      }
    });

    on<NewPasswordResetCall>((event, emit) async {
      emit(NewPasswordLoading());

      final response = await passwordResetService.resetPassword(
          password: event.password,
          confirmPassword: event.confirmedPassword,
          token: event.token,
          usertype: event.userType);

      if (response.isEmpty) {
        await Future.delayed(const Duration(seconds: 2));

        emit(PasswordChangeSuccess());
      } else {
        await Future.delayed(const Duration(seconds: 2));
        emit(PasswordChangeFailed(error: response));
      }
    });

    on<ClearForgotPasswordState>((event, emit) {
      emit(ForgotPasswordInitial());
    });
  }
}
