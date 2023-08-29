part of 'doctor_profile_bloc.dart';

class DoctorProfileState {}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileSuccess extends DoctorProfileState {
  final Doctor doctDetails;

  DoctorProfileSuccess({required this.doctDetails});
}

class DoctorPrifleFailure extends DoctorProfileState {
  final String error;

  DoctorPrifleFailure(this.error);
}
