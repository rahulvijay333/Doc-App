part of 'view_appointments_patient_side_bloc.dart';

class ViewAppointmentsPatientSideState {}

class ViewAppointmentsPatientSideInitial
    extends ViewAppointmentsPatientSideState {}

class AllPatientAppointmentsLoading extends ViewAppointmentsPatientSideState {}

class AllPatientAppointmentsSucess extends ViewAppointmentsPatientSideState {
  final ViewAppointmentPatientSide availableAppoints;

  AllPatientAppointmentsSucess({required this.availableAppoints});
}

class AllPatientAppointmentsFailed extends ViewAppointmentsPatientSideState {
  final String error;

  AllPatientAppointmentsFailed({required this.error});
}
