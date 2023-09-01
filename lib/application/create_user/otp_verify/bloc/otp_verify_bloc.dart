import 'package:appoint_medic/infrastructure/register/register_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  final CreateServiceImpl createServiceImpl;
  OtpVerifyBloc(this.createServiceImpl) : super(OtpVerifyInitial()) {
    on<OtpVerifyCall>((event, emit) async {
      emit(OtpVerifyLoading());

      final response = await createServiceImpl.verifyEmailOtp(
          userType: event.userType, userEmail: event.email, userOTP: event.otp);

      if (response.isEmpty) {
        emit(OtpVerifySuccess());
      } else {
        emit(OtpVerifyFailure(error: response));

        await Future.delayed(Duration(seconds: 2));
        emit(OtpVerifyInitial());
      }
    });

    on<ClearOtpVerifyState>((event, emit) {
      emit(OtpVerifyInitial());
    });
  }
}
