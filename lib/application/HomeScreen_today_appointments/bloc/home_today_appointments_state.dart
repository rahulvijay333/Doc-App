part of 'home_today_appointments_bloc.dart';

class HomeTodayAppointmentsState {}

class HomeTodayAppointmentsInitial extends HomeTodayAppointmentsState {}

class HomeTodayAppointsLoading extends HomeTodayAppointmentsState {}

class HomeTodayAppointsSuccess extends HomeTodayAppointmentsState {
  final List<Appointment> appointmentList;

  HomeTodayAppointsSuccess({required this.appointmentList});
}

class HomeTodayAppointsFailure extends HomeTodayAppointmentsState {
  final String error;

  HomeTodayAppointsFailure({required this.error});
}
