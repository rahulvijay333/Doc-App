import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/view_appointments_page/view_appointment_patient_side/view_appointment_patient_side_bloc.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

class ViewAppointmentsPatientSideService {
  Future<(String, ViewAppointmentPatientSide?)> getAllAppointmentsPatient(
      {required String status}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();
    try {
     
      final response = await Dio().get(ApiEndPoints.getAppointmentList,
          queryParameters: {"status": status},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode == 200) {
   
        return ('', ViewAppointmentPatientSide.fromJson(response.data));
      } else {
        return ('Error status code is not 200', null);
      }
    } catch (e) {
      if (e is DioException) {
        log('error caused');
        if (e.error is SocketException) {
          return ('Internet connection Error', null);
        } else if (e.response!.statusCode == 404) {
          return ('No Doctors , Soon will be added', null);
        } else if (e.response!.statusCode == 500) {
          return ('Internal Server Error', null);
        } else {
          return ('Server Connection Failed', null);
        }
      } else {
        //log('exception Service');
        return ('Api Call Error Service', null);
      }
    }
  }
}
