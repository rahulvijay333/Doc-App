import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/error/create_error.dart';
import 'package:appoint_medic/domain/models/onboardingDoctor/doctor_onb_model.dart';
import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/domain/response_models/onboarding_sucess_response_model/onboarding_sucess_response_model.dart';
import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

import '../../domain/response_models/create account/create_new_acount_response/create_new_acount_response.dart';

class CreateServiceImpl {
  Future<String> createAccount(
      {required CreateUserModel user, required String userType}) async {
    String apiEndPoint = '';

    try {
      if (userType == 'doctor') {
        apiEndPoint = ApiEndPoints.doctorNewUser;
      } else if (userType == 'patient') {
        apiEndPoint = ApiEndPoints.patientRegister;
      }

      final dio = Dio();

      //-------------------------------------------------------function to send registerion request

      final response = await dio.post(
        apiEndPoint,
        data: json.encode({
          "name": user.name,
          "email": user.email,
          "password": user.password,
        }),
      );

      //---------------------------------------------------------reponse checking

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ('');
      } else {
        return ('Error in service implemention');
      }
      //----------------------------------------error - verify admin or email verify
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          // Handle socket error here

          return ('Error connecting to end point');
        } else {
          final errorModel = CreateError.fromJson(error.response!.data);

          return (errorModel.error);
        }
      }

      return ('Some error occurred in api call');
    }
  }

  // //otp verify
  Future<String> verifyEmailOtp(
      {required String userType,
      required String userEmail,
      required userOTP}) async {
    String apiEndPoint = '';

    try {
      if (userType == 'patient') {
        apiEndPoint = ApiEndPoints.patientOtpVerify;
      } else {
        apiEndPoint = ApiEndPoints.doctorOtpVerify;
      }

      log(apiEndPoint);

      final Response response = await Dio().put(apiEndPoint,
          data: jsonEncode({"email": userEmail, "otp": userOTP}));

      log(response.data.toString());

      if (response.statusCode == 200) {
        return ('');
      } else {
        return ('Error occured in otp verification');
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          return ('Server connectivity issue ');
        } else {
          final errorModel = DisplayErrorOtp.fromJson(error.response!.data);

          return (errorModel.errorMessage);
        }
      } else {
        return ('Error occured in OTP verification');
      }
    }
  }

  //oneboarding function changed to profile update
//------------------------------------------------------------------------patient

  Future<String> onboardingPatient({
    required FormData patientForm,
  }) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response = await Dio().put(ApiEndPoints.onboardingPatient,
          data: patientForm,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        log('Patient profile updated');

        return ('');
      } else {
        return ("Error");
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          log('Socket error occurred: ${error.error}');

          return ('Error connecting to end point');
        } else {
          log('Dio error occurred: $error');
          return (error.toString());
        }
      }

      log(error.toString());
      log('Error is onboarding service implementation call');

      return ('Some error occurred in api call');
    }
  }

//-------------------------------------doctor

  Future<(String, OnboardingSucessResponseModel?)> onboardingDoctor({
    required String token,
    required DoctorProfileFormData doctorForm,
  }) async {
    try {
      final Response response = await Dio().put(ApiEndPoints.onboardingDoctor,
          data: doctorForm.toFormData(),
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }, contentType: 'multipart/form-data'));

      if (response.statusCode == 200) {
        try {
          final responseData =
              OnboardingSucessResponseModel.fromJson(response.data);
        } catch (e) {
          return ('Error in parsing', null);
        }

        return ('', OnboardingSucessResponseModel.fromJson(response.data));
      } else {
        return ("Error in parsing area", null);
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          // Handle socket error here

          return ('Error connecting to end point', null);
        } else {
          return (error.toString(), null);
        }
      }

      return ('Some error occurred in api call', null);
    }
  }

//------------------------------------------------------------------------------doctor profile edit

  Future<String> editProfileDoctor({required FormData doctorForm}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response = await Dio().put(ApiEndPoints.profileEditDoctor,
          data: doctorForm,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }, contentType: 'multipart/form-data'));

      if (response.statusCode == 200) {
        return ('');
      } else {
        return ("Error in parsing area");
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          // Handle socket error here

          return ('Error connecting to end point');
        } else {
          return (error.toString());
        }
      }

      return ('Some error occurred in api call');
    }
  }
}
