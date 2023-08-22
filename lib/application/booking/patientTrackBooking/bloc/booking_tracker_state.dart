part of 'booking_tracker_bloc.dart';

class BookingTrackerState {}

class BookingTrackerInitial extends BookingTrackerState {}

class BookingTrackerLoading extends BookingTrackerState {}

class BookingTrackerSelected extends BookingTrackerState {
  final BookingDetails bookingDetails;

  final Doctor doct;

  BookingTrackerSelected({
    required this.bookingDetails,
    required this.doct,
  });
}

class Bookingloading extends BookingTrackerState {}

//contains orderid
class BookingGotOrderID extends BookingTrackerState {
  final BookingDetails bookingDetails;

  final Doctor doct;

  BookingGotOrderID({required this.bookingDetails, required this.doct});
}

class BookingOrderIDFailed extends BookingTrackerState {
  final String error;

  BookingOrderIDFailed(this.error);
}

//--------------------------------------------------------------------------------after suceessful payemnt states
class BookingStatusLoading extends BookingTrackerState {}

class BookingSucess extends BookingTrackerState {
  final AppointmentBookedResponse bookingDetails;
  final Doctor doct;
  final User patientdetails;
  final String date;

  BookingSucess({
    required this.bookingDetails,
    required this.doct,
    required this.patientdetails,
    required this.date,
  });
}

class BookingFailed extends BookingTrackerState {
  final String errorMessage;

  BookingFailed(this.errorMessage);
}
