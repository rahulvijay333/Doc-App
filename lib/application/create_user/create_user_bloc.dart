import 'dart:developer';

import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:bloc/bloc.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final CreateServiceImpl createServiceImpl;
  CreateUserBloc(this.createServiceImpl) : super(CreateUserInitial()) {
    on<CreateButtonClicked>((event, emit) async {
      //--------------------------------------------------initial loading
      emit(CreateUserLoading());

      final (error) = await createServiceImpl.createAccount(
          user: event.newUser, userType: event.userType);

      if (error.isEmpty) {
        //------------------------------------------account created sucess
        emit(CreateUserSuccess(
            email: event.newUser.email, userType: event.userType));
      } else {
        emit(CreateUserFailed(errorMessage: error));

        if (emit.isDone) {
          emit(CreateUserInitial());
        }
      }
    });

    on<OtpVerificationCall>((event, emit) async {
      emit(OtpVerificationLoading());
      final response = await createServiceImpl.verifyEmailOtp(
          userType: event.userType, userEmail: event.email, userOTP: event.otp);

      if (response.isEmpty) {
        emit(OtpVerifiedSuccess());
      } else {
        emit(OtpVerifiedFailed(error: response));

        await Future.delayed(Duration(seconds: 2));
        // emit(CreateUserSuccess(email: event.email, userType: event.userType));
         emit(CreateUserInitial());
      }
    });

    on<InitialiCreateBloc>((event, emit) {
      log('cetaed user state cleread');
      emit(CreateUserInitial());
    });
  }
}
