part of 'doctor_profile_edit_bloc.dart';

class DoctorProfileEditEvent {}

class DoctorProfileEditCall extends DoctorProfileEditEvent {
  final FormData doctorForm;

  DoctorProfileEditCall({required this.doctorForm});
}

class ClearDoctorEditProcessCall extends DoctorProfileEditEvent {}
