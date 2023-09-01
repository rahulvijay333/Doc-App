part of 'otp_verify_bloc.dart';

class OtpVerifyState {}

class OtpVerifyInitial extends OtpVerifyState {}

class OtpVerifyLoading extends OtpVerifyState {}

class OtpVerifySuccess extends OtpVerifyState {}

class OtpVerifyFailure extends OtpVerifyState {
  final String error;

  OtpVerifyFailure({required this.error});
}
