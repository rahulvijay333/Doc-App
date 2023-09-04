import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/available_slot_response/available_slot_response.dart';
import 'package:dio/dio.dart';

class AppointmentSlotService {
  Future<(String, AvailableSlotResponse?)> getslotsByDate(
      {required String date, required String token}) async {
    try {
      final Response response = await Dio().get(ApiEndPoints.getDoctorSlots,
          queryParameters: {"date": date},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode == 200) {
      
        return ('', AvailableSlotResponse.fromJson(response.data));
      } else {
        return ('Error in slot service', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response?.statusCode == 500) {
          return ('Error from  server', null);
        } else {
          return ('Some error excpt', null);
        }
      }
      return ('Some error excpt', null);
    }
  }

  Future<String> addSlot(
      {required String date,
      required String startTime,
      required String endTime,
      required String token}) async {
    try {
    

      String formattedStartTime = startTime.replaceAll('\u202f', ' ');
      String formattedEndTime = endTime.replaceAll('\u202f', ' ');
      final Response response = await Dio().post(ApiEndPoints.addDoctorSlots,
          data: jsonEncode({
            "date": date,
            "slots": [
              {"startTime": formattedStartTime, "endTime": formattedEndTime}
            ]
          }),
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode == 201) {
        return "";
      } else {
        return "Error occured in service";
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check Internet Connectivity');
        } else if (e.response?.statusCode == 500) {
          return (e.response!.statusMessage!);
        } else if (e.response?.statusCode == 400) {
          return (e.response!.statusMessage!);
        } else if (e.response?.statusCode == 404) {
          return (e.response!.statusMessage!);
        } else {
          return ('Some error excpt');
        }
      }
      return ('Some error excpt');
    }
  }

  Future<String> deleteSlot(
      {required String mainSlotID,
      required String slodID,
      required String token}) async {
    try {
      final Response response = await Dio()
          .delete('${ApiEndPoints.deleteSlot}$mainSlotID/slots/$slodID',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200) {
     
        return '';
      } else {
        return 'Error happend in Api call';
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check Internet Connectivity');
        } else if (e.response?.statusCode == 500) {
          return (e.response!.statusMessage!);
        } else if (e.response?.statusCode == 400) {
          return (e.response!.statusMessage!);
        } else if (e.response?.statusCode == 404) {
          return (e.response!.statusMessage!);
        }
      }
      return ('Some error excpt'); //return ('Some error excpt');
    }
  }
}
