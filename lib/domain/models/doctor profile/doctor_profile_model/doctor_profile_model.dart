import 'package:json_annotation/json_annotation.dart';

import 'doctor.dart';

part 'doctor_profile_model.g.dart';

@JsonSerializable()
class DoctorProfileModel {
  Doctor? doctor;

  DoctorProfileModel({this.doctor});

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) {
    return _$DoctorProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DoctorProfileModelToJson(this);
}
