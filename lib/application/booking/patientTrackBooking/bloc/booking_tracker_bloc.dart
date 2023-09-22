import 'dart:developer';

import 'package:appoint_medic/domain/models/appointment_booked_response/appointment_booked_response.dart';
import 'package:appoint_medic/domain/models/bookingDetails/booking_details.dart';
import 'package:appoint_medic/domain/response_models/doctors_response_model/doctor.dart';
import 'package:appoint_medic/infrastructure/booking/booking_service.dart';
import 'package:appoint_medic/infrastructure/payment_razorpay/payment_service.dart';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../domain/response_models/profile_model/user.dart';

part 'booking_tracker_event.dart';
part 'booking_tracker_state.dart';

//-----------------------------------used for tracking user booking details
class BookingTrackerBloc
    extends Bloc<BookingTrackerEvent, BookingTrackerState> {
  final BookingService bookingService;
  final PaymentService paymentService = GetIt.instance<PaymentService>();

  BookingTrackerBloc(
    this.bookingService,
  ) : super(BookingTrackerInitial()) {
    on<BookingSelectSlot>((event, emit) {
      emit(BookingTrackerLoading());

      emit(BookingTrackerSelected(
          bookingDetails: event.bookingDetails, doct: event.doct));
    });
    //----------------------------------------------------------------event to get order id for payment call - required
    on<BookingStartApiCallOrderID>((event, emit) async {
      //---------------------------loading
      emit(Bookingloading());

      final (error, response) = await bookingService.startBooking(
          bookingDetails: event.bookingDetails);

      if (error.isEmpty) {
        

        final updatedBookingDetails = BookingDetails(
            doctorID: event.bookingDetails.doctorID,
            dateID: event.bookingDetails.dateID,
            slotID: event.bookingDetails.slotID,
            startTime: event.bookingDetails.startTime,
            endTime: event.bookingDetails.endTime,
            orderID: response!.order!.id!,
            fees: int.parse(event.bookingDetails.fees.toString()),
            date: event.bookingDetails.date);

        emit(BookingGotOrderID(
            bookingDetails: updatedBookingDetails, doct: event.doct));
      } else {
        log('Getting order failed $error');

        emit(BookingOrderIDFailed(error));

        await Future.delayed(Duration(seconds: 1));

        emit(BookingTrackerInitial());
      }
    });

//once razor payment sucess , this event is called from screen
//------------------------------------------------------------------------------------sucess
    on<BookingSucessPayment>((event, emit) async {
      //emit loading state
      emit(BookingStatusLoading());

      final (error, response) = await bookingService.createAppointment(
          bookingDetails: event.bookingdetails);

      await Future.delayed(const Duration(seconds: 5));

      //-------------------------date formating
      final dateTime = DateTime.parse(event.bookingdetails.date);
      final formattedDate = DateFormat('d MMM, y').format(dateTime);
      //----------------------------<<<<<<<<<..........................

      if (error.isEmpty) {
        emit(BookingSucess(
            bookingDetails: response!,
            doct: event.doctor,
            patientdetails: event.patientDetails,
            date: formattedDate));
      } else {
        emit(BookingFailed(error));
      }
    });

//----------------------------------------------------------razoray start
    

    on<BookingTrackClear>((event, emit) {
      log('cleared track');
      emit(BookingTrackerInitial());
    });
  }
}
