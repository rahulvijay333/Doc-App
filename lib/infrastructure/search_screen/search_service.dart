import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/doctors_response_model/doctors_response_model.dart';
import 'package:dio/dio.dart';

class SearchService {
  Future<(String, DoctorsResponseModel?)> showAllDoctorList() async {
    try {
      final dio = Dio(BaseOptions());

      final Response response =
          await dio.get(ApiEndPoints.patientGetAllDoctors);

      //log(response);
      if (response.statusCode == 200) {
        log('api call sucess searchservice');
        return ('', DoctorsResponseModel.fromJson(response.data));
      } else {
        return ('Error happend in ApiCall ', null);
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          return ('Internet connection Error', null);
        } else {
          log('Service failed');
          return ('Server Connection Failed', null);
        }
      } else {
        log('exception Service');
        return ('Api Call Error Service', null);
      }
    }
  }
  //--------------------------------------------------------------------filter search

  Future<(String, DoctorsResponseModel?)> searchByFilter(
      {String? name, String? gender, String? speciality}) async {
    try {
      final dio = Dio(BaseOptions());
      //log('$name - $gender , $speciality');

      final Response response = await dio.get(ApiEndPoints.patientGetAllDoctors,
          queryParameters: {
            'doctorName': name,
            'gender': gender,
            'specialities': speciality
          });

      //log(response);
      if (response.statusCode == 200) {
        log('api call sucess');
        return ('', DoctorsResponseModel.fromJson(response.data));
      } else {
        return ('Error happend in ApiCall ', null);
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          return ('Internet connection Error', null);
        } else if (error.response!.statusCode == 404) {
          return ('No Doctors , Soon will be added', null);
        } else if (error.response!.statusCode == 500) {
          return ('Internal Server Error', null);
        } else {
          // log(error.response!.statusCode.toString());
          // log(error.toString());
          return ('Server Connection Failed', null);
        }
      } else {
        //log('exception Service');
        return ('Api Call Error Service', null);
      }
    }
  }
}
