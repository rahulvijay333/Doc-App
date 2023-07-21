import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/error/create_error.dart';
import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/domain/registeration.dart';
import 'package:appoint_medic/domain/response_models/admin/admin_response/user.dart';
import 'package:appoint_medic/domain/response_models/signup/new_user_response/new_user_response.dart';
import 'package:dio/dio.dart';

class CreateServiceImpl implements CreateAccountService {
  @override
  Future<(String, NewUserResponse?)> createAccount(
      {required CreateUserModel user, required String userType}) async {
    String apiEndPoint = '';
    dynamic responseData;

    try {
      if (userType == 'doctor') {
        apiEndPoint = ApiEndPoints.doctorNewUser;
      } else if (userType == 'patient') {
        apiEndPoint = ApiEndPoints.patientRegister;
      }

      final dio = Dio();

      //-------------------------------------------------------function to send registerion request

      log(apiEndPoint);
      final response = await dio.post(
        apiEndPoint,
        data: json.encode({
          "name": user.name,
          "email": user.email,
          "password": user.password,
        }),
      );
      // log(response.statusCode.toString());
      // log(response.statusMessage.toString());

      print(response.statusCode);

      //---------------------------------------------------------reponse checking

      if (response.statusCode == 201) {
        return ('', NewUserResponse.fromJson(response.data));
      } else {
        return ('Error in service implemention', null);
      }
      //----------------------------------------error - verify admin or email verify
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          // Handle socket error here
          log('Socket error occurred: ${error.error}');

          return ('Error connecting to end point', null);
        } else {
          final errorModel = CreateError.fromJson(error.response!.data);
          print('Dio error occurred: ${errorModel}');
          return (errorModel.error, null);
        }
      }

      log(error.toString());
      log('Error is createUser service implementation call');

      return ('Some error occurred in api call', null);
    }
  }
}
