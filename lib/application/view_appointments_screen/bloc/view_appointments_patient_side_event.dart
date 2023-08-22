part of 'view_appointments_patient_side_bloc.dart';

class ViewAppointmentsPatientSideEvent {}

class ViewAllAppoinmentsPatientCall extends ViewAppointmentsPatientSideEvent {
  final String status;

  ViewAllAppoinmentsPatientCall({required this.status});
}
