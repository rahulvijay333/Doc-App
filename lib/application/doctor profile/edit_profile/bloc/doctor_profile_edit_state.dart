part of 'doctor_profile_edit_bloc.dart';

class DoctorProfileEditState {}

class DoctorProfileEditInitial extends DoctorProfileEditState {}

class DoctorProfileEditLoading extends DoctorProfileEditState {}

class DoctorProfileEditSuccess extends DoctorProfileEditState {}

class DoctorProfileEditFailed extends DoctorProfileEditState {
  final String error;

  DoctorProfileEditFailed(this.error);
}