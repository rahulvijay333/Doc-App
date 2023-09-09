import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/view_appointments_page/doctor_side/view_all_app_doct_side_model/view_all_app_doct_side_model.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

class ViewAppointmentsDoctSideService {
  final SecureStorageService getToken = getIt<SecureStorageService>();
 
  Future<(String, ViewAllAppDoctSideModel?)> getAllAppointmentsDoctSide(
      {required String status}) async {
    final String? token = await getToken.retrieveToken();
    try {
      final response = await Dio().get(ApiEndPoints.doctGetAllAppoints,
          queryParameters: {"status": status},
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode == 200) {
        return ('', ViewAllAppDoctSideModel.fromJson(response.data));
      } else {
        return ('Error status code is not 200', null);
      }
    } catch (e) {
      if (e is DioException) {
      
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
      
        return ('Api Call Error Service', null);
      }
    }
  }

  //cancellng appointment
  Future<String> cancelBooking({required String bookingID}) async {
    final String? token = await getToken.retrieveToken();
    try {
    
      final response =
          await Dio().put('${ApiEndPoints.doctCancelBooking}/$bookingID/cancel',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200) {
       
        return ('');
      } else {
        return ('Error status code is not 200');
      }
    } catch (e) {
      if (e is DioException) {
        log(e.message.toString());
        if (e.error is SocketException) {
          return ('Internet connection Error');
        } else if (e.response!.statusCode == 404) {
          return ('No Doctors , Soon will be added');
        } else if (e.response!.statusCode == 500) {
          return ('Internal Server Error');
        } else {
          return ('Server Connection Failed');
        }
      } else {
        //log('exception Service');
        return ('Api Call Error Service');
      }
    }
  }

  //approving the apppointment
  Future<String> approveBooking({required String bookingID}) async {
    final String? token = await getToken.retrieveToken();
    try {
     
      final response = await Dio()
          .put('${ApiEndPoints.doctApproveBooking}/$bookingID/approve',
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200) {
        
        return ('');
      } else {
        return ('Error status code is not 200');
      }
    } catch (e) {
      if (e is DioException) {
        log(e.message.toString());
        if (e.error is SocketException) {
          return ('Internet connection Error');
        } else if (e.response!.statusCode == 404) {
          return ('No Doctors , Soon will be added');
        } else if (e.response!.statusCode == 500) {
          return ('Internal Server Error');
        } else {
          return ('Server Connection Failed');
        }
      } else {
        //log('exception Service');
        return ('Api Call Error Service');
      }
    }
  }
}
