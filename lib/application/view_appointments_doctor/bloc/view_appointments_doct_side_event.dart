part of 'view_appointments_doct_side_bloc.dart';

class ViewAppointmentsDoctSideEvent {}

class ViewApptDoctorSideCall extends ViewAppointmentsDoctSideEvent {
  final String status;

  ViewApptDoctorSideCall({required this.status});
}

class ApproveBookingCall extends ViewAppointmentsDoctSideEvent {
  final String bookingID;

  ApproveBookingCall(this.bookingID);
}

class CancelBookingCall extends ViewAppointmentsDoctSideEvent {
  final String bookingID;

  CancelBookingCall(this.bookingID);
}
