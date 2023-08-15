import 'dart:io';

import 'package:dio/dio.dart';

class PatientProfileFormData {
  String username;
  String gender;
  String phone;
  String houseName;
  String city;
  String state;
  File? profilePic;

  PatientProfileFormData({
    required this.username,
    required this.gender,
    required this.phone,
    required this.houseName,
    required this.city,
    required this.state,
    required this.profilePic,
  });

  FormData toFormData() {
    return FormData.fromMap({
      'username': username,
      'gender': gender,
      'phone': phone,
      'houseName': houseName,
      'city': city,
      'state': state,
      'profilePic': profilePic == null
          ? null
          : MultipartFile.fromFileSync(
              profilePic!.path,
            ),
    });
  }
}
