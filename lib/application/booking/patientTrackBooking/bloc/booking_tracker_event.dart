part of 'booking_tracker_bloc.dart';

class BookingTrackerEvent {}

class BookingSelectSlot extends BookingTrackerEvent {
  final BookingDetails bookingDetails;
  final Doctor doct;

  BookingSelectSlot({required this.bookingDetails, required this.doct});
}

class BookingStartApiCallOrderID extends BookingTrackerEvent {
  final BookingDetails bookingDetails;
  final Doctor doct;

  BookingStartApiCallOrderID(
      {required this.bookingDetails, required this.doct});
}

class BookingStartPayment extends BookingTrackerEvent {}

class BookingSucessPayment extends BookingTrackerEvent {
  final BookingDetails bookingdetails;
  final User patientDetails;
  final Doctor doctor;

  BookingSucessPayment(
      {required this.bookingdetails,
      required this.patientDetails,
      required this.doctor});
}

class BookingTrackClear extends BookingTrackerEvent {}
