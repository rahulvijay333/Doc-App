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

      // log('Response Status Code: ${response.statusCode}');
      // log('Response Headers: ${response.headers}');
      // // log('Response Data: ${response.data}');

      // final value = DoctorsResponseModel.fromJson(response.data);
      // log(value.toString());

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
        } else {
          return ('Server Connection Failed', null);
        }
      } else {
        log('exception');
        return ('Api Call Error', null);
      }
    }
  }
}
