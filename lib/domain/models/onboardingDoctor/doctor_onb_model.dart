import 'dart:io';

import 'package:dio/dio.dart';

class DoctorProfileFormData {
  String username;
  String gender;
  String speciality;
  String phone;
  String houseName;
  String city;
  String state;
  String? services;
  String qualification;
  File? profilePic;
  File? certificate;

  DoctorProfileFormData({
    required this.username,
    required this.gender,
    required this.speciality,
    required this.phone,
    required this.houseName,
    required this.city,
    required this.state,
    this.services,
    required this.qualification,
    this.profilePic,
    this.certificate,
  });
  FormData toFormData() {
    return FormData.fromMap({
      'username': username,
      'gender': gender,
      'speciality': speciality,
      'phone': phone,
      'houseName': houseName,
      'city': city,
      'state': state,
      'services': services,
      'qualification': qualification,
      'profilePic': profilePic == null
          ? null
          : MultipartFile.fromFileSync(profilePic!.path),
      'certificate': certificate == null
          ? null
          : MultipartFile.fromFileSync(
              certificate!.path,
            ),
    });
  }
}
