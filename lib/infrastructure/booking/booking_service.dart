import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/booking_doctor_profile_slot_model/booking_doctor_profile_slot_model.dart';
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
}
