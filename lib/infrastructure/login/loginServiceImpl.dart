import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/error/create_error.dart';
import 'package:appoint_medic/domain/login_service.dart';
import 'package:appoint_medic/domain/response_models/admin/admin_response/admin_response.dart';
import 'package:appoint_medic/domain/response_models/doctor_response/doctor_response.dart';
import 'package:appoint_medic/domain/response_models/logout/logout_response/logout_response.dart';
import 'package:appoint_medic/domain/response_models/patient/patient_response/patient_response.dart';
import 'package:dio/dio.dart';

class LoginServiceImpl implements LoginService {
  @override
  Future<(String, dynamic)> loginButton(
      {required String password,
      required String email,
      required String logintype}) async {
    String apiEndPoint = '';

    dynamic responseData;
    try {
      if (logintype == 'patient') {
        apiEndPoint = ApiEndPoints.patientLogin;
      } else if (logintype == 'doctor') {
        apiEndPoint = ApiEndPoints.doctorLogin;
      }
      final dio = Dio();

      //-------------------------------------------------------function to send login request
      final response = await dio.post(
        apiEndPoint,
        data: json.encode({
          'email': email,
          'password': password,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      //-----------------------------------------------------------------------response handling with respect to logintype
      if (response.statusCode == 200) {
        // ---------------------------------------------------------------------Successful login

        if (logintype == 'admin') {
          log('admin called service imple');
          responseData = AdminResponse.fromJson(response.data);
        } else if (logintype == 'patient') {
          responseData = PatientResponse.fromJson(response.data);
        } else if (logintype == 'doctor') {
          responseData = DoctorResponse.fromJson(response.data);
        }

        return ("", responseData);
      } else {
        // Handle the API error response
        final errorData = json.decode(response.data);
        log('Error: ${errorData['errorInfo']}');
        return ("Error occured ", null);
      }
    } catch (error) {
      // Handle any exceptions or network errors
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
      } else {
        // Handle other errors
        print('Unknown error occurred: $error');
      }

      print('Erroraaa: $error');
      return ("Error occured ", null);
    }
  }

  @override
  Future<(String, LogoutResponse?)> logoutButton({required String role}) async {
    String apiEndPoint = '';

    log('loggedout service api call reached');

    try {
      if (role == 'patient') {
        apiEndPoint = ApiEndPoints.patientLogOut;
      } else if (role == 'doctor') {
        apiEndPoint = ApiEndPoints.doctorLogout;
      }
      final dio = Dio();
      final response = await dio.get(
        apiEndPoint,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        // Successful logout
        final responseData = LogoutResponse.fromJson(response.data);

        log('sucess service api call reached');

        return ("", responseData);
      } else {
        return ("Error occured ", null);
      }
    } catch (error) {
      // Handle any exceptions or network errors
      print('Error: $error');
      return ("Error occured ", null);
    }
  }
}

// @LazySingleton(as: DownloadService)
// class DownloadServiceImpl implements DownloadService {
//   @override
//   Future<Either<MainFailure, DownloadModel>> getDownloadsImages() async {
//     try {
//       final Response response =
//           await Dio(BaseOptions()).get(ApiEndPoints.downloads);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final result = DownloadModel.fromJson(response.data);

//         return Right(result);
//       } else {
//         return left(const MainFailure.serverFailure());
//       }
//     } catch (e) {
//       log(e.toString());
//       return left(const MainFailure.clientFailure());
//     }
//   }
// }
