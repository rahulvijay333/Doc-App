part of 'patient_edit_profile_bloc.dart';

class PatientEditProfileEvent {}

class PatientProfileEditCall extends PatientEditProfileEvent {
  final FormData patientForm;

  PatientProfileEditCall({required this.patientForm});
}

class ClearPatientEditProfileProcess extends PatientEditProfileEvent {}
