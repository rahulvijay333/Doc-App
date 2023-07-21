import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'patient_response.g.dart';

@JsonSerializable()
class PatientResponse {
  bool? success;
  User? user;

  PatientResponse({this.success, this.user});

  factory PatientResponse.fromJson(Map<String, dynamic> json) {
    return _$PatientResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PatientResponseToJson(this);
}
