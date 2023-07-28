import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/get_specialities_response/get_specialities_response.dart';
import 'package:dio/dio.dart';

class SpecialityService {
  Future<(String, GetSpecialitiesResponse?)> getSpeciality() async {
    try {
      final dio = Dio(BaseOptions());

      final Response response = await dio.get(
        ApiEndPoints.getAllSpecialities,
      );

      log('Response Status Code: ${response.statusCode}');
      log('Response Headers: ${response.headers}');
      // // log('Response Data: ${response.data}');

      // final value = DoctorsResponseModel.fromJson(response.data);
      // log(value.toString());

      //log(response);
      if (response.statusCode == 200) {
        log('api categopries call sucess');
        return ('', GetSpecialitiesResponse.fromJson(response.data));
      } else {
        return ('Error happend in ApiCall  service ', null);
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          return ('Internet connection Error', null);
        } else if (error.response!.statusCode == 404) {
          return ('No specialities are available', null);
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
