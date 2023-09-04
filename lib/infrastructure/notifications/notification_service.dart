import 'dart:developer';
import 'dart:io';

import 'package:appoint_medic/core/api_endPoints/api_endpoints.dart';
import 'package:appoint_medic/domain/models/notifications/notification_response/notification.dart';
import 'package:appoint_medic/domain/models/notifications/notification_response/notification_response.dart';

import 'package:appoint_medic/domain/token_storage/secure_storage.dart';
import 'package:appoint_medic/main.dart';
import 'package:dio/dio.dart';

class NotificationService {
  Future<(String, NotificationResponse?)> getAllNotifications(
      {required String userType}) async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      String user = userType == 'patient'
          ? ApiEndPoints.getNotificationsPatient
          : ApiEndPoints.getNotificationsDoctor;

      final Response response = await Dio().get(user,
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (response.statusCode == 200) {
        try {
          final List<dynamic>? notificationData = response.data['notification'];
          if (notificationData != null) {
            return ('', NotificationResponse.fromJson(response.data));
          } else {
            return ('', null);
          }
        } catch (e) {
          log('Error parsing data');
          return ('', null);
        }
      } else if (response.statusCode == 202) {
        return ('', NotificationResponse.fromJson(response.data));
      } else {
        return ('Error happened', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check Internet Connection', null);
        } else if (e.response?.statusCode == 500) {
          return (e.message.toString(), null);
        } else {
          return ('Some error excpt', null);
        }
      } else {
        return ('Api call Error in notification service', null);
      }
    }
  }

  Future<String> markReadNotification() async {
    final SecureStorageService getToken = getIt<SecureStorageService>();
    final String? token = await getToken.retrieveToken();

    try {
      final Response response =
          await Dio().put(ApiEndPoints.notificationMarkread,
              options: Options(
                headers: {'Authorization': 'Bearer $token'},
              ));

      if (response.statusCode == 200) {
        log(' marking read success');
        return ('');
      } else {
        log('error in marking read');
        return ('Error happened while marking notifiactions as read');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Check Internet Connection');
        } else if (e.response?.statusCode == 500) {
          return (e.message.toString());
        } else {
          return ('Some error excpt');
        }
      } else {
        return ('Api call Error in notification service');
      }
    }
  }
}
