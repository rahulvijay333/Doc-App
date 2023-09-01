part of 'otp_verify_bloc.dart';

class OtpVerifyEvent {}

class OtpVerifyCall extends OtpVerifyEvent {
  final String email;
  final String otp;
  final String userType;

  OtpVerifyCall(
      {required this.email, required this.otp, required this.userType});
}

class ClearOtpVerifyState extends OtpVerifyEvent {}
