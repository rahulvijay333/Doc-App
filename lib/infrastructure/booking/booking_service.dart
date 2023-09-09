import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/models/appointment_booked_response/appointment_booked_response.dart';
import 'package:appoint_medic/domain/models/bookingDetails/booking_details.dart';
import 'package:appoint_medic/domain/models/booking_initization_response/booking_initization_response.dart';
import 'package:appoint_medic/domain/response_models/booking_doctor_profile_slot_model/booking_doctor_profile_slot_model.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

class BookingService {
  Future<(String, BookingDoctorProfileSlotModel?)> getDoctorProfileSlot(
      {required String doctorid}) async {
    try {
      final response = await Dio().get(
          '${ApiEndPoints.getDoctorAvailableSlotsByIdPatientSide}/$doctorid');

      if (response.statusCode == 200) {
        return ('', BookingDoctorProfileSlotModel.fromJson(response.data));
      } else {
        return ('Error happened in booking service call', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 500) {
          return ('Issue with server', null);
        } else {
          return ('Some error excpt', null);
        }
      }
      return ('Api call Error in Booking service', null);
    }
  }

//---------------------------------------------------------------------Api call for booking intitiate to get order id
  Future<(String, BookingInitizationResponse?)> startBooking(
      {required BookingDetails bookingDetails}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final response = await Dio().post(ApiEndPoints.bookingInitiate,
          data: jsonEncode({
            "doctorId": bookingDetails.doctorID,
            "dateId": bookingDetails.dateID,
            "slotId": bookingDetails.slotID,
            "startTime": bookingDetails.startTime,
            "endTime": bookingDetails.endTime,
            "fees": bookingDetails.fees,
            // "selectedTime": bookingDetails.date
          }),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

     

      if (response.statusCode == 200) {
        return ('', BookingInitizationResponse.fromJson(response.data));
      } else {
        return ('Error happened in booking initiation Api call', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      }
      return ('Api call Error in Booking service', null);
    }
  }

  //------------------------------------final booking appointment api call after payment sucess

  Future<(String, AppointmentBookedResponse?)> createAppointment(
      {required BookingDetails bookingDetails}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();
    try {
     
    
      final response = await Dio().post(ApiEndPoints.completeBooking,
          data: jsonEncode({
            "doctorId": bookingDetails.doctorID,
            "dateId": bookingDetails.dateID,
            "slotId": bookingDetails.slotID,
            "startTime": bookingDetails.startTime,
            "endTime": bookingDetails.endTime,
            "fees": bookingDetails.fees,
            "paymentId": bookingDetails.paymentid,
            "orderId": bookingDetails.orderID,
            "selectedDate": bookingDetails.date
          }),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

  

      if (response.statusCode == 200) {
    
        return ('', AppointmentBookedResponse.fromJson(response.data));
      } else {
        return ('Error happened in booking initiation Api call', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      }
      return ('Api call Error in Booking service', null);
    }
  }
}
