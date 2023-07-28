import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/response_models/profile_model/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileService {
  Future<(String, ProfileModel?)> getProfileDetails(
      {required String id}) async {
    try {
      final dio = Dio();

      final Response response =
          await dio.get('${ApiEndPoints.getProfileDetails}$id');

      if (response.statusCode == 200) {
        return ('', ProfileModel.fromJson(response.data));
      } else {
        return ('Some error service ', null);
      }
    } catch (error) {
      if (error is DioException) {
        if (error is SocketException) {
          return ('Server connection failed', null);
        } else if (error.response!.statusCode == 500) {
          return ('Issue with server', null);
        } else {
          return ('Some error excpt', null);
        }
      }
      return ('Some error excpt', null);
    }
  }
}
