import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:dio/dio.dart';

class PasswordResetService {
  Future<(String, String?)> getPasswordResetToken(
      {required String email, required String userType}) async {
    String apiEnd = '';

    try {
      if (userType == 'patient') {
        apiEnd = ApiEndPoints.patientResetPassToken;
      } else {
        apiEnd = ApiEndPoints.doctorResetPassToken;
      }
      //----------api call
      final Response response =
          await Dio().put(apiEnd, data: jsonEncode({"email": email}));

//response management

      if (response.statusCode == 200) {
        try {
        
          final String token = response.data['token'];
          return ('', token);
        } catch (e) {
          log('Parsing darta errir');
        }
        return ('Some errior', null);
      } else {
        return ('Api response is success but different status code', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check Internet connectivity', null);
        } else if (e.response!.statusCode == 400) {
          return ('${e.response!.data['errorInfo']}', null);
        } else if (e.response!.statusCode == 404) {
         
          return ('${e.response!.data['errorInfo']}', null);
        } else if (e.response!.statusCode == 500) {
          return ('${e.response!.data['errorInfo']}', null);
        } else {
          return ('Email confirmation failed', null);
        }
      } else {
        return ('Email confirmation failed, try lator', null);
      }
    }
  }

  Future<String> resetPassword(
      {required String password,
      required String confirmPassword,
      required String token,
      required String usertype}) async {
    String apiEnd = '';

    try {
      if (usertype == 'patient') {
        apiEnd = ApiEndPoints.patientResetPassword;
      } else {
        apiEnd = ApiEndPoints.doctorResetPassword;
      }

      final Response response = await Dio().put(apiEnd,
          data: jsonEncode({
            "password": password,
            "confirmPassword": confirmPassword,
            "passwordToken": token
          }));

      if (response.statusCode == 200) {
        return ("");
      } else {
        return ('Api call success, but error happened , password not changed');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check internet connectivity');
        } else if (e.response!.statusCode == 400) {
          return ("e.response!.data['errorInfo']");
        } else if (e.response!.statusCode == 404) {
          // log('No chats found');
          return (e.response!.data['errorInfo']);
        } else if (e.response!.statusCode == 500) {
          return (e.response!.data['errorInfo']);
        } else {
          return ('Some error excpt');
        }
      } else {
        return ('Password reset failed');
      }
    }
  }
}
