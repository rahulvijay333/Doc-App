import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/error/create_error.dart';
import 'package:appoint_medic/domain/models/onboardingDoctor/doctor_onb_model.dart';
import 'package:appoint_medic/domain/models/onboardingPatient/patient_onb_model.dart';
import 'package:appoint_medic/domain/new_user/new_user.dart';
import 'package:appoint_medic/domain/registeration.dart';
import 'package:appoint_medic/domain/response_models/onboarding_sucess_response_model/onboarding_sucess_response_model.dart';
import 'package:appoint_medic/domain/response_models/signup/new_user_response/new_user_response.dart';
import 'package:dio/dio.dart';

class CreateServiceImpl implements CreateAccountService {
  @override
  Future<(String, NewUserResponse?)> createAccount(
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

//------------------------------------------------------------------------patient
  @override
  Future<(String, OnboardingSucessResponseModel?)> onboardingPatient({
    required String token,
    required PatientProfileFormData patientForm,
  }) async {
    try {
      // FormData formData = FormData();

      // Add profile picture as a file field
      // formData.files.add(MapEntry('profilePic',
      //     await MultipartFile.fromFile(patientForm.profilePic.path)));

      final Response response = await Dio().put(ApiEndPoints.onboardingPatient,
          data: jsonEncode({
            "username": patientForm.username,
            "gender": patientForm.gender,
            "phone": patientForm.phone,
            "houseName": patientForm.houseName,
            "city": patientForm.city,
            "state": patientForm.state,
          }),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              // 'Content-Type': 'multipart/form-data'
            },
          ));

      if (response.statusCode == 200) {
        try {
          final responseData =
              OnboardingSucessResponseModel.fromJson(response.data);
        } catch (e) {
          log('Error parsing response of onboarding');
          return ('Error in parsing', null);
        }
        log('Saved success updated');

        return ('', OnboardingSucessResponseModel.fromJson(response.data));
      } else {
        return ("Error", null);
      }
    } catch (error) {
      if (error is DioException) {
        if (error.error is SocketException) {
          // Handle socket error here
          log('Socket error occurred: ${error.error}');

          return ('Error connecting to end point', null);
        } else {
          log('Dio error occurred: $error');
          return (error.toString(), null);
        }
      }

      log(error.toString());
      log('Error is onboarding service implementation call');

      return ('Some error occurred in api call', null);
    }
  }

//-------------------------------------doctor
  @override
  Future<(String, OnboardingSucessResponseModel?)> onboardingDoctor({
    required String token,
    required DoctorProfileFormData doctorForm,
  }) async {
    try {
    

      log(ApiEndPoints.onboardingDoctor.toString());

      final Response response = await Dio().put(ApiEndPoints.onboardingDoctor,
          data: jsonEncode({
             "username": doctorForm.username,
             "gender": doctorForm.gender,
            "speciality": doctorForm.speciality,
            "phone": doctorForm.phone,
            "houseName": doctorForm.houseName,
            "city": doctorForm.city,
            "state": doctorForm.state,
            "services": doctorForm.services,
            "qualification": doctorForm.qualification,
          }),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        try {
          final responseData =
              OnboardingSucessResponseModel.fromJson(response.data);
        } catch (e) {
          log('Error parsing response of onboarding');
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
          log('Socket error occurred: ${error.error}');

          return ('Error connecting to end point', null);
        } else {
          log('Dio error occurred: $error');
          return (error.toString(), null);
        }
      }

      log(error.toString());
      log('Error is onboarding service implementation call');

      return ('Some error occurred in api call', null);
    }
  }
}
