part of 'view_appointments_doct_side_bloc.dart';

class ViewAppointmentsDoctSideState {}

class ViewAppointmentsDoctSideInitial extends ViewAppointmentsDoctSideState {}

class DoctorSideApptsLoading extends ViewAppointmentsDoctSideState {}

class DoctorSideApptsSuccess extends ViewAppointmentsDoctSideState {
  final List<Appointment> appointmentList;

  DoctorSideApptsSuccess({required this.appointmentList});
}

class DoctSideApptsFailed extends ViewAppointmentsDoctSideState {
  final String error;

  DoctSideApptsFailed({required this.error});
}
