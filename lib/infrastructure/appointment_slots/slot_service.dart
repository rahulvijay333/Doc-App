import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/available_slot_response/available_slot_response.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

class AppointmentSlotService {
  final SecureStorageService getToken = getIt<SecureStorageService>();
  Future<(String, AvailableSlotResponse?)> getslotsByDate(
      {required String date}) async {
    final String? token = await getToken.retrieveToken();
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

  Future<String> addSlot({
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    try {
      final SecureStorageService getToken = getIt<SecureStorageService>();
      final String? token = await getToken.retrieveToken();

      final Response response = await Dio().post(ApiEndPoints.addDoctorSlots,
          data: jsonEncode({
            "date": date,
            "slots": [
              {"startTime": startTime, "endTime": endTime}
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

  Future<String> deleteSlot({
    required String mainSlotID,
    required String slodID,
  }) async {
    final String? token = await getToken.retrieveToken();
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
