part of 'home_appointment_today_bloc.dart';

class HomeAppointmentTodayState {}

class HomeAppointmentTodayInitial extends HomeAppointmentTodayState {}

class TodayAppointmentLoading extends HomeAppointmentTodayState {}

class TodayAppointmentSuccess extends HomeAppointmentTodayState {
  final List<Appointment> appointmentList;

  TodayAppointmentSuccess({required this.appointmentList});
}

class TodayAppointmentFailed extends HomeAppointmentTodayState {
  final String error;

  TodayAppointmentFailed({required this.error});
}
