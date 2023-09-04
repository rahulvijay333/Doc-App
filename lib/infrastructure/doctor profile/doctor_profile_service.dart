import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/models/doctor%20profile/doctor_profile_model/doctor_profile_model.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

class DoctorProfileService {
  Future<(String, DoctorProfileModel?)> getDoctorProfile() async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response =
          await Dio().get(ApiEndPoints.getDoctorProfileDetails,
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200) {
       

        try {
          final parseData = DoctorProfileModel.fromJson(response.data);
          return ('', parseData);
        } catch (e) {
          return (
            'Error parsing json data received from server , but status code is 200',
            null
          );
        }
      } else {
        return ('error,status code is not 200', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Server connection failed', null);
        } else if (e.response!.statusCode == 404) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      } else {
        return ('Api call Error in Booking service', null);
      }
    }
  }
}
