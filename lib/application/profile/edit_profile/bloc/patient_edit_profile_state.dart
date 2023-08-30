part of 'patient_edit_profile_bloc.dart';

@immutable
sealed class PatientEditProfileState {}

final class PatientEditProfileInitial extends PatientEditProfileState {}

class PatientProfileEditLoading extends PatientEditProfileState {}

class PatientProfileEditSuccess extends PatientEditProfileState {}

class PatientProfileEditFailed extends PatientEditProfileState {
  final String error;

  PatientProfileEditFailed(this.error);
}
