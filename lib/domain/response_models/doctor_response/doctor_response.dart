import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'doctor_response.g.dart';

@JsonSerializable()
class DoctorResponse {
  bool? success;
  User? user;

  DoctorResponse({this.success, this.user});

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return _$DoctorResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);
}
