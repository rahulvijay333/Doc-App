part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingEvent {}

class OnBoardPatientEvent extends OnBoardingEvent {
  final String token;

  final PatientProfileFormData patientform;

  OnBoardPatientEvent({required this.token, required this.patientform});
}

class OnBoardDoctorEvent extends OnBoardingEvent {
  final String token;

  final DoctorProfileFormData doctorform;

  OnBoardDoctorEvent({required this.token, required this.doctorform});
}

class ClearOnboardingState extends OnBoardingEvent {}
